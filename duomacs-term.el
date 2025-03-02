;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'duomacs-themes)

(defun duomacs/term-mode-hook ()
  "Internal function.  Inverts some global colors for the current buffer only."
  (face-remap-add-relative
   'fringe
   :foreground duomacs-color-background
   :background duomacs-color-foreground)
  (face-remap-add-relative
   'default
   :foreground duomacs-color-background
   :background duomacs-color-foreground))

(use-package eat
  :straight (:type git :host codeberg :repo "akib/emacs-eat" :files (:defaults "terminfo"))
  ;; add some key commands which mimic real vterms
  :bind (("S-<prior>" . cua-scroll-down)
         ("S-<next>" . cua-scroll-up)))

(add-hook
 'eat-mode-hook
 #'duomacs/term-mode-hook)

(provide 'duomacs-term)
;;; duomacs-term.el ends here
