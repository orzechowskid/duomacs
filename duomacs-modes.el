;;; duomacs-modes.el --- duomacs mode setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'eglot)
(require 'flymake)
(require 'savehist)

(use-package magit
  :straight t)

(require 'magit)

(savehist-mode t)
(fset #'jsonrpc--log-event #'ignore)

(easy-menu-define nil flymake-mode-map nil (list "Flymake" :visible nil))
(easy-menu-define nil magit-mode-map nil (list "Magit" :visible nil))

(define-fringe-bitmap
  'duomacs-line-wrap
  (vector #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000)
  16 16 'center)

(defun duomacs/prog-mode-hook ()
  "Internal function.  Configure some things common to all programming modes."
  (display-line-numbers-mode t)
  (show-paren-mode t)
  (subword-mode t)
  (display-fill-column-indicator-mode t)
  (local-set-key (kbd "C-p") #'project-find-file)
  (flymake-mode t)
  ;; use a flycheck keybinding for flymake
  (local-set-key (kbd "C-c ! n") #'flymake-goto-next-error)
  ;; disable the line-wrap indicator in the west fringe with an empty bitmap; the
  ;; missing line number is a good-enough indicator.  (the line-wrap indicator in
  ;; the east fringe will still be visible, and will be rendered using the user's
  ;; preferred font, due to calling `set-display-table-slot' in duomacs-fonts.el)
  (push
   '(continuation duomacs-line-wrap duomacs-line-wrap)
   fringe-indicator-alist)
  ;; useful for when we switch source-control branches
  (add-hook
   'after-revert-hook
   'vc-refresh-state))

(add-hook
 'prog-mode-hook
 #'duomacs/prog-mode-hook)

(provide 'duomacs-modes)
;;; duomacs-modes.el ends here
