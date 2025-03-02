;;; duomacs-themes.el --- duomacs theme setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

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

(defvar duomacs--themes-hooks nil
  "A theme -> hook mapping.")

(defun duomacs--themes-add-hook (theme hook-fn)
  "Add HOOK-FN for theme THEME."
  (add-to-list 'duomacs--themes-hook (cons theme hook-fn)))

(defun duomacs--themes-disable-all ()
  "Disable all currently-enabled themes."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defun duomacs--themes-enable-theme-advice (f theme)
  "Around advice for `enable-theme` (F).  THEME is the current theme."
  (if (eq theme 'user)
      (apply f theme nil)
    (duomacs--themes-disable-all)
    (prog1
        (apply f theme nil) ;; prog1: return this value but do the following side-effects
      (pcase (assq theme duomacs--themes-hooks)
        (`((,_ . ,f) (funcall f))))))

  (advice-add 'enable-theme
              :around
              #'duomacs--themes-enable-theme-advice))

(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
