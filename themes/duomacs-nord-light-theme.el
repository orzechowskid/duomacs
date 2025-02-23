;;; duomacs-nord-light-theme.el --- duomacs Nord light theme -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:


(require 'ansi-color)

(require 'duomacs-palette)


(deftheme duomacs-nord-light "A Duomacs derivative of the Nord light theme family")

(let ((nord7 nord7-light)
			(nord11 nord11-light)
			(nord14 nord14-light))
	(custom-theme-set-faces
   'duomacs-nord-light
	 ;; default face
   `(default ((t (:foreground ,nord0 :background ,nord6))))
	 ;; built-in faces
	 `(ansi-color-blue ((t (:foreground ,nord10))))
	 `(ansi-color-green ((t (:foreground ,nord14))))
   `(error ((t (:foreground ,nord11-light))))
   `(font-lock-bracket-face ((t (:foreground ,nord0))))
   `(font-lock-builtin-face ((t (:foreground ,nord7))))
   `(font-lock-comment-face ((t (:foreground ,nord14))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,nord14))))
   `(font-lock-constant-face ((t (:foreground ,nord2))))
   `(font-lock-doc-face ((t (:foreground ,nord14))))
   `(font-lock-escape-face ((t (:foreground ,nord13))))
   `(font-lock-keyword-face ((t (:foreground ,nord9))))
   `(font-lock-number-face ((t (:foreground ,nord15))))
   `(font-lock-property-name-face ((t (:foreground ,nord7))))
   `(font-lock-regexp-face ((t (:foreground ,nord13))))
   `(font-lock-string-face ((t (:foreground ,nord14))))
   `(font-lock-type-face ((t (:foreground ,nord7))))
   `(font-lock-warning-face ((t (:foreground ,nord13))))
   `(fringe ((t (:background ,nord6))))
   `(header-line-active ((t (:background ,nord4 :underline (:position -4) :overline t :box (:line-width (1 . 8) :color ,nord4 :style flat-button)))))
   `(header-line-inactive ((t (:background ,nord6 :underline (:position -4) :overline t :box (:line-width (1 . 8) :color ,nord6 :style flat-button)))))
   `(highlight ((t (:background ,nord4))))
   `(region ((t (:background ,nord4))))
   `(show-paren-match ((t (:background ,nord3))))
   `(success ((t (:foreground ,nord14))))
   `(tooltip ((t (:background ,nord5))))
   `(window-divider ((t (:foreground ,nord6))))
   `(window-divider-first-pixel ((t (:foreground ,nord6))))
   `(window-divider-last-pixel ((t (:foreground ,nord6))))
	 ;; third-party package faces
	 `(cov-coverage-run-face ((t (:foreground ,nord14))))
	 `(cov-coverage-not-run-face ((t (:foreground ,nord11))))
	 '(magit-section-highlight ((t (:background nil))))
   )
	(setq
	 ;; TODO: terminal fg/bg colors should be configurable, not just always
	 ;; white-on-black
	 duomacs/terminal-background-color nord0
	 duomacs/terminal-foreground-color nord6)
	;; register it
	(provide-theme 'duomacs-nord-light))

(provide 'duomacs-nord-light-theme)
;;; duomacs-nord-light-theme.el ends here
