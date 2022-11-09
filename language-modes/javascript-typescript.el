;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  coverlay
  :delight coverlay-minor-mode
  :straight t)

(use-package
  eldoc
  :straight t
  :config
  ;; prefer help-at-point over eldoc message if both are present
  ;; TODO: `eldoc-message' is deprecated
  (advice-add
   'eldoc-message
   :around
   (lambda (oldfn doc-msg)
     (if (help-at-pt-string)
	 (display-local-help)
       (funcall oldfn doc-msg)))))

(use-package
  flymake
  :delight)

(use-package
  flycheck
  :delight)

(use-package
  lsp-mode
  :delight
  :straight t
  :config
  (setq lsp-file-watch-threshold 16384))

;; origami depends on some now-deprecated cl functions and there's not much we
;; can do about that
(let ((byte-compile-warnings '((not cl-functions))))
  (use-package
    origami
    :delight
    :straight t))

;; custom recipe until PR gets merged upstream
;; https://github.com/emacs-tree-sitter/tree-sitter-langs/pull/96
(use-package
  tree-sitter-langs
  :straight '(tree-sitter-langs :type git :protocol ssh :host github :repo "orzechowskid/tree-sitter-langs"))

(use-package
  tree-sitter
  :delight
  :straight t)

;; (use-package
;;   tree-sitter-css-in-js
;;   :straight '(tree-sitter-css-in-js :type git :protocol ssh :host github :repo "orzechowskid/tree-sitter-css-in-js"))

(use-package
  yasnippet
  :straight t)

(use-package
  tsi
  :straight '(tsi :type git :protocol ssh :host github :repo "orzechowskid/tsi.el"))

(use-package
  tree-sitter-langs
  :straight t)

(use-package
  tsx-mode
  :straight '(tsx-mode :type git :protocol ssh :host github :repo "orzechowskid/tsx-mode.el" :branch "next")
  :mode ("\\.[jt]s[x]?\\'" . tsx-mode))

(use-package
  projectile
  :straight t
  :hook (tsx-mode . projectile-mode)
  :init
  ;; Ctrl-P -> find file in project (like vscode does)
  (define-key projectile-mode-map (kbd "C-p") 'projectile-find-file))


(provide 'duomacs-javascript-typescript)
;; duomacs-javascript-typescript.el ends here
