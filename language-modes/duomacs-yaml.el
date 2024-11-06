;;; duomacs-yaml.el --- duomacs setup for YAML files -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  yaml-mode
  :straight t
  :defer t
  :delight
  :hook
  '(yaml-mode . display-line-numbers-mode))

(provide 'duomacs-yaml)
;; duomacs-yaml.el ends here
