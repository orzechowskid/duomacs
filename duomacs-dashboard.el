;;; duomacs-dashboard.el --- duomacs dashboard setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package dashboard
  :custom
  (dashboard-display-icons-p t)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-icon-types 'all-the-icons)
  (dashboard-items '((recents . 5) (projects . 5) (agenda . 5)))
  :init
  (dashboard-setup-startup-hook))

(provide 'duomacs-dashboard)
;;; duomacs-dashboard.el ends here
