;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(setq straight-check-for-modifications '(check-on-save find-when-checking))
(setq straight-vc-git-default-protocol 'ssh)
(setq straight-vc-git-force-protocol t)
(setq straight-vc-git-default-clone-depth 1)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(use-package straight
  :custom (straight-use-package-by-default t))

;; install dependencies unrelated to any particular major mode
(use-package delight
  :config
  (delight
   '((auto-revert-mode nil "autorevert")
     (subword-mode nil "subword"))))
(use-package company
  :delight
  :straight t)
(use-package consult
  :straight t)
(use-package eldoc
  :delight
  :straight t)
(use-package magit
  :straight t)
(use-package marginalia
  :straight t)
(use-package prescient
  :straight t)
(use-package projectile
  :delight
  :straight t)
(use-package selectrum
  :straight t)
(use-package selectrum-prescient
  :straight t
  :after (selectrum prescient)
  :config
  (selectrum-mode t)
  (selectrum-prescient-mode t)
  (prescient-persist-mode t))

(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
