;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:


;;; package infrastructure
;;; we use emacs' own `use-package' functionality to load and configure packages,
;;; and straight.el to fetch packages from MELPA/github/etc.

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
;; use an empty bitmap for line-wrap purposes
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

(defvar straight-check-for-modifications '(check-on-save find-when-checking))
(defvar straight-vc-git-default-clone-depth 1)
(defvar straight-use-package-by-default t)

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

;; configure our package managers
(setq
 package-enable-at-startup nil
 use-package-always-defer t)

(use-package straight)

(advice-add
 #'straight-use-package
 :after
 (lambda (&rest _ignored)
   (when (called-interactively-p 'interactive)
     (message "To use this package in future Emacs sessions, be sure to add it to your init file: `(use-package <package name>)`."))))


;;; emacs feature configuration
;;; you can call `use-package' on emacs itself, if you want to leverage the
;;; use-package infrastructure and functionality (or just keep consistency with
;;; the rest of your configuration)

(defun duomacs/prog-mode-hook ()
	"Internal function.  Hook run when a buffer uses a major mode derived from
   `prog-mode'."
	(let ((is-git (and (buffer-file-name)
										 (vc-git-registered (buffer-file-name)))))
		(when is-git
			(setq-local magit-inhibit-refresh-save t) ; not a global variable, booooo
			(add-hook 'after-save-hook
								(lambda ()
									(when (boundp 'magit-refresh)
										(magit-refresh)))))
		(display-fill-column-indicator-mode t)))

(use-package emacs
	:config
	(add-hook 'prog-mode-hook
						#'duomacs/prog-mode-hook)
	(setq treesit-language-source-alist
				'((yaml . ("https://github.com/tree-sitter-grammars/tree-sitter-yaml"
									 nil nil nil nil))
					(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript"
												 nil "typescript/src" nil nil))
					(tsx . ("https://github.com/tree-sitter/tree-sitter-typescript"
									nil "tsx/src" nil nil))
					(python . ("https://github.com/tree-sitter/tree-sitter-python"
										 nil nil nil nil))))
	(add-to-list 'auto-mode-alist
							 '("\\.y[a]?ml\\'" . yaml-ts-mode))
	(add-to-list 'auto-mode-alist
							 '("\\.py\\'" . python-ts-mode))
	:custom
	(auto-compression-mode t)
	(auto-encryption-mode nil)
	(auto-save-file-name-transforms `((".*" "~/.emacs.d/backup/" t)))
	(backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacs.d/backup/"))))
	(blink-cursor-mode nil)
	(create-lockfiles nil)
	(cua-mode t)
	(dirtrack-mode nil)
	(display-line-numbers-grow-only t)
	(editorconfig-mode t)
	(eglot-events-buffer-size 0)
	(eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)
	(fill-column 80)
	(inhibit-startup-echo-area-message (user-login-name))
	(inhibit-startup-screen t)
	(mouse-wheel-progressive-speed nil)
	(mouse-wheel-scroll-amount '(2 ((shift) . hscroll) ((meta)) ((control) . text-scale)))
	(recentf-mode t)
	(savehist-mode t)
	(scroll-bar-mode nil)
	(scroll-conservatively 101)
	(scroll-margin 1)
	(show-paren-mode t)
	(tab-width 2)
	(tool-bar-mode nil)
	(tooltip-mode nil)
	(undo-limit (* 1024 1024 256))
	(use-dialog-box nil)
	(use-package-always-ensure t))

;; LSP client
(use-package eglot
  :after (corfu)
  :delight t
  :defer t)

;; interface to linters and other code-checkers
(use-package flymake
	:custom
	(flymake-error-bitmap '(flycheck-big-indicator compilation-error))
	(flymake-mode-line-format '(" ✔" flymake-mode-line-counters))
	(flymake-warning-bitmap '(flycheck-big-indicator compilation-warning)))


;;; install some third-party features
;;; certain features apply to emacs as a whole, or otherwise aren't applicable to
;;; any specific major mode.  install those here

;; better versions of some built-in commands
(use-package consult
  :bind
  (("C-c !" . consult-flymake)
	 ("C-x b" . consult-buffer)
   ("C-x G" . consult-git-grep)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
	 ("M-g i" . consult-imenu)
   ("C-s" . consult-line))
	:defer nil)

;; a better frontend for in-buffer code-completion
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-popup-delay 0.5)
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
															 "Want to add a new package?  Try `M-:` then `(use-package <package name>)`."
															 "Don't know what you don't know?  `M-x apropos` is your friend."))
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-icon-types 'nerd-icons)
	:defer nil)

;; mode-line cleaner-upper
(use-package delight
  :config
  (delight
   '((eldoc-mode nil "eldoc")
		 (auto-revert-mode nil "autorevert")
     (subword-mode nil "subword")
		 (treesit-fold-mode nil "Treesit-Fold")))
  :defer nil)

;; terminal client
(use-package eat
	:bind (("S-<prior>" . cua-scroll-down)
				 ("S-<next>" . cua-scroll-up)
				 ("C-c C-k" . nil))
	:config
	(add-hook 'eat-mode-hook
						(lambda ()
							(face-remap-add-relative
							 'fringe
							 :background "#222222")
							(face-remap-add-relative
							 'default
							 :background "#222222")))
	:straight
	'(eat :type git :host codeberg :repo "akib/emacs-eat"
				files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))))

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
  (add-to-list
   'marginalia-prompt-categories
   '("\\<Which recipe?\\>" . straight-recipe))
  (add-to-list
   'marginalia-annotator-registry
   '(straight-recipe duomacs/annotate-get-package-recipe none))
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

(use-package treesit-fold
	:delight t)

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


;;; install third-party major modes
;;; warning: pretty opinionated!

(use-package tsx-mode
	:config
	;; the typescript treesit modes automatically register themselves with
	;; `auto-mode-alist' so we have to work around that if we want our major mode
	;; to take precedence
	(require 'typescript-ts-mode)
	(add-to-list 'auto-mode-alist
							 '("\\.[jt]s[x]?\\'" . tsx-mode))
	(add-to-list 'auto-mode-alist
							 '("\\.[mc]?js\\'" . tsx-mode))
	:custom
	(tsx-mode-enable-css-in-js-font-lock 'when-in-range)
	:straight '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el" :branch "emacs30"))


(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
