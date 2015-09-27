#lang racket
(require rnrs/bytevectors-6)

(define cell 4) ;; unit byte

(define memory:size (* 64 1024 1024))
(define memory (make-bytevector memory:size 0))

(define memory:get
  (lambda (index #:size [size cell])
    (bytevector-uint-ref memory index (native-endianness) size)))

(define memory:set
  (lambda (index value #:size [size cell])
    (bytevector-uint-set! memory index value (native-endianness) size)))

(define memory:current-free-address 0)

(define allocate-memory
  (lambda (size)
    (let ([return-address memory:current-free-address])
      (set! memory:current-free-address
            (+ memory:current-free-address size))
      return-address)))

(allocate-memory (* 1024)) ;; 1k safe underflow
(define argument-stack:address (allocate-memory (* 1 1024 1024)))
(define argument-stack:current-free-address argument-stack:address)

(define argument-stack:push
  (lambda (value)
    (memory:set argument-stack:current-free-address value)
    (set! argument-stack:current-free-address
          (+ argument-stack:current-free-address cell))))

(define argument-stack:pop
  (lambda ()
    (set! argument-stack:current-free-address
          (- argument-stack:current-free-address cell))
    (memory:get argument-stack:current-free-address)))

(define argument-stack:tos
  (lambda ()
    (memory:get (- argument-stack:current-free-address cell))))

(allocate-memory (* 1024)) ;; 1k safe underflow
(define return-stack:address (allocate-memory (* 1 1024 1024)))
(define return-stack:current-free-address return-stack:address)

(define return-stack:push
  (lambda (value)
    (memory:set return-stack:current-free-address value)
    (set! return-stack:current-free-address
          (+ return-stack:current-free-address cell))))

(define return-stack:pop
  (lambda ()
    (set! return-stack:current-free-address
          (- return-stack:current-free-address cell))
    (memory:get return-stack:current-free-address)))

(define return-stack:tos
  (lambda ()
    (memory:get (- return-stack:current-free-address cell))))

(define primitive-function-record:size (* 4 1024))
(define primitive-function-record (make-vector primitive-function-record:size 0))

(define primitive-function-counter 0)

(define primitive-function-record:get
  (lambda (index)
    (vector-ref primitive-function-record
                index)))

(define primitive-function-record:set
  (lambda (index function)
    (vector-set! primitive-function-record
                 index
                 function)))

(define create-primitive-function
  (lambda (function)
    (let ([return-address primitive-function-counter])
      (primitive-function-record:set primitive-function-counter
                                     function)
      (set! primitive-function-counter
            (+ primitive-function-counter 1))
      return-address)))

(define next:explainer-argument 0)

(define next
  (lambda ()
    (let* ([jojo (return-stack:pop)]
           [next-jojo (+ jojo cell)]
           [explainer (memory:get (memory:get jojo))]
           [explainer-argument (+ (memory:get jojo) cell)])
      (return-stack:push next-jojo)
      (set! next:explainer-argument explainer-argument)
      ((primitive-function-record:get explainer)))))

(define string-area:address (allocate-memory (* 256 1024)))
(define string-area:current-free-address string-area:address)

(define create-string
  (lambda (s)
    (let ([return-address string-area:current-free-address]
          [len (string-length s)])
      (bytevector-copy! (string->utf8 s) 0
                        memory string-area:current-free-address
                        len)
      (set! string-area:current-free-address
            (+ string-area:current-free-address len))
      return-address)))

(define in-host-name-hash-table (make-hasheq))

(define xx
  (lambda (value)
    (memory:set memory:current-free-address value)
    (set! memory:current-free-address
          (+ memory:current-free-address cell))))

(define ::
  (lambda (name-string)
    (hash-set! in-host-name-hash-table
               name-string
               memory:current-free-address)))

(define link 0)

(define primitive-function-explainer
  (create-primitive-function
   (lambda ()
     ((primitive-function-record:get (memory:get next:explainer-argument))))))

(define define-primitive-function
  (lambda (name-string function)
    (let* ([name-string-address (create-string name-string)]
           [function-index (create-primitive-function function)])
      (xx link)
      (set! link (- memory:current-free-address cell))
      (xx name-string-address)
      (xx (string-length name-string))
      (:: name-string)
      (xx primitive-function-explainer)
      (xx function-index))))

(define function-explainer
  (create-primitive-function
   (lambda ()
     (return-stack:push next:explainer-argument)
     (next))))

(define define-function
  (lambda (name-string . function-name-string-list)
    (let* ([name-string-address (create-string name-string)])
      (xx link)
      (set! link (- memory:current-free-address cell))
      (xx name-string-address)
      (xx (string-length name-string))
      (:: name-string)
      (xx function-explainer)
      (map (lambda (function-name-string)
             (xx (hash-ref in-host-name-hash-table
                           function-name-string)))
           function-name-string-list))))

(define variable-explainer
  (create-primitive-function
   (lambda ()
     (argument-stack:push (memory:get next:explainer-argument))
     (next))))

(define define-variable
  (lambda (name-string value)
    (let* ([name-string-address (create-string name-string)])
      (xx link)
      (set! link (- memory:current-free-address cell))
      (xx name-string-address)
      (xx (string-length name-string))
      (:: name-string)
      (xx variable-explainer)
      (xx value))))

(define-primitive-function "end"
  (lambda ()
    (return-stack:pop)
    (next)))

(define-primitive-function "report-return-stack-is-empty-and-exit"
  (lambda ()
    (write "return stack is empty now")))

(define-primitive-function "print-tos"
  (lambda ()
    (let* ([tos (argument-stack:pop)])
      (display tos)
      (newline)
      (next))))

(define-variable "*little-test-number*"
  3)

(define-primitive-function "bye"
  (lambda ()
    (display "bye bye ^-^/")
    (newline)))

(define-function "little-test"
  "*little-test-number*"
  "print-tos"
  "bye")

(define-function "little-test:help"
  "little-test"
  "end")

(define jojo-for-little-test
  (+ (hash-ref in-host-name-hash-table
               "little-test:help")
     cell))

(define begin-to-interpret-threaded-code
  (lambda ()
    (return-stack:push jojo-for-little-test)
    (next)))

(begin-to-interpret-threaded-code)
