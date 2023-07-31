;;; duomacs-themes.el --- duomacs theme setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

;; (require 'eglot)

;; (use-package
;;   coverlay
;;   :straight t)

;; (use-package
;;   vs-dark-theme
;;   :straight t)

;; (use-package
;;   vs-light-theme
;;   :straight t)

;; (use-package
;;   nord-theme
;;   :straight t)

(require 'duomacs-light-theme)
(require 'duomacs-dark-theme)

(defcustom duomacs-theme
  'duomacs-light
  "Selected theme."
  :group 'duomacs
  :type '(choice
          (const :tag "Duomacs Light" duomacs-light)
          (const :tag "Duomacs Dark" duomacs-dark))
  :set (lambda (sym val)
	 (if (boundp sym)
	     ;; changing value
	     (let ((old-val duomacs-theme))
	       (set-default-toplevel-value sym val)
	       (when (not (equal old-val val))
                 (if (functionp val)
		     (funcall val)
                   (load-theme val))))
	   ;; setting initial value when emacs starts
	   (progn
	     (set-default-toplevel-value sym val)
	     (if (functionp val)
                 (funcall val)
               (load-theme val))))))

;; ;; use font glyphs instead of emacs' pixmaps for this
;; (assoc-delete-all 'continuation fringe-indicator-alist)


(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
