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

(use-package delight
  :config
  (delight
   '((auto-revert-mode nil "autorevert")
     (subword-mode nil "subword"))))

;; format buffers on save
(use-package apheleia
  :delight
  :straight t)

;; a better buffer-switching experience
(use-package consult
  :straight t
  :bind
  ("C-x b" . consult-buffer))

;; a better completion-at-point experience
(use-package corfu
  :straight t
  :hook
  ((prog-mode . corfu-mode)
   (corfu-mode . (lambda ()
                   (require 'corfu-popupinfo)
                   (corfu-popupinfo-mode))))
  :config
  ;; make corfu extensions available to us - on ELPA they're at the top level of
  ;; the package but in git they're in a subdirectory
  (add-to-list
   'load-path
   (file-name-concat (file-name-directory (symbol-file 'corfu)) "extensions"))
  (setq
   corfu-auto t
   corfu-auto-delay 0.2
   corfu-auto-prefix 2))

;; documentation and error-message display
(use-package eldoc
  :delight
  :straight t
  :config
  (advice-add
   'eldoc-message :around
   (lambda (oldfn doc-msg)
     (let ((echo-help-string (help-at-pt-string)))
       (if echo-help-string
           (display-local-help)
         (funcall oldfn doc-msg))))))

;; sync emacs' path string with your shell's $PATH
(use-package exec-path-from-shell
  :straight t
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

;; git source control client
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

;; general-purpose annotation mechanism
(use-package marginalia
  :straight t
  :config
  (add-to-list 'marginalia-prompt-categories
	       '("\\<Which recipe?\\>" . straight-recipe))
  (add-to-list 'marginalia-annotator-registry
	       '(straight-recipe duomacs/annotate-get-package-recipe none)))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless partial-completion basic)))

(use-package projectile
  :delight
  :straight t)

;; a better candidate-completion experience
(use-package vertico
  :straight t
  :init
  (vertico-mode))

(provide 'duomacs-pkg-mgmt)
;;; duomacs-pkg-mgmt.el ends here
