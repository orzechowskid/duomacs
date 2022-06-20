;;; duomacs-themes.el --- duomacs theme setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  vs-dark-theme
  :straight t)
(use-package
  vs-light-theme
  :straight t)

(defcustom duomacs-theme
  'vs-dark-theme
  "Selected theme."
  :group 'duomacs
  :type '(choice (const :tag "VS Light" vs-light-theme)
		 (const :tag "VS Dark" vs-dark-theme))
  :set (lambda (sym val)
	 (if (boundp sym)
	     ;; changing value
	     (let ((old-val duomacs-theme))
	       (set-default-toplevel-value sym val)
	       (when (not (equal old-val val))
		 (funcall val)))
	   ;; setting initial value when emacs starts
	   (progn
	     (set-default-toplevel-value sym val)
	     (funcall val)))))

(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
