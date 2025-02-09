;;; duomacs-init.el --- duomacs init setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;;
;;; This file is intended to be used as an Emacs init.el file.
;;;
;;; Code:

(defgroup duomacs nil
  "Group containing options to customize duomacs directly."
  :group 'personalization
  :prefix "duomacs-")

(defconst duomacs-root
 (file-name-directory
  (file-truename
   (or load-file-name
       (buffer-file-name))))
 "Absolute path to the root duomacs directory.")

(add-to-list 'load-path duomacs-root)

;; speedier handling of large LSP messages
(when (functionp 'json-serialize)
  (setq read-process-output-max (* 1024 1024 8)))

;; try real hard to use UTF-8 everywhere all the time
;; (some of this might be unnecessary and/or deprecated)
(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq
 locale-coding-system 'utf-8
 default-process-coding-system '(utf-8-unix . utf-8-unix))

(when load-file-name
  (add-to-list
   'custom-theme-load-path
   (concat
    duomacs-root
    "themes")))

;; tell emacs where to find our themes
(setq
 custom-safe-themes t)
(add-to-list 'custom-theme-load-path (concat duomacs-root "themes/"))

;; load user preferences if they exist, or fall back to our own defaults when
;; they don't
(setq
 custom-file (concat (if user-init-file
												 (file-name-directory user-init-file)
											 "~/")
										 "duomacs-custom.el"))
(if (file-exists-p custom-file)
    (load-file custom-file)
  (require 'duomacs-custom))

(require 'duomacs-pkg-mgmt)
(require 'duomacs-modeline)
(require 'duomacs-keys)

(provide 'duomacs-init)
;;; duomacs-init.el ends here
