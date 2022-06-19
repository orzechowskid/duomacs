;;; duomacs-init.el --- duomacs init setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;;
;;; This file is intended to be used as an Emacs init.el file.
;;;
;;; Code:

;; memory management: perform no GC during startup, then raise the limit from the
;; default value to something more suitable for modern machines
(defvar duomacs/gc-cons-threshold (* 1024 1024 20))

(setq gc-cons-threshold most-positive-fixnum)

(add-hook
 'after-init-hook
 (lambda ()
   (setq gc-cons-threshold duomacs/gc-cons-threshold)))

(setq
 duomacs-root
 (file-name-directory
  (file-truename
   (or load-file-name
       (buffer-file-name)))))

(add-to-list 'load-path duomacs-root)

(setq custom-file (concat duomacs-root "duomacs-custom.el"))

;; try real hard to use UTF-8 everywhere all the time
;; (some of this might be unnecessary and/or deprecated)
(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(defgroup duomacs nil
  "Group containing options to customize duomacs directly."
  :prefix "duomacs-")

;; load our other packages
(require 'duomacs-pkg-mgmt)

(require 'duomacs-keys)
(require 'duomacs-menu)
(require 'duomacs-themes)
(require 'duomacs-modes)
(require 'duomacs-fonts)
(require 'duomacs-modeline)

(require 'duomacs-custom)

(provide 'duomacs-init)
;; duomacs-init.el ends here
