;;; duomacs-org.el --- duomacs setup for org-mode -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  org
  :straight (:type built-in)
  :delight
  :custom
  (org-default-notes-file "~/notes")
  (org-agenda-files
   ("~/org/" "~/org/journal/"))
  :custom-face
  (org-level-1 ((t (:weight semi-bold :height 1.2 :family "Cantarell")))))

(use-package
  org-popup-posframe
  :straight
  '(org-popup-posframe :type git :host github :repo "A7R7/org-popup-posframe")
  :defer
  :delight)

(use-package
  org-journal
  :straight t
  :delight
  :custom
  (org-journal-file-format "%Y%m%d.org")
  (org-journal-dir "~/org/journal")
  (org-journal-date-format "%A, %d %B %Y"))

;;; duomacs-org.el ends here
(provide 'duomacs-org)
