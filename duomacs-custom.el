;;; duomacs-custom.el --- duomacs feature customization defaults -*- lexical-binding: t; -*-
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
 '(auto-save-file-name-transforms `((".*" "~/.emacs.d/backup/" t)))
 '(backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacs.d/backup/"))))
 '(blink-cursor-mode nil)
 '(create-lockfiles nil)
 '(cua-mode t)
 '(dirtrack-mode nil)
 '(display-line-numbers-grow-only t)
 '(editorconfig-mode t)
 '(eglot-events-buffer-size 0)
 '(eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)
 '(fill-column 80)
 '(inhibit-startup-echo-area-message (user-login-name))
 '(inhibit-startup-screen t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(2 ((shift) . hscroll) ((meta)) ((control) . text-scale)))
 '(recentf-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(scroll-margin 1)
 '(show-paren-mode t)
 '(subword-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil)
 '(use-package-always-ensure t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 128 :width normal :foundry "ADBO" :family "SauceCodePro Nerd Font")))))

(provide 'duomacs-custom)
;;; duomacs-custom.el ends here
