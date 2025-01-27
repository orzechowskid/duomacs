;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'use-package)
(require 'use-package-ensure)

;; use flycheck's fringe bitmap for flymake, which looks nicer on hidpi screens
(define-fringe-bitmap
  'flymake-big-indicator
  (vector #b0000000000000000
          #b0000000000000000
          #b0000000000000000
          #b0111000111000000
          #b0011100011100000
          #b0001110001110000
          #b0000111000111000
          #b0000011100011100
          #b0000011100011100
          #b0000111000111000
          #b0001110001110000
          #b0011100011100000
          #b0111000111000000
          #b0000000000000000
          #b0000000000000000
          #b0000000000000000)
  16 16 'center)

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

;; disable the built-in package manager
(setq  package-enable-at-startup nil)

(use-package straight)

(advice-add
 #'straight-use-package
 :after
 (lambda (&rest _ignored)
   (when (called-interactively-p 'interactive)
     (message "To use this package in future Emacs sessions, be sure to add it to your init file: `(use-package <package name>)`."))))

;; install packages unrelated to any particular major mode

;; better versions of some built-in commands
(use-package consult
  :bind
  (("C-c !" . consult-flymake)
	 ("C-x b" . consult-buffer)
   ("C-x G" . consult-git-grep)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
   ("C-s" . consult-line)))

;; a better frontend for in-buffer code-completion
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-popup-delay 0.3)
  :delight t
  :hook
  ((prog-mode . corfu-mode)
   (corfu-mode . corfu-popupinfo-mode))
  :init
  (require 'corfu-popupinfo) ; a corfu extension, not a package
  :load-path "straight/build/corfu/extensions")

;; a more useful splash screen
(use-package dashboard
	:after (nerd-icons)
	:config
	(dashboard-setup-startup-hook)
  :custom
  (dashboard-display-icons-p t)
  (dashboard-footer-messages '("Editing a file inside a git repository?  Access magit with `C-x g`."
															 "Want to add a new package?  Try `M-:` then `(use-package <package name>)`."))
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-icon-types 'nerd-icons))

;; modeline cleaner-upper
(use-package delight
  :config
  (delight
   '((eldoc-mode nil "eldoc")
		 (auto-revert-mode nil "autorevert")
     (subword-mode nil "subword")))
  :defer nil)

;; terminal client
(use-package eat
	:bind (("S-<prior>" . cua-scroll-down)
				 ("S-<next>" . cua-scroll-up))
	:config
	(add-hook 'eat-mode-hook
						(lambda ()
							(face-remap-add-relative
							 'fringe
							 :background "#222222")
							(face-remap-add-relative
							 'default
							 :background "#222222")))
	:custom
	(eat-term-name "xterm-256color"))

;; LSP client
(use-package eglot
  :after (corfu)
  :delight t
  :defer t)

;; extra context-specific actions.  it's like a right-click menu for emacs!
(use-package embark
  :bind
  (("C-c a" . embark-act)))
(use-package embark-consult
  :hook
  ((embark-collect-mode . consult-preview-at-point-mode)))

(when (eq system-type 'darwin)
	;; syncs emacs' `exec-path` with your shell's.  use this if you have variables
	;; which don't get set by your login shell
	(use-package exec-path-from-shell
		:config
		(exec-path-from-shell-initialize)))

(use-package flymake
	:custom
	(flymake-error-bitmap '(flycheck-big-indicator compilation-error))
	(flymake-mode-line-format '(" ✔" flymake-mode-line-counters))
	(flymake-warning-bitmap '(flycheck-big-indicator compilation-warning)))

;; the world's best git client
(use-package magit
  :config
  ;; poke vc-mode whenever certain git things happen
    (advice-add
   'magit-checkout :after
   (lambda (&rest _ignored)
     (vc-refresh-state)))
  (advice-add
   'magit-branch-and-checkout :after
   (lambda (&rest _ignored)
     (vc-refresh-state)))
  :defer t)

;; eglot will use markdown-mode to render docstrings if it's present
(use-package markdown-mode)

;; helpful annotations on many minibuffer completion canditates
(use-package marginalia
  :config
  ;; (add-to-list
  ;;  'marginalia-prompt-categories
  ;;  '("\\<Which recipe?\\>" . straight-recipe))
  ;; (add-to-list
  ;;  'marginalia-annotator-registry
  ;;  '(straight-recipe duomacs/annotate-get-package-recipe none))
  (marginalia-mode t)
  :defer nil)

(use-package nerd-icons
	:custom
	(nerd-icons-font-family "SauceCodePro Nerd Font")
	:defer nil)

;; a more flexible backend for matching a minibuffer completion candidate
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  :defer nil)

(use-package posframe)

;; support for using a posframe for transient buffers like the ones magit uses
(use-package transient-posframe
  :after (posframe)
  :config
  (transient-posframe-mode)
  :custom
  (transient-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  :defer nil)

;; vertical completion mode
(use-package vertico
  :config
  (vertico-mode t)
  :defer nil)
(use-package vertico-posframe
  :after (vertico)
  :config
  (vertico-posframe-mode t)
  :custom
  (vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  :defer nil
  :straight '(vertico-posframe :type git :host github :repo "tumashu/vertico-posframe" :branch "main"))

(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
