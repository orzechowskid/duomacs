;;; duomacs-dashboard.el --- duomacs dashboard setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

(use-package dashboard
  :straight t
  :after (:all projectile all-the-icons)
  :custom
  (dashboard-display-icons-p t)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-icon-types 'all-the-icons)
  (dashboard-items '((recents . 5) (projects . 5) (agenda . 5)))
  (dashboard-footer-messages
   '("Editing a file inside a git repository?  Access magit with `C-x g`."
     "Need to add a TODO item to your agenda?  use `M-x org-journal-new-scheduled-entry`."
     "Want to add a new package?  Try `M-:` then `(use-package <package name>)`."))
  :init
  (dashboard-setup-startup-hook))

(provide 'duomacs-dashboard)
;;; duomacs-dashboard.el ends here
