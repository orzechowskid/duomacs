;;; elisp.el --- duomacs setup for Emacs Lisp -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:


(require 'flymake)

(defun duomacs-elisp-setup ()
  "Internal function.  Configures elisp major mode."
  (flymake-mode t))


(easy-menu-define nil emacs-lisp-mode-map nil (list "Emacs-Lisp" :visible nil))

(add-hook
 'emacs-lisp-mode-hook
 'duomacs-elisp-setup)


(provide 'duomacs-elisp)
;;; duomacs-elisp.el ends here
