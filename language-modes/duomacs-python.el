;;; duomacs-python.el --- duomacs setup for Python files -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'python)

(easy-menu-define nil python-ts-mode-map nil (list "Python" :visible nil))

(add-hook
 'python-ts-mode-hook
 #'eglot-ensure)

(easy-menu-define nil python-ts-mode-map nil (list "Python" :visible nil))

(add-to-list
 'auto-mode-alist
 '("\\.py[iw]?\\'" . python-ts-mode))

(provide 'duomacs-python)

;;; duomacs-python.el ends here
