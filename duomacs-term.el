;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/term-mode-hook ()
  "Internal function.  Inverts colors in the terminal buffer."
    (face-remap-add-relative
   'fringe
   :inverse-video t)
  (face-remap-add-relative
   'default
   :inverse-video t)
  (face-remap-add-relative
   'term
   :inverse-video t))

(use-package eat
  :straight (:type git :host codeberg :repo "akib/emacs-eat" :files (:defaults "terminfo")))

(add-hook
 'eat-mode-hook
 #'duomacs/term-mode-hook)

(provide 'duomacs-term)
;;; duomacs-term.el ends here
