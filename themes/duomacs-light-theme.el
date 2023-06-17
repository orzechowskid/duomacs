;;; duomacs-light-theme.el --- duomacs light theme -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(deftheme duomacs-light "A light theme for Duomacs, based on the Materialize palette.")

;; palette colors

(defconst duomacs--color-gray-100 "#212121")
(defconst duomacs--color-gray-200 "#424242")
(defconst duomacs--color-gray-300 "#616161")
(defconst duomacs--color-gray-400 "#757575")
(defconst duomacs--color-gray-500 "#9e9e9e")
(defconst duomacs--color-gray-600 "#bdbdbd")
(defconst duomacs--color-gray-700 "#e0e0e0")
(defconst duomacs--color-gray-800 "#f4f4f4")
(defconst duomacs--color-gray-900 "#fafafa")

(defconst duomacs--color-red-100 "#b71c1c")
(defconst duomacs--color-red-200 "#c62828")
(defconst duomacs--color-red-300 "#d32f2f")
(defconst duomacs--color-red-400 "#e53935")
(defconst duomacs--color-red-500 "#f44336")
(defconst duomacs--color-red-600 "#ef5350")
(defconst duomacs--color-red-700 "#e57373")
(defconst duomacs--color-red-800 "#ef9a9a")
(defconst duomacs--color-red-900 "#ffcdd2")

(defconst duomacs--color-orange-100 "#ff8c00")
(defconst duomacs--color-orange-200 "#ff8c00")
(defconst duomacs--color-orange-300 "#ff8c00")
(defconst duomacs--color-orange-400 "#ff8c00")
(defconst duomacs--color-orange-500 "#ff8c00")
(defconst duomacs--color-orange-600 "#ff8c00")
(defconst duomacs--color-orange-700 "#ff8c00")
(defconst duomacs--color-orange-800 "#ff8c00")
(defconst duomacs--color-orange-900 "#fff3e0")

(defconst duomacs--color-green-100 "#556b2f")
(defconst duomacs--color-green-200 "#6b8e23")
(defconst duomacs--color-green-300 "#32cd32")

(defconst duomacs--color-blue-100 "#263238")
(defconst duomacs--color-blue-200 "#37474f")
(defconst duomacs--color-blue-300 "#455a64")
(defconst duomacs--color-blue-400 "#546e7a")
(defconst duomacs--color-blue-500 "#607d8b")
(defconst duomacs--color-blue-600 "#78909c")
(defconst duomacs--color-blue-700 "#90a4ae")
(defconst duomacs--color-blue-800 "#b0bec5")
(defconst duomacs--color-blue-900 "#E2E7EA")

;; semantic variables

(defconst duomacs-color-background duomacs--color-gray-900
  "Preferred default background color.")
(defconst duomacs-color-background-highlight-permanent duomacs--color-gray-700
  "Preferred background color for long-lived background elements.")
(defconst duomacs-color-background-highlight-transient duomacs--color-blue-900
  "Preferred background color for temporary elements created via user-action.")
(defconst duomacs-color-background-secondary duomacs--color-blue-600)
(defconst duomacs-color-background-tertiary duomacs--color-blue-800)
(defconst duomacs-color-comment duomacs--color-green-200)
(defconst duomacs-color-constant duomacs--color-blue-300)
(defconst duomacs-color-foreground duomacs--color-gray-200)
(defconst duomacs-color-foreground-secondary duomacs--color-gray-600)
(defconst duomacs-color-foreground-tertiary duomacs--color-gray-500)
(defconst duomacs-color-error duomacs--color-red-300)
(defconst duomacs-color-info duomacs--color-blue-300)
(defconst duomacs-color-keyword duomacs--color-blue-500)
(defconst duomacs-color-typedef duomacs--color-blue-300)
(defconst duomacs-color-string duomacs--color-red-100)
(defconst duomacs-color-warning duomacs--color-orange-200)

(custom-theme-set-faces
 'duomacs-light
 `(compilation-error ((t (:foreground ,duomacs-color-error))))
 `(compilation-info ((t (:foreground ,duomacs-color-info))))
 `(compilation-warning ((t (:foreground ,duomacs-color-warning))))
 `(cursor ((t (:background ,duomacs-color-foreground))))
 `(default ((t (:foreground ,duomacs-color-foreground :background ,duomacs-color-background))))
 `(error ((t (:foreground ,duomacs-color-error))))
 `(fill-column-indicator ((t (:foreground ,duomacs-color-background-highlight-permanent))))
 `(fringe ((t (:background ,duomacs-color-background))))
 `(highlight ((t (:background ,duomacs-color-background-highlight-permanent))))
 `(isearch ((t (:background ,duomacs-color-background-highlight-transient :weight bold))))
 `(lazy-highlight ((t (:background ,duomacs-color-background-highlight-transient))))
 `(line-number ((t (:foreground ,duomacs-color-foreground-tertiary))))
 `(minibuffer-prompt ((t (:foreground ,duomacs--color-gray-200 :weight bold))))
 `(mode-line ((t (:foreground ,duomacs--color-gray-900 :background ,duomacs--color-blue-400))))
 `(mode-line-inactive ((t (:background ,duomacs-color-background-tertiary))))
 `(region ((t (:background ,duomacs-color-background-highlight-transient))))
 `(show-paren-match ((t (:background ,duomacs-color-background-highlight-transient))))

 `(flymake-error ((t (:underline (:color ,duomacs-color-error :style wave)))))
 `(flymake-note ((t (:underline (:color ,duomacs-color-info :style wave)))))
 `(flymake-warning ((t (:underline (:color ,duomacs-color-warning :style wave)))))

 `(font-lock-comment-face ((t (:foreground ,duomacs-color-comment))))
 `(font-lock-constant-face ((t (:foreground ,duomacs-color-constant))))
 `(font-lock-doc-face ((t (:foreground ,duomacs-color-comment))))
 `(font-lock-keyword-face ((t (:foreground ,duomacs-color-keyword))))
 `(font-lock-string-face ((t (:foreground ,duomacs-color-string))))
 `(font-lock-type-face ((t (:foreground ,duomacs-color-typedef))))
 `(font-lock-variable-name-face ((t (:foreground ,duomacs-color-foreground))))

 `(corfu-current ((t (:foreground ,duomacs-color-foreground :background ,duomacs-color-background-highlight-transient))))

 `(marginalia-documentation ((t (:foreground ,duomacs-color-foreground-tertiary :underline nil))))

 `(orderless-match-face-0 ((t (:weight bold))))
 `(orderless-match-face-1 ((t (:weight bold))))
 `(orderless-match-face-2 ((t (:weight bold))))
 `(orderless-match-face-3 ((t (:weight bold))))
 )

(provide-theme 'duomacs-light)

(provide 'duomacs-light-theme)

;;; duomacs-light-theme.el ends here
