;;; duomacs-custom.el --- duomacs feature customization setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defgroup duomacs nil
  "Group containing options to customize duomacs directly."
  :prefix "duomacs-")

(defcustom duomacs-theme
  'vs-dark-theme
  "Selected theme."
  :group 'duomacs
  :type '(choice (const :tag "VS Light" vs-light-theme)
		 (const :tag "VS Dark" vs-dark-theme))
  :set (lambda (sym val)
	 (if (boundp sym)
	     (let ((old-val duomacs-theme))
	       (set-default-toplevel-value sym val)
	       (when (not (equal old-val val))
		 (funcall val)))
	   (progn
	     (set-default-toplevel-value sym val)
	     (funcall val)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode nil)
 '(auto-encryption-mode nil)
 '(blink-cursor-mode nil)
 '(create-lockfiles nil)
 '(cua-mode t)
 '(dirtrack-mode nil)
 '(fill-column 99)
 '(fringe-mode 0 nil (fringe))
 '(inhibit-startup-echo-area-message (user-login-name))
 '(inhibit-startup-screen t)
 '(marginalia-mode t)
 '(recentf-menu-before "--")
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(selectrum-mode t)
 '(show-paren-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil))

(provide 'duomacs-custom)

;;; duomacs-custom.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
