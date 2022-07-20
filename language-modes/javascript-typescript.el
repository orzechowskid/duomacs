;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  coverlay
  :delight
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
  :straight t)

(use-package
  tree-sitter
  :delight
  :straight t)

(use-package
  yasnippet
  :straight t)

(use-package
  tsi
  :straight '(tsi :type git :protocol ssh :host github :repo "orzechowskid/tsi.el"))

(use-package
  tsx-mode
  :straight '(tsx-mode :type git :protocol ssh :host github :repo "orzechowskid/tsx-mode.el")
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
