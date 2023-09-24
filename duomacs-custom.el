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
 '(auto-save-file-name-transforms ((".*" "~/.emacs.d/backup/" t)))
 '(backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacs.d/backup/"))))
 '(blink-cursor-mode nil)
 '(consult-buffer-sources '(consult--source-hidden-buffer consult--source-buffer))
 '(coverlay:mark-tested-lines nil)
 '(create-lockfiles nil)
 '(cua-mode t)
 '(custom-safe-themes t)
 '(dirtrack-mode nil)
 '(file-name-shadow-properties
   '(invisible t intangible t face file-name-shadow field shadow))
 '(fill-column 80)
 '(fringe-mode '(24 . 0) nil (fringe))
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message (user-login-name))
 '(inhibit-startup-screen t)
 '(marginalia-mode t)
 '(markdown-header-scaling t)
 '(markdown-header-scaling-values '(1.7 1.5 1.3 1.1 1.0 1.0))
 '(mouse-wheel-progressive-speed nil)
 '(projectile-show-menu nil)
 '(recentf-menu-path nil)
 '(recentf-menu-title nil)
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(selectrum-mode t)
 '(show-paren-mode nil)
 '(tab-width 2)
 '(tooltip-mode nil)
 '(use-dialog-box nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2E3440" :foreground "#D8DEE9" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "ADBE" :family "Source Code Pro"))))
 '(fringe ((t (:background unspecified))))
 '(line-number ((t (:inherit (shadow default) :foreground "#616e88" :weight light))))
 '(markdown-code-face ((t (:inherit nil :extend t :background "burlywood" :foreground "#222222"))))
 '(mode-line ((t (:background "grey75" :foreground "#1e1e1e"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :weight light)))))

(provide 'duomacs-custom)
;;; duomacs-custom.el ends here
