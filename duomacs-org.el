;;; duomacs-org.el --- duomacs setup for org-mode -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  org-journal
  :straight t
  :delight
  :config
  (setq org-journal-dir "~/org/journal")
  (setq org-journal-date-format "%A, %d %B %Y"))

(provide 'duomacs-org)
