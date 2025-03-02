;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'use-package)
(require 'use-package-ensure)

(defvar straight-check-for-modifications '(check-on-save find-when-checking))
(defvar straight-vc-git-default-clone-depth 1)
(defvar straight-use-package-by-default t)

;; as required by straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(defun duomacs/annotate-get-package-recipe (candidate)
  "Annotate a straight.el completion CANDIDATE with some package-registry info."
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

(use-package straight)

(advice-add
 #'straight-use-package
 :after
 (lambda (&rest _ignored)
   (when (called-interactively-p 'interactive)
     (message "To use this package in future Emacs sessions, be sure to add it to your init file: `(use-package <package name>)`."))))

;; install dependencies unrelated to any particular major mode

;; mode-line cleaner upper
(use-package delight
  :straight t
  :config
  (delight
   '((auto-revert-mode nil "autorevert")
     (eldoc-mode nil "eldoc")
     (subword-mode nil "subword"))))

;; a better frontend for in-buffer code-completion
(use-package corfu
  :straight t
  :delight
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

;; icons for corfu's popup-info menu
(use-package all-the-icons-completion
  :after (:all all-the-icons corfu marginalia)
  :config
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
  (all-the-icons-completion-mode))

;; git source-control client
(use-package magit
  :straight t
  :config
  (easy-menu-define nil magit-mode-map nil (list "Magit" :visible nil))
  ;; poke vc-mode whenever certain git things happen
  (advice-add
   'magit-checkout :after
   (lambda (&rest _ignored)
     (vc-refresh-state)))
  (advice-add
   'magit-branch-and-checkout :after
   (lambda (&rest _ignored)
     (vc-refresh-state))))

;; helpful annotations on minibuffer completion candidates
(use-package marginalia
  :straight t
  :config
  (add-to-list
   'marginalia-prompt-categories
   '("\\<Which recipe?\\>" . straight-recipe))
  (add-to-list
   'marginalia-annotator-registry
   '(straight-recipe duomacs/annotate-get-package-recipe none)))

;; a more flexible backend for selecting minibuffer completion candidates
(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic)))

;; source-code project management
(use-package projectile
  :straight t
  :delight)

;; a better frontend for selecting minibuffer completion candidates
(use-package vertico
  :straight t
  :config
  (vertico-mode t))
;; use a posframe, rather than a completion buffer, to select completion
;; candidates.  this prevents emacs from resizing our work buffers
(use-package vertico-posframe
  :after (vertico)
  :straight '(vertico-posframe :type git :host github :repo "tumashu/vertico-posframe" :branch "main")
  :config
  (vertico-posframe-mode t))

;; use a posframe for transient buffers like the ones magit uses
(use-package transient-posframe
  :straight t
  :config
  (transient-posframe-mode))

;; context-dependent actions
(use-package embark
  :straight t
  :ensure t
  :bind
  (("C-c a" . embark-act)))
(use-package embark-consult
  :straight t
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico-posframe
  :straight t
  :after vertico
  :config
  (vertico-posframe-mode 1))

(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
