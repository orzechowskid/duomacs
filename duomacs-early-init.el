;;; duomacs-early-init.el --- duomacs early-init setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;;
;;; This file is intended to be used as an Emacs early-init.el file.
;;;
;;; Code:

;; disable the built-in package manager; we use use-package plus straight.el
(setq package-enable-at-startup nil)

;; set some default parameters for frames
(setq
 default-frame-alist
 '((horizontal-scroll-bars . nil)
   (internal-border-width . 8)
   (scroll-bar-width . 0)
   (tool-bar-lines . 0)
   (vertical-scroll-bars . nil)))

;;; duomacs-early-init.el ends here
