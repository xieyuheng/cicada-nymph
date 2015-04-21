#!/usr/bin/emacs --script


;; foreground
;;  30 black
;;  31 red
;;  32 green
;;  33 brown
;;  34 blue
;;  35 magenta
;;  36 cyan
;;  37 white
;;  38 default-color & underscore on
;;  39 default-color & underscore off

;; 16-color foreground
;;  90 black
;;  91 red
;;  92 green
;;  93 yellow
;;  94 blue
;;  95 magenta
;;  96 cyan
;;  97 white

;; background
;;  40 black
;;  41 red
;;  42 green
;;  43 yellow
;;  44 blue
;;  45 magenta
;;  46 cyan
;;  47 white
;;  49 default color

;; 16-color background
;;  100 black
;;  101 red
;;  102 green
;;  103 yellow
;;  104 blue
;;  105 magenta
;;  106 cyan
;;  107 white

(defun color-message (.color .string)
  (message
   (concat (char-to-string 27)
           "[" (number-to-string .color) ";1m"
           .string
           (char-to-string 27)
           "[0m")))

;; (defun ghc/compile (.file-name)
;;   (cond
;;     ((equal (shell-command (concat "ls " .file-name)) 0)
;;      (color-message 93 (concat " (ghc/compile) " .file-name))
;;      (if (equal (shell-command (concat "ghc " .file-name) nil) 0)
;;          (color-message 95 "[ok]")
;;          (color-message 101 "[fail]")))
;;     (:else
;;      (color-message
;;       96
;;       (concat " (ghc/compile) [not find] " .file-name)))))

(defun org/tangle (.file-name)
  (cond
    ((equal (shell-command (concat "ls " .file-name)) 0)
     (color-message 94 (concat " (org/tangle) " .file-name))
     (find-file .file-name)
     (org-babel-tangle))
    (:else
     (color-message
      96
      (concat "(org/tangle) [not find] " .file-name)))))


(org/tangle "cicada-nymph.org")
(org/tangle "core.org")

