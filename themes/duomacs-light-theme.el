;;; duomacs-light-theme.el --- duomacs light theme -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'vc-annotate)

(require 'duomacs-theme-base)

(deftheme duomacs-light "A light theme for Duomacs, based on the Materialize palette.")

;; semantic variables

(setq
 duomacs-color-background duomacs--color-gray-900
 duomacs-color-background-highlight-permanent duomacs--color-gray-700
 duomacs-color-background-highlight-transient duomacs--color-bluegray-900
 duomacs-color-background-secondary duomacs--color-bluegray-600
 duomacs-color-background-tertiary duomacs--color-bluegray-800
 duomacs-color-comment duomacs--color-green-200
 duomacs-color-constant duomacs--color-bluegray-300
 duomacs-color-foreground duomacs--color-gray-200
 duomacs-color-foreground-secondary duomacs--color-gray-600
 duomacs-color-foreground-tertiary duomacs--color-gray-500
 duomacs-color-function-call duomacs--color-bluegray-300
 duomacs-color-error duomacs--color-red-300
 duomacs-color-info duomacs--color-bluegray-300
 duomacs-color-keyword duomacs--color-bluegray-500
 duomacs-color-typedef duomacs--color-bluegray-300
 duomacs-color-string duomacs--color-red-100
 duomacs-color-warning duomacs--color-orange-200)

;; single-purpose variables

(defconst duomacs-color-foreground-mode-line duomacs--color-gray-900)
(defconst duomacs-color-background-mode-line duomacs--color-bluegray-400)

;; theme definition

(custom-theme-set-faces
 'duomacs-light
 `(compilation-error ((t (:foreground ,duomacs-color-error))))
 `(compilation-info ((t (:foreground ,duomacs-color-info))))
 `(compilation-warning ((t (:foreground ,duomacs-color-warning))))
 `(cursor ((t (:background ,duomacs-color-foreground))))
 `(default ((t (:foreground ,duomacs-color-foreground :background ,duomacs-color-background))))
 `(eglot-diagnostic-tag-unnecessary-face ((t (:underline (:color ,duomacs-color-info :style wave)))))
 `(error ((t (:foreground ,duomacs-color-error))))
 `(fill-column-indicator ((t (:foreground ,duomacs-color-background-highlight-permanent))))
 `(fringe ((t (:background ,duomacs-color-background))))
 `(highlight ((t (:background ,duomacs-color-background-highlight-permanent))))
 `(isearch ((t (:background ,duomacs-color-background-highlight-transient :weight bold))))
 `(lazy-highlight ((t (:background ,duomacs-color-background-highlight-transient))))
 `(line-number ((t (:foreground ,duomacs-color-foreground-tertiary))))
 `(minibuffer-prompt ((t (:foreground ,duomacs-color-foreground :weight bold))))
 `(mode-line ((t (:foreground ,duomacs-color-foreground-mode-line :background ,duomacs-color-background-mode-line))))
 `(mode-line-inactive ((t (:background ,duomacs-color-background-tertiary))))
 `(region ((t (:background ,duomacs-color-background-highlight-transient))))
 `(show-paren-match ((t (:background ,duomacs-color-background-highlight-transient))))

 `(cua-rectangle ((t (:background ,duomacs-color-background-highlight-transient))))

 `(eat-term-color-1 ((t (:foreground "#ff4040"))))
 `(eat-term-color-4 ((t (:foreground "#6495ed"))))
 `(eat-term-color-10 ((t (:foreground "#32a032"))))
 `(eat-term-color-12 ((t (:foreground "#6495ed"))))

 `(flymake-error ((t (:underline (:color ,duomacs-color-error :style wave)))))
 `(flymake-note ((t (:underline (:color ,duomacs-color-info :style wave)))))
 `(flymake-warning ((t (:underline (:color ,duomacs-color-warning :style wave)))))

 `(font-lock-comment-face ((t (:foreground ,duomacs-color-comment))))
 `(font-lock-constant-face ((t (:foreground ,duomacs-color-constant))))
 `(font-lock-doc-face ((t (:foreground ,duomacs-color-comment))))
 `(font-lock-function-call-face ((t (:foreground ,duomacs-color-function-call))))
 `(font-lock-function-name-face ((t (:foreground ,duomacs-color-function-call))))
 `(font-lock-keyword-face ((t (:foreground ,duomacs-color-keyword))))
 `(font-lock-string-face ((t (:foreground ,duomacs-color-string))))
 `(font-lock-type-face ((t (:foreground ,duomacs-color-typedef))))
 `(font-lock-variable-name-face ((t (:foreground ,duomacs-color-foreground))))
 `(font-lock-warning-face ((t (:foreground ,duomacs-color-warning))))

 `(smerge-base ((t (:background ,duomacs--color-yellow-900))))
 `(smerge-lower ((t (:background ,duomacs--color-green-1000))))
 `(smerge-markers ((t (:background ,duomacs--color-bluegray-900))))
 `(smerge-refined-added ((t (:background ,duomacs--color-green-800))))
 `(smerge-refined-changed ((t (:background ,duomacs--color-bluegray-900))))
 `(smerge-refined-removed ((t (:background ,duomacs--color-red-800))))
 `(smerge-upper ((t (:background ,duomacs--color-red-1000))))

 `(corfu-current ((t (:foreground ,duomacs-color-foreground :background ,duomacs-color-background-highlight-transient))))

 `(magit-section-highlight ((t (:foreground ,duomacs-color-foreground :background ,duomacs-color-background-highlight-transient))))
 
 `(marginalia-documentation ((t (:foreground ,duomacs-color-foreground-tertiary :underline nil))))

 `(markdown-header-face ((t (:foreground ,duomacs-color-foreground))))

 `(orderless-match-face-0 ((t (:weight bold))))
 `(orderless-match-face-1 ((t (:weight bold))))
 `(orderless-match-face-2 ((t (:weight bold))))
 `(orderless-match-face-3 ((t (:weight bold))))
 )

(setq
 vc-annotate-color-map
 ;; age (days) -> color
 `((7 . ,(format "%s" duomacs--color-red-1000))
   (14 . ,(format "%s" duomacs--color-orange-1000))
   (30 . ,(format "%s" duomacs--color-yellow-1000))
   (60 . ,(format "%s" duomacs--color-green-1000))
   (180 . ,(format "%s" duomacs--color-bluegray-1000))))

(when (featurep 'coverlay)
  (setq
   coverlay:tested-line-background-color duomacs--color-green-1000
   coverlay:untested-line-background-color duomacs--color-red-1000))

(provide-theme 'duomacs-light)

(provide 'duomacs-light-theme)

;;; duomacs-light-theme.el ends here
