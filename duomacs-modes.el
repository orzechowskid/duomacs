;;; duomacs-modes.el --- duomacs mode setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/prog-mode-hook ()
  "Internal function.  Configure some things common to all programming modes."
  (display-line-numbers-mode t)
  (show-paren-mode t)
  (subword-mode t)
  (display-fill-column-indicator-mode t)
  (local-set-key (kbd "C-p") #'project-find-file))

(add-hook
 'prog-mode-hook
 #'duomacs/prog-mode-hook)

(provide 'duomacs-modes)
;;; duomacs-modes.el ends here
