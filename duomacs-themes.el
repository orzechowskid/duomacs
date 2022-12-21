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

(use-package
  nord-theme
  :straight t)

(defun duomacs/theme-change (new-theme)
  "Function run when the value of `duomacs-theme' is set to NEW-THEME.
Fills some gaps in our themes until upstream repos get patched."
  (cond
   ((eq new-theme 'vs-light)
    (custom-theme-set-faces
     'vs-light
     `(custom-button ((nil (:background "white")))))
    (setq coverlay:tested-line-background-color "#f1f1ff"
          coverlay:untested-line-background-color "LavenderBlush"))
   ((eq new-theme 'vs-dark)
    (set-face-attribute
     'line-number nil
     :background 'unspecified
     :foreground "#616e88")
    (setq coverlay:tested-line-background-color "green"
          coverlay:untested-line-background-color "tomato"))
   ((eq new-theme 'nord)
    (set-face-attribute
     'eglot-diagnostic-tag-unnecessary-face nil
     :inherit 'unspecified
     :underline '(:color "#A3BE8C" :style wave))
    (set-face-attribute
     'line-number nil
     :background 'unspecified
     :foreground (nord-theme--brightened-comment-color 25)))))


(defcustom duomacs-theme
  'vs-dark
  "Selected theme."
  :group 'duomacs
  :type '(choice (const :tag "VS Light" vs-light)
		 (const :tag "VS Dark" vs-dark)
		 (const :tag "Nord" nord))
  :set (lambda (sym val)
	 (if (boundp sym)
	     ;; changing value
	     (let ((old-val duomacs-theme))
	       (set-default-toplevel-value sym val)
	       (when (not (equal old-val val))
                 (if (functionp val)
		     (funcall val)
                   (load-theme val))
                 (duomacs/theme-change val)))
	   ;; setting initial value when emacs starts
	   (progn
	     (set-default-toplevel-value sym val)
	     (if (functionp val)
                 (funcall val)
               (load-theme val))
             (duomacs/theme-change val)))))

(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
