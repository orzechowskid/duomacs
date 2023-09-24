;;; duomacs-custom.el --- duomacs feature customization setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

;; use flycheck's fringe bitmap for flymake, which looks nicer on hidpi screens
(define-fringe-bitmap
  'flymake-big-indicator
  (vector #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0111000111000000
          #b0011100011100000
          #b0001110001110000
          #b0000111000111000
          #b0000011100011100
          #b0000011100011100
          #b0000111000111000
          #b0001110001110000
          #b0011100011100000
          #b0111000111000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000)
  16 16 'center)

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
 '(display-line-numbers-grow-only t)
 '(duomacs-theme 'duomacs-light)
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(fill-column 80)
 '(flymake-error-bitmap '(flymake-big-indicator compilation-error))
 '(flymake-eslint-defer-binary-check t)
 '(flymake-mode-line-format '(" ✔" flymake-mode-line-counters))
 '(flymake-note-bitmap '(flymake-big-indicator compilation-info))
 '(flymake-warning-bitmap '(flymake-big-indicator compilation-warning))
 '(fringe-mode '(24 . 0) nil (fringe))
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message (user-login-name))
 '(inhibit-startup-screen t)
 '(kind-icon-blend-background nil)
 '(kind-icon-default-face 'corfu-default)
 '(marginalia-mode t)
 '(markdown-header-scaling t)
 '(markdown-header-scaling-values '(1.7 1.5 1.3 1.1 1.0 1.0))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(2 ((shift) . hscroll) ((meta)) ((control) . text-scale)))
 '(projectile-show-menu nil)
 '(recentf-menu-path nil)
 '(recentf-menu-title nil)
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(use-dialog-box nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foundry "ADBO" :family "Source Code Pro")))))

(provide 'duomacs-custom)
;;; duomacs-custom.el ends here
