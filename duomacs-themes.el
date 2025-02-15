;;; duomacs-themes.el --- duomacs themes -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'ansi-color)

(deftheme duomacs-nord "A Duomacs derivative of the Nord theme family")
(deftheme duomacs-nord-light "A Duomacs derivative of the Nord light theme family")

(defgroup duomacs-nord nil
  "Duomacs-nord theme customizations.
   These themes have to be reloaded after changing anything in this group."
  :group 'faces)

;; Nord palette colors, with variants applying to a specific theme
(setq
 ;; polar night
 nord0 "#2e3440"
 nord1 "#3b4252"
 nord2 "#434c5e"
 nord3 "#4c566a"
 ;; snow storm
 nord4 "#d8dee9"
 nord5 "#e5e9f0"
 nord6 "#eceff4"
 ;; frost
 nord7 "#8fbcbb"
 nord8 "#88c0d0"
 nord9 "#81a1c1"
 nord10 "#5e81ac"
 ;; aurora
 nord11 "#bf616a"
 nord12 "#d08770"
 nord13 "#ebcb8b"
 nord14 "#a3be8c"
 nord14-light "#70a244"
 nord15 "#b48ead")

(progn
  (custom-theme-set-faces
   'duomacs-nord
   `(default ((t (:foreground ,nord6 :background ,nord0))))
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

	 `(cov-coverage-run-face ((t (:foreground ,nord14))))
	 `(cov-coverage-not-run-face ((t (:foreground ,nord11))))
	 '(magit-section-highlight ((t (:background nil))))
   )
;;  (enable-theme 'duomacs-nord)
  )

(let ((nord14 nord14-light))
  (custom-theme-set-faces
   'duomacs-nord-light
   `(default ((t (:foreground ,nord0 :background ,nord6))))
	 `(ansi-color-blue ((t (:foreground ,nord10))))
	 `(ansi-color-green ((t (:foreground ,nord14))))
   `(error ((t (:foreground ,nord11))))
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

	 `(cov-coverage-run-face ((t (:foreground ,nord14))))
	 `(cov-coverage-not-run-face ((t (:foreground ,nord11))))
	 '(magit-section-highlight ((t (:background nil))))
   )
	(enable-theme 'duomacs-nord-light)
	)

(provide-theme 'duomacs-nord)
(provide-theme 'duomacs-nord-light)

(provide 'duomacs-themes)
;;; duomacs-themes.el ends here
