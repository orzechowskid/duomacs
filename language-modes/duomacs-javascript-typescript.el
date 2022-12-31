;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'eglot)
(require 'flymake)
(require 'treesit)

;; format on save
(use-package
  apheleia
  :delight
  :straight t
  :config
  (add-to-list
   'apheleia-mode-alist
   '(tsx-ts-mode . prettier-typescript)))

(use-package
  apheleia
  :straight t
  :config
  (add-to-list
   'apheleia-mode-alist
   '(tsx-ts-mode . prettier-typescript)))

;; code-coverage overlays
(use-package
  coverlay
  :delight coverlay-minor-mode
  :straight t)

;; CSS-in-JS support for tsx-mode
(use-package
  css-in-js-mode
  :delight
  :straight
  '(css-in-js-mode :type git :host github :repo "orzechowskid/tree-sitter-css-in-js" :branch "main" :post-build ((require 'css-in-js-mode) (css-in-js-mode-fetch-shared-library t))))

;; linter adapter which doesn't use LSP
(use-package
  flymake-eslint
  :straight t)

;; code-folding
;; origami depends on some now-deprecated cl functions and there's not much we
;; can do about that
(let ((byte-compile-warnings '((not cl-functions))))
  (use-package
    origami
    :delight
    :straight t))

;; major-mode for JS/TS/JSX/TSX
(use-package
  tsx-mode
  :straight '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el" :branch "emacs29")
  :mode ("\\.[jt]s[x]?\\'" . tsx-mode))

(provide 'duomacs-javascript-typescript)
;;; duomacs-javascript-typescript.el ends here
