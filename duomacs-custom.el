;;; duomacs-custom.el --- duomacs feature customization setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode nil)
 '(auto-encryption-mode nil)
 '(blink-cursor-mode nil)
 '(consult-buffer-sources '(consult--source-hidden-buffer consult--source-buffer))
 '(create-lockfiles nil)
 '(cua-mode t)
 '(dirtrack-mode nil)
 '(duomacs-theme 'vs-dark-theme)
 '(fill-column 80)
 '(fringe-mode 0)
 '(inhibit-startup-echo-area-message (user-login-name))
 '(inhibit-startup-screen t)
 '(marginalia-mode t)
 '(markdown-header-scaling t)
 '(markdown-header-scaling-values '(1.7 1.5 1.3 1.1 1.0 1.0))
 '(projectile-show-menu nil)
 '(recentf-menu-path nil)
 '(recentf-menu-title nil)
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(selectrum-mode t)
 '(show-paren-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#1e1e1e"))))
 '(markdown-code-face ((t (:inherit nil :extend t :background "burlywood" :foreground "#222222"))))
 '(mode-line ((t (:background "grey75" :foreground "#1e1e1e"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :weight light)))))

(provide 'duomacs-custom)
;;; duomacs-custom.el ends here
