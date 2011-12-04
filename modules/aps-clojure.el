;; Basic clojure configuration

(require 'aps-lisp)

;; To start SLIME in your Clojure project:
;; 1. lein plugin install swank-clojure 1.3.1
;; 2. Invoke M-x clojure-jack-in from a project
(require 'clojure-mode)

(defun aps-clojure-mode-hook ()
  "A hook for clojure mode"
  (aps-lisp-coding-hook))

(add-hook 'clojure-mode-hook 'aps-clojure-mode-hook)

(provide 'aps-clojure)
