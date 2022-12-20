;;; duomacs-themes.el --- duomacs theme setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package nord-theme
  :straight t)

;; (defcustom duomacs-theme
;;   'duomacs-light-theme
;;   "Selected theme."
;;   :group 'duomacs
;;   :type '(choice (const :tag "Duomacs light" duomacs-light-theme)
;; 		 (const :tag "Duomacs dark" duomacs-dark-theme))
;;   :set (lambda (sym val)
;; 	 (if (boundp sym)
;; 	     ;; changing value
;; 	     (let ((old-val duomacs-theme))
;; 	       (set-default-toplevel-value sym val)
;; 	       (when (not (equal old-val val))
;; 		 (funcall val)))
;; 	   ;; setting initial value when emacs starts
;; 	   (progn
;; 	     (set-default-toplevel-value sym val)
;; 	     (funcall val)))))

(use-package eglot
  :straight t
  :config
  (set-face-attribute
   'eglot-diagnostic-tag-unnecessary-face
   nil
   :inherit 'unspecified)
  (set-face-attribute
   'eglot-diagnostic-tag-deprecated-face
   nil))

(let ((custom-safe-themes t))
  (load-theme 'nord))

(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
