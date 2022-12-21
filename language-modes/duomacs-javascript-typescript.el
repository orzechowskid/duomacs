;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'eglot)
(require 'flymake)
(require 'treesit)
(require 'typescript-ts-mode)

(add-hook
 'tsx-ts-mode-hook
 #'duomacs/tsx-mode-hook)

(defun duomacs/tsx-mode-hook ()
  "Enables some minor modes when `tsx-ts-mode' is enabled."
  (css-in-js-mode t)
  (add-hook eglot-managed-mode-hook #'flymake-eslint-enable)
  (eglot-ensure))

(use-package
  coverlay
  :delight coverlay-minor-mode
  :straight t)

(use-package
  flymake-eslint
  :straight t)

;; origami depends on some now-deprecated cl functions and there's not much we
;; can do about that
(let ((byte-compile-warnings '((not cl-functions))))
  (use-package
    origami
    :delight
    :straight t))

(use-package
  css-in-js-mode
  :straight
  '(css-in-js-mode :type git :host github :repo "orzechowskid/tree-sitter-css-in-js" :branch "main" :post-build
                   ((require 'css-in-js-mode) (css-in-js-mode-fetch-shared-library t))))

(provide 'duomacs-javascript-typescript)
;; duomacs-javascript-typescript.el ends here
