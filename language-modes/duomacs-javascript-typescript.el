;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'eglot)
(require 'flymake)
(require 'treesit)

;; linter adapter which doesn't use LSP
(use-package
  flymake-eslint
  :straight t
  :defer)

(defun duomacs/tsx-mode-hook ()
  "Internal function.  Hook to be run upon entering `tsx-mode'."
  (add-hook
   'eglot-managed-mode-hook
   (lambda ()
     (setq-local
      flymake-eslint-project-root
      (let* ((package-json
              (locate-dominating-file (buffer-file-name (current-buffer)) "package.json")))
        (when package-json
          (file-name-directory (expand-file-name package-json))))
      flymake-eslint-executable-name
      "eslint_d"
      eldoc-documentation-strategy
      'eldoc-documentation-compose)
     (flymake-eslint-enable))
   nil t))

;; (put 'eglot-node 'flymake-overlay-control nil)
;; (put 'eglot-warning 'flymake-overlay-control nil)
;; (put 'eglot-error 'flymake-overlay-control nil)))

;; format on save
(use-package
  apheleia
  :straight t
  :defer
  :delight
  :config
  (add-to-list
   'apheleia-mode-alist
   '(tsx-ts-mode . prettier-typescript)))

;; code-coverage overlays
(use-package
  coverlay
  :straight t
  :defer
  :delight coverlay-minor-mode)

;; CSS-in-JS support for tsx-mode
(use-package
  css-in-js-mode
  :straight
  '(css-in-js-mode :type git :host github :repo "orzechowskid/tree-sitter-css-in-js" :branch "bugfix/29" :post-build ((require 'css-in-js-mode) (css-in-js-mode-fetch-shared-library)))
  :defer
  :delight
)

;; code-folding
;; origami depends on some now-deprecated cl functions and there's not much we
;; can do about that
(let ((byte-compile-warnings '((not cl-functions))))
  (use-package
    origami
    :straight t
    :defer
    :delight))

;; ;; emacs bug #66646
;; (setq treesit-language-source-alist nil)
;; (add-to-list
;;  'treesit-language-source-alist
;;  '(tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.2" "tsx/src")))
;; (add-to-list
;;  'treesit-language-source-alist
;;  '(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.2" "typescript/src")))
;; (treesit-install-language-grammar 'typescript)
;; (treesit-install-language-grammar 'tsx)
 
;; major-mode for JS/TS/JSX/TSX
(use-package
  tsx-mode
  :straight '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el" :branch "main")
  :defer
  :mode (("\\.[jt]s[x]?\\'" . tsx-mode)
         ("\\.[mc]js\\'" . tsx-mode))
  :hook ((tsx-mode . duomacs/tsx-mode-hook))
  :init
  ;; this mode inherits from `typescript-ts-mode', but loading the latter will
  ;; automatically update `auto-mode-alist' (clobbering any updates we might
  ;; have made to it in the use-package :config block).
  (require 'typescript-ts-mode))

;; LSP inlay hints
;; (add-to-list
;;  'eglot-server-programs
;;  '((tsx-mode)
;;    "typescript-language-server" "--stdio"
;;    :initializationOptions
;;    (:preferences
;;     (:includeInlayParameterNameHints
;;      "all"
;;      :includeInlayParameterNameHintsWhenArgumentMatchesName
;;      t
;;      :includeInlayFunctionParameterTypeHints
;;      t
;;      :includeInlayVariableTypeHintsWhenTypeMatchesName
;;      t
;;      :includeInlayPropertyDeclarationTypeHints
;;      t
;;      :includeInlayFunctionLikeReturnTypeHints
;;      t
;;      :includeInlayEnumMemberValueHints
;;      nil))))
 

(provide 'duomacs-javascript-typescript)
;;; duomacs-javascript-typescript.el ends here
