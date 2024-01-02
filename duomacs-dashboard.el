;;; duomacs-dashboard.el --- duomacs dashboard setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package dashboard
  :straight t
  :init
  (dashboard-setup-startup-hook))

(provide 'duomacs-dashboard)
