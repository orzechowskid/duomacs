;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  tree-sitter
  :delight
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
