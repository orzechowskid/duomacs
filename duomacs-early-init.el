;;; duomacs-early-init.el --- duomacs early-init setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;;
;;; This file is intended to be used as an Emacs early-init.el file.
;;;
;;; Code:

;; do no garbage collection during startup...
(setq gc-cons-threshold most-positive-fixnum)
;; ...then set the GC limit to something suitable for modern machines
(add-hook
 'after-init-hook
 (lambda ()
   (setq gc-cons-threshold (* 1024 1024 32))))

(setq
 ;; set some default parameters for top-level frames
 default-frame-alist '((horizontal-scroll-bars . nil)
		       (internal-border-width . 16)
		       (scroll-bar-width . 0)
		       (tool-bar-lines . 0)
		       (menu-bar-lines . 0)
		       (vertical-scroll-bars . nil))
 fringe-mode '(24 . 0)
 ;; Vertical window divider
 window-divider-default-right-width 24
 window-divider-default-places 'right-only)

;; can be Customized, but we want it to apply immediately so do it manually here
(window-divider-mode 1)

;;; duomacs-early-init.el ends here
