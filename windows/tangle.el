#!/usr/bin/emacs --script

(defun color-message (.color .string)
  (message
   (concat (char-to-string 27)
           "[" (number-to-string .color) ";1m"
           .string
           (char-to-string 27)
           "[0m")))

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
