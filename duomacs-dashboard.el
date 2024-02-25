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
  :config
  (setq
   dashboard-footer-messages
   '("Editing a file inside a git repository?  Access magit with `C-x g`."
     "Want to add a new package?  Try `M-:` then `(use-package <package name>)`."))
  :init
  (setq
   dashboard-set-footer nil
   dashboard-display-icons-p t
   dashboard-set-file-icons t
   dashboard-set-heading-icons t
   dashboard-icon-type 'all-the-icons
   dashboard-items '((recents . 5) (projects . 5) (agenda . 5)))
  (dashboard-setup-startup-hook))

(provide 'duomacs-dashboard)
;;; duomacs-dashboard.el ends here
