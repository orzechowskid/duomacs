;;; duomacs-markdown.el --- duomacs setup for Markdown -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  markdown-mode
  :delight
  :straight t
  :init
  (require 'markdown-mode)
  (easy-menu-define nil markdown-mode-map nil (list "Markdown" :visible nil)))

(provide 'duomacs-markdown)
;;; duomacs-markdown.el ends here
