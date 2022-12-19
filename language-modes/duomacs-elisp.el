;;; elisp.el --- duomacs setup for Emacs Lisp -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:


(defun duomacs-elisp-setup ()
  (flymake-mode t))


(add-hook
 'emacs-lisp-mode-hook
 'duomacs-elisp-setup)


(provide 'duomacs-elisp)
;;; elisp.el ends here
