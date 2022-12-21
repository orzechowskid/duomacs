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

(defun duomacs/annotate-get-package-recipe (candidate)
  "Annotate straight.el completing-read candidates with some package-registry info."
  (let* ((recipe (straight-recipes-retrieve (intern candidate)))
         (repo-index (cl-position :repo recipe))
         (flavor-index (cl-position :flavor recipe))
	 (text
	  (cond
	   ;; ensure any symbols are turned into strings
	   (flavor-index (format "%s" (nth (1+ flavor-index) recipe)))
	   (repo-index (format "%s" (nth (1+ repo-index) recipe)))
	   (t "??"))))
    (marginalia--documentation text)))

(straight-use-package 'use-package)
(use-package straight
  :custom (straight-use-package-by-default t))

;; install dependencies unrelated to any particular major mode

;; mode-line cleaner upper
(use-package delight
  :config
  (delight
   '((auto-revert-mode nil "autorevert")
     (eldoc-mode nil "eldoc")
     (subword-mode nil "subword"))))

;; a better frontend for in-buffer code-completion
(use-package corfu
  :delight
  :straight t
  :load-path "straight/build/corfu/extensions"
  :init
  (require 'corfu-popupinfo)
  :hook
  ((prog-mode . corfu-mode)
   (corfu-mode . corfu-popupinfo-mode))
  :custom
  (corfu-auto t)
  (corfu-popupinfo-delay 0.2))

;; some helpful enhancements to built-in emacs commands
(use-package consult
  :straight t
  :bind
  ("C-x b" . consult-buffer))

;; synchronize emacs' `exec-path' with your shell's
(use-package exec-path-from-shell
  :straight t
  :config
  (exec-path-from-shell-initialize))

;; git source-control client
(use-package magit
  :straight t
  :config
  ;; poke vc-mode after we do some magit things
  (advice-add 'magit-checkout :after
              (lambda (&rest ignored)
                (vc-refresh-state)))
  (advice-add 'magit-branch-and-checkout :after
              (lambda (&rest ignored)
                (vc-refresh-state))))

;; helpful annotations on minibuffer completion candidates
(use-package marginalia
  :straight t
  :config
  (add-to-list 'marginalia-prompt-categories
	       '("\\<Which recipe?\\>" . straight-recipe))
  (add-to-list 'marginalia-annotator-registry
	       '(straight-recipe duomacs/annotate-get-package-recipe none)))

;; a more flexible backend for selecting minibuffer completion candidates
(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic)))

;; source-code project management
(use-package projectile
  :delight
  :straight t)

;; a better frontend for selecting minibuffer completion candidates
(use-package vertico
  :straight t
  :config
  (vertico-mode t))

(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
