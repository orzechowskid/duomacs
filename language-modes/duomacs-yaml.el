;;; duomacs-yaml.el --- duomacs setup for YAML files -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'treesit)
(require 'yaml-ts-mode)

(add-to-list
 'treesit-language-source-alist
 '(yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0" "src")))
(treesit-install-language-grammar 'yaml)
(add-hook
 'yaml-ts-mode-hook
 'display-line-numbers-mode)

(provide 'duomacs-yaml)
;;; duomacs-yaml.el ends here
