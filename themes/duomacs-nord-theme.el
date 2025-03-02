;;; duomacs-nord-theme.el --- duomacs Nord theme -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:


(require 'ansi-color)

(require 'duomacs-palette)


(deftheme duomacs-nord "A Duomacs derivative of the Nord theme family")
(deftheme duomacs-nord-light "A Duomacs derivative of the Nord light theme family")

(defgroup duomacs-nord nil
  "Duomacs-nord theme customizations.
   Themes have to be reloaded after changing anything in this group."
  :group 'faces)

(progn
	(custom-theme-set-faces
	 'duomacs-nord
	 ;; default face
	 `(default ((t (:foreground ,nord6 :background ,nord0))))
	 ;; built-in faces
	 `(ansi-color-blue ((t (:foreground ,nord10))))
	 `(ansi-color-green ((t (:foreground ,nord14))))
	 `(error ((t (:foreground ,nord11))))
	 `(font-lock-bracket-face ((t (:foreground ,nord6))))
	 `(font-lock-builtin-face ((t (:foreground ,nord7))))
	 `(font-lock-comment-face ((t (:foreground ,nord14))))
	 `(font-lock-comment-delimiter-face ((t (:foreground ,nord14))))
	 `(font-lock-constant-face ((t (:foreground ,nord4))))
	 `(font-lock-doc-face ((t (:foreground ,nord14))))
	 `(font-lock-escape-face ((t (:foreground ,nord13))))
	 `(font-lock-keyword-face ((t (:foreground ,nord9))))
	 `(font-lock-number-face ((t (:foreground ,nord15))))
	 `(font-lock-property-name-face ((t (:foreground ,nord7))))
	 `(font-lock-regexp-face ((t (:foreground ,nord13))))
	 `(font-lock-string-face ((t (:foreground ,nord14))))
	 `(font-lock-type-face ((t (:foreground ,nord7))))
	 `(font-lock-warning-face ((t (:foreground ,nord13))))
	 `(fringe ((t (:background ,nord0))))
	 `(header-line ((t (:background ,nord0 :underline t :box (:line-width (1 . 8) :color ,nord0 :style flat-button)))))
	 `(header-line-active ((t (:background ,nord2 :underline (:position -4) :overline t :box (:line-width (1 . 8) :color ,nord2 :style flat-button)))))
	 `(header-line-inactive ((t (:background ,nord0 :underline (:position -4) :overline t :box (:line-width (1 . 8) :color ,nord0 :style flat-button)))))
	 `(highlight ((t (:background ,nord2))))
	 `(region ((t (:background ,nord2))))
	 `(show-paren-match ((t (:background ,nord3))))
	 `(success ((t (:foreground ,nord14))))
	 `(tooltip ((t (:background ,nord1))))
	 `(window-divider ((t (:foreground ,nord0))))
	 `(window-divider-first-pixel ((t (:foreground ,nord0))))
	 `(window-divider-last-pixel ((t (:foreground ,nord0))))
	 ;; third-party package faces
	 `(cov-coverage-run-face ((t (:foreground ,nord14))))
	 `(cov-coverage-not-run-face ((t (:foreground ,nord11))))
	 '(magit-section-highlight ((t (:background unspecified))))
	 )
	;; some things need to be variables, not faces
	(setq
	 duomacs/fci-color nord2
	 ;; TODO: terminal fg/bg colors should be configurable, not just always
	 ;; white-on-black
	 duomacs/terminal-background-color nord0
	 duomacs/terminal-foreground-color nord6)
	;; register it
	(provide-theme 'duomacs-nord))

(provide 'duomacs-nord-theme)
;;; duomacs-nord-theme.el ends here
