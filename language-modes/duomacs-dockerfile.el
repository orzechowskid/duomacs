;;; duomacs-dockerfile.el --- duomacs setup for Dockerfiles -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'treesit)
(require 'dockerfile-ts-mode)

(add-to-list
 'treesit-language-source-alist
 '(dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile" "v0.2.0" "src")))
(treesit-install-language-grammar 'dockerfile)
(start-process "lsp-install" "duomacs-install" "npm" "install" "-g" "dockerfile-language-server-nodejs")
(easy-menu-define nil dockerfile-ts-mode-map nil (list "Dockerfile" :visible nil))
(add-hook
 'dockerfile-ts-mode-hook
 'eglot-ensure)

(use-package
  docker
  :straight t
  :defer t
  :ensure t
  :bind
  ("C-c r d" . docker)
  :config
  (setq ((docker-command "docker")
	 (docker-compose-command "docker-compose"))))

(provide 'duomacs-dockerfile)
;;; duomacs-dockerfile.el ends here
