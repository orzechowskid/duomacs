;;; duomacs-prisma.el --- duomacs setup for Prisma -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package
  prisma-mode
  :straight (:type git :protocol ssh :host github :repo "davidarenas/prisma-mode")
  :defer
  :mode ("\\.prisma\\'" . prisma-mode))

(provide 'duomacs-prisma)
;;; duomacs-prisma.el ends here
