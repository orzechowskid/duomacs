;;; duomacs-javascript-typescript.el --- duomacs setup for Javascript & Typescript -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/tsx-mode-hook ()
  "Internal hook function."
  ;; do some things after eglot has finished setting up
  (add-hook
   'eglot-managed-mode-hook
   (lambda ()
     (setq-local
      eldoc-documentation-strategy
      'eldoc-documentation-compose)
     ;; (setq-local flymake-eslint-project-root
     ;;             (locate-dominating-file
     ;;              (buffer-file-name
     ;;               (current-buffer))
     ;;              "package.json"))
     ;; (when (executable-find "eslint_d")
     ;;   (setq-local flymake-eslint-executable-name "eslint_d"))
     ;; (flymake-eslint-enable))))
     )))

(use-package
  coverlay
  :delight coverlay-minor-mode
  :straight t)

(unless (featurep 'eglot)
  (use-package
    eglot
    :straight t))

(use-package
  eldoc
  :straight t
  :config
  ;; prefer help-at-point over eldoc message if both are present
  ;; TODO: `eldoc-message' is deprecated
  (advice-add
   'eldoc-message
   :around
   (lambda (oldfn doc-msg)
     (if (help-at-pt-string)
	 (display-local-help)
       (funcall oldfn doc-msg)))))

(use-package
  flymake-eslint
  :straight t
  :delight)

;; origami depends on some now-deprecated cl functions and there's not much we
;; can do about that
(let ((byte-compile-warnings '((not cl-functions))))
  (use-package
    origami
    :delight
    :straight t))

;; custom recipe until PR gets merged upstream
;; https://github.com/emacs-tree-sitter/tree-sitter-langs/pull/96
(use-package
  tree-sitter-langs
  :straight '(tree-sitter-langs :type git :protocol ssh :host github :repo "orzechowskid/tree-sitter-langs"))

(use-package
  tree-sitter
  :delight
  :straight t)

;; (use-package
;;   tree-sitter-css-in-js
;;   :straight '(tree-sitter-css-in-js :type git :protocol ssh :host github :repo "orzechowskid/tree-sitter-css-in-js"))

(use-package
  yasnippet
  :straight t)

(use-package
  tsi
  :straight '(tsi :type git :protocol ssh :host github :repo "orzechowskid/tsi.el"))

(use-package
  tree-sitter-langs
  :straight t)

(use-package
  tsx-mode
  :straight '(tsx-mode :type git :protocol ssh :host github :repo "orzechowskid/tsx-mode.el" :branch "feature/eglot")
  :mode (("\\.[jt]s[x]?\\'" . tsx-mode)
         ("\\.cjs?\\'" . tsx-mode))
  :bind
  (:map tsx-mode-map
        ("M-/" . #'completion-at-point))
  :hook
  (tsx-mode . duomacs/tsx-mode-hook)
  :config
  (add-to-list
   'apheleia-mode-alist
   '(tsx-mode . prettier-typescript)))


(use-package
  projectile
  :straight t
  :hook (tsx-mode . projectile-mode)
  :init
  ;; Ctrl-P -> find file in project (like vscode does)
  (define-key projectile-mode-map (kbd "C-p") 'projectile-find-file))


(provide 'duomacs-javascript-typescript)
;; duomacs-javascript-typescript.el ends here
