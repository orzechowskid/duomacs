;;; duomacs-pkg-mgmt.el --- duomacs package-management setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

;;; package infrastructure
;;; we use emacs' own `use-package' functionality to load and configure packages,
;;; and straight.el to fetch packages from MELPA/github/etc.

(require 'use-package)
(require 'use-package-ensure)

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
					 (t ""))))
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

;; (defun duomacs/fci-mode-hook ()
;; 	"Internal function.  Hook run when a buffer enables `display-fill-column-
;;    indicator' mode."
;; 	(setq-default display-fill-column-indicator-column (1- fill-column)
;; 		      display-fill-column-indicator-character ?\ )
;; 	(set-face-attribute 'fill-column-indicator
;; 											nil
;; 											:background nil
;; 											:foreground (if (boundp 'duomacs/fci-color)
;; 																			duomacs/fci-color
;; 																		"white")
;; 											:stipple '(7 1 " ")))


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
	;; (add-hook 'display-fill-column-indicator-mode-hook
	;; 					#'duomacs/fci-mode-hook)
	(setq treesit-language-source-alist
				'((dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"
												 nil nil nil nil))
					(yaml . ("https://github.com/tree-sitter-grammars/tree-sitter-yaml"
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
	(add-to-list 'auto-mode-alist
							 '("\\.?Dockerfile\\'" . dockerfile-ts-mode))

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
	(eglot-code-action-indications '())
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
	(scroll-margin 0)
	(show-paren-mode t)
	(tab-width 2)
	(tool-bar-mode nil)
	(tooltip-mode nil)
	(undo-limit (* 1024 1024 256))
	(use-dialog-box nil)
	(use-package-always-ensure t))

;;; configure some packages included with emacs
;;; it can do a lot out-of-the-box!

;; LSP client
(use-package eglot
  :after (corfu)
  :delight t)

;; interface to linters and other code-checkers
(use-package flymake
	:custom
	(flymake-mode-line-format '(" ✔" flymake-mode-line-counters)))


;;; install some third-party features
;;; certain features apply to emacs as a whole, or otherwise aren't applicable to
;;; any specific major mode.  install those here

;; gets emacs to follow the OS' light/dark theme
(use-package auto-dark
	:custom
	(auto-dark-themes '((duomacs-nord) (duomacs-nord-light)))
	:defer nil
	:init
	(when (and (boundp 'duomacs-use-system-theme)
						 duomacs-use-system-theme)
		(auto-dark-mode t)))

;; better navigation through structured code
(use-package combobulate
	:config
	(push 'tsx-mode
				(nth 1
						 (assoc 'tsx
										combobulate-registered-languages-alist)))
	:custom
	(combobulate-flash-node nil)
	:delight t)

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

;; code-coverage indicators
(use-package cov
	:custom
	(cov-fringe-symbol 'right-triangle)
	(cov-show-covered-lines nil)
	:delight t
	:straight '(cov :type git :host github :repo "orzechowskid/cov" :branch "master"))

;; a better buffer-search experience
;; TODO: figure out how to replace prompt
(use-package ctrlf
  :custom
  (ctrlf-style-alist '((literal :prompt ""
                                :translator regexp-quote
                                :case-fold ctrlf-no-uppercase-literal-p
                                :fallback (isearch-forward . isearch-backward))
                       (regexp :prompt "regexp"
                               :translator identity
                               :case-fold ctrlf-no-uppercase-regexp-p
                               :fallback (isearch-forward-regexp . isearch-backward-regexp))
                       (fuzzy :prompt "fuzzy"
                              :translator ctrlf-translate-fuzzy-literal
                              :case-fold ctrlf-no-uppercase-literal-p)
                       (fuzzy-regexp :prompt "fuzzy regexp"
                                     :translator ctrlf-translate-fuzzy-regexp
                                     :case-fold ctrlf-no-uppercase-regexp-p)
                       (symbol :prompt "symbol"
                               :translator ctrlf-translate-symbol
                               :case-fold ctrlf-no-uppercase-literal-p
                               :fallback (isearch-forward-symbol))
                       (word :prompt "word"
                             :translator ctrlf-translate-word
                             :case-fold ctrlf-no-uppercase-literal-p)))
  :init
  (with-eval-after-load 'ctrlf
    (ctrlf-mode +1)
    (keymap-set ctrlf-minibuffer-mode-map
                "C-n"
                #'ctrlf-next-match)
    (keymap-set ctrlf-minibuffer-mode-map
                "C-p"
                #'ctrlf-previous-match)))

;; a more useful splash screen
(use-package dashboard
	:after (nerd-icons)
	:config
	(dashboard-setup-startup-hook)
  :custom
  (dashboard-display-icons-p t)
  (dashboard-footer-messages '("Editing a file inside a git repository?  Access magit with `C-x g`."
															 "Working in a git repository?  call `git grep` with `C-x G`."
															 "Want to add a new package?  Try `M-:` then `(use-package <package name>)`."
															 "Don't know what you don't know?  `M-x apropos` is your friend."
															 "Need to run some Lisp in the current buffer?  Use `M-:`."
															 "Need to run a shell command in the current buffer's directory?  Use `M-!`."
															 "Looking for a file in your current git repository?  Find it with `C-x p f`."))
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-icon-types 'nerd-icons)
	:defer nil)

;; mode-line cleaner-upper
(use-package delight
  :config
  (delight
   '((eldoc-mode nil "eldoc")
		 (auto-dark-mode nil "AD")
		 (auto-revert-mode nil "autorevert")
		 (auto-revert-mode nil "ARev")
		 (eldoc-mode nil "ELDoc")
     (subword-mode nil "subword")
		 (auto-dark-mode nil "auto-dark")
		 (treesit-fold-mode nil "Treesit-Fold")
		 (cov-mode nil "cov")))
  :defer nil)

;; terminal client
(use-package eat
	:bind (("S-<prior>" . cua-scroll-down)
				 ("S-<next>" . cua-scroll-up)
				 ("C-c C-k" . nil))
	:config
	(add-hook 'eat-mode-hook
						(lambda ()
              (setq-local scroll-margin 1)
							(display-fill-column-indicator-mode 0)
							(let ((bg (if (boundp 'duomacs/terminal-background-color)
														duomacs/terminal-background-color
													"#222222"))
										(fg (if (boundp 'duomacs/terminal-foreground-color)
														duomacs/terminal-foreground-color
													"#eceff4")))
								(face-remap-add-relative
								 'fringe
								 :background bg
								 :foreground fg)
								(face-remap-add-relative
								 'default
								 :background bg
								 :foreground fg)
								(face-remap-add-relative
								 'cursor
								 :background fg))))
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
		(exec-path-from-shell-initialize)
		:defer nil))

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
     (vc-refresh-state))))

;; eglot will use markdown-mode to render docstrings if it's present
(use-package markdown-mode)

;; helpful annotations on many minibuffer completion candidates
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

;; icons for dashboards, code-completion popups, etc.
(use-package nerd-icons
	:custom
	(nerd-icons-font-family "SauceCodePro Nerd Font")
	:defer nil)
(use-package nerd-icons-corfu
	:after nerd-icons
	:config
	(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; a more flexible backend for matching a minibuffer completion candidate
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  :defer nil)

(use-package posframe)

;; support for activation of python virtualenvs
(use-package pyvenv)

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

(use-package ultra-scroll
  :config
  (ultra-scroll-mode)
  :custom
  (scroll-conservatively 3)
  (scroll-margin 1)
  :defer nil
  :straight '(ultra-scroll :type git :host github :repo "jdtsmith/ultra-scroll" :branch "main"))

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


;;; configure built-in major modes

(defun duomacs/my-python-mode-hook ()
	(let ((project-root
				 (locate-dominating-file (buffer-file-name (current-buffer)) "venv/")))
		(when project-root
			(pyvenv-activate (concat (expand-file-name project-root)
															 "venv/")))
		(eglot-ensure)))

(add-hook
 'python-ts-mode-hook
 #'duomacs/my-python-mode-hook)

;(easy-menu-define nil python-ts-mode-map nil (list "Python" :visible nil))

(add-to-list
 'auto-mode-alist
 '("\\.py[iw]?\\'" . python-ts-mode))


;;; install third-party major modes
;;; warning: pretty opinionated!

;; JS/TS/JSX/TSX
;; you'll need to `npm install` the LSP servers yourself, as well as eslint and
;; stylelint
;; ESLint adapter for flymake
(use-package flymake-jsts
  :straight '(flymake-jsts :type git :host github :repo "orzechowskid/flymake-jsts" :branch "main"))
(use-package flymake-stylelint
	:straight '(flymake-stylelint :type git :host github :repo "orzechowskid/flymake-stylelint" :branch "master"))
(use-package tsx-mode
	:config
	(setq-default combobulate-tsx-major-modes '(tsx-mode))
	:custom
	(tsx-mode-enable-css-in-js-font-lock 'when-in-range)
	(tsx-mode-enable-css-in-js-linting t)
	(tsx-mode-enable-js-linting t)
	(tsx-mode-enable-code-coverage t)
	:hook
	((tsx-mode . subword-mode))
	:init
	;; the typescript treesit modes automatically register themselves with
	;; `auto-mode-alist' so we have to work around that if we want our major mode
	;; to take precedence
	(require 'typescript-ts-mode)
	(add-to-list 'auto-mode-alist
							 '("\\.[jt]s[x]?\\'" . tsx-mode))
	(add-to-list 'auto-mode-alist
							 '("\\.[mc]?js\\'" . tsx-mode))
	:straight '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el" :branch "emacs30"))


(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
