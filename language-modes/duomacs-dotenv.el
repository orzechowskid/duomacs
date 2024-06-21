;;; duomacs-dotenv.el --- duomacs setup for Dotenv -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  dotenv-mode
  :straight t
  :defer t
  :mode ("\\.env[\\.*]?\\'" . dotenv-mode))

(provide 'duomacs-dotenv)
;;; duomacs-dotenv.el ends here
