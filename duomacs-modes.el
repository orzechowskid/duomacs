;;; duomacs-modes.el --- duomacs mode setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'flymake)
(require 'savehist)

(use-package magit
  :straight t)

(require 'magit)

(savehist-mode t)

(easy-menu-define nil magit-mode-map nil (list "Magit" :visible nil))

(defun duomacs/prog-mode-hook ()
  "Internal function.  Configure some things common to all programming modes."
  (display-line-numbers-mode t)
  (show-paren-mode t)
  (subword-mode t)
  (display-fill-column-indicator-mode t)
  (local-set-key (kbd "C-p") #'project-find-file)
  (flymake-mode t)
  ;; use a flycheck keybinding for flymake
  (local-set-key (kbd "C-c ! n") #'flymake-goto-next-error))

(add-hook
 'prog-mode-hook
 #'duomacs/prog-mode-hook)

(provide 'duomacs-modes)
;;; duomacs-modes.el ends here
