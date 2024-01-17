;;; duomacs-menu.el --- duomacs menu-bar setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(require 'eww)
(require 'flymake)
(require 'help-mode)
(require 'image-mode)

;; hides some menu-bar items which appear and disappear when various modes
;; are enabled or disabled
(easy-menu-define nil minibuffer-mode-map nil (list "Minibuf" :visible nil))
(easy-menu-define nil help-mode-map nil (list "Help-Mode" :visible nil))
(easy-menu-define nil eww-mode-map nil (list "Eww" :visible nil))
(easy-menu-define nil text-mode-map nil (list "Text" :visible nil))
(easy-menu-define nil image-mode-map nil (list "Image" :visible nil))

(defun duomacs/universal-argument ()
  "Internal function.
`universal-argument' with some help text."
  (interactive)
  (message "Enter a context value followed by a keystroke or other command...")
  (universal-argument))

(defun duomacs/previous-window ()
  "Internal function.
`previous-window' as an interactive command."
  (interactive)
  (other-window -1))

(defun duomacs/file-menu ()
  "Internal function.
Creates the File menu."
  (let ((keymap (make-sparse-keymap)))
    (define-key-after
      keymap [find-file]
      '(menu-item "Visit existing/new file..." find-file))
    (define-key-after
      keymap [visit-directory]
      '(menu-item "Visit existing/new directory..." dired))
    (define-key-after
      keymap [consult-recent-file]
      '(menu-item "Open recent file..." consult-recent-file))
    (define-key-after
      keymap [file-sep-1]
      '(menu-item "--"))
    (define-key-after
      keymap [save-buffer]
      '(menu-item "Save file" save-buffer
                  :enable (and (current-buffer)
			       (buffer-modified-p))))
    (define-key-after
      keymap [kill-current-buffer]
      '(menu-item "Close file" kill-current-buffer
                  :enable (current-buffer)
		  :keys "C-x k"))
    (define-key-after
      keymap [file-sep-2]
      '(menu-item "--"))
    (define-key-after
      keymap [save-buffers-kill-terminal]
      '(menu-item "Quit" save-buffers-kill-terminal))
    keymap))


(defun duomacs/edit-menu ()
  "Internal function.
Creates the Edit menu."
  ;; TODO: figure out why we can't refer to cua- functions inside our menu items
  (let ((keymap (make-sparse-keymap)))
    (define-key-after
      keymap [undo]
      '(menu-item "Undo last command" undo
                  :enable (and (not buffer-read-only)
                               (not (eq t buffer-undo-list))
                               (if (eq last-command 'undo)
                                   (listp pending-undo-list)
				 (consp buffer-undo-list)))
                  :keys "C-z"))
    (define-key-after
      keymap [edit-sep-1]
      '(menu-item "--"))
    (define-key-after
      keymap [cut]
      '(menu-item "Cut current region" kill-region
                  :enable (and
                           mark-active
                           (not buffer-read-only))
                  :keys "C-x"))
    (define-key-after
      keymap [copy]
      '(menu-item "Copy region" kill-ring-save
                  :enable mark-active
                  :keys "C-c"))
    (define-key-after
      keymap [paste]
      '(menu-item "Paste" yank
                  :enable (and (cdr yank-menu)
                               (not buffer-read-only))
                  :keys "C-v"))
    (define-key-after
      keymap [edit-sep-2]
      '(menu-item "--"))
    (define-key-after
      keymap [select-all]
      '(menu-item "Select all" mark-whole-buffer
                  :enable (> (- (point-max) (point-min) 0))))
    keymap))


(defun duomacs/view-menu ()
  "Internal function.
Creates the View menu."
  (let ((keymap (make-sparse-keymap)))
    (define-key-after
      keymap [next-buffer]
      '(menu-item "Next buffer" next-buffer))
    (define-key-after
      keymap [previous-buffer]
      '(menu-item "Previous buffer" previous-buffer))
    (define-key-after
      keymap [switch-to-buffer]
      '(menu-item "Switch to buffer..." consult-buffer
		  :keys "C-x b"))
    (define-key-after
      keymap [other-window]
      '(menu-item "Next window" other-window
		  :enable (> (length (window-list)) 1)))
    (define-key-after
      keymap [previous-window]
      '(menu-item "Previous window" duomacs/previous-window
		  :enable (> (length (window-list)) 1)))
    (define-key-after
      keymap [view-sep-1]
      '(menu-item "--"))
    (define-key-after
      keymap [split-window-below]
      '(menu-item "Split window below" split-window-below))
    (define-key-after
      keymap [split-window-right]
      '(menu-item "Split window right" split-window-right))
    (define-key-after
      keymap [delete-window]
      '(menu-item "Delete this window" delete-window
		  :enable (> (length (window-list)) 1)))
    (define-key-after
      keymap [delete-other-windows]
      '(menu-item "Delete other windows" delete-other-windows
		  :enable (> (length (window-list)) 1)))
    keymap))


(defun duomacs/actions-menu ()
  "Internal function.
Creates the Actions menu."
  (let ((keymap (make-sparse-keymap))
	(search-keymap (make-sparse-keymap))
	(goto-keymap (make-sparse-keymap)))

    (define-key-after
      goto-keymap [forward-char]
      '(menu-item "Next character" forward-char
                  :keys "C-f"
                  :enable (not (eobp))))
    (define-key-after
      goto-keymap [backward-char]
      '(menu-item "Previous character" backward-char
		  :keys "C-b"
		  :enable (not (bobp))))
    (define-key-after
      goto-keymap [goto-char]
      '(menu-item "Character position..." goto-char
		  :keys "M-g c"
		  :enable (> (length (buffer-string)) 0)))
    (define-key-after
      goto-keymap [forward-word]
      '(menu-item "Next word" forward-word
		  :enable (not (eobp))))
    (define-key-after
      goto-keymap [previous-word]
      '(menu-item "Previous word" (lambda () (interactive) (forward-word -1))
		  :keys "C-u -1 M-f"
		  :enable (not (bobp))))
    (define-key-after
      goto-keymap [next-line]
      '(menu-item "Next line" next-line
		  :keys "C-n"
                  :enable (> (count-lines (point) (point-max)) 0)))
    (define-key-after
      goto-keymap [previous-line]
      '(menu-item "Previous line" previous-line
		  :enable (> (line-number-at-pos) 1)))
    (define-key-after
      goto-keymap [actions-goto-sep-1]
      '(menu-item "--"))
    (define-key-after
      goto-keymap [beginning-of-line]
      '(menu-item "Beginning of line" beginning-of-line
		  :enable (not (bolp))))
    (define-key-after
      goto-keymap [end-of-line]
      '(menu-item "End of line" end-of-line
		  :keys "C-e"
		  :enable (not (eolp))))
    (define-key-after
      goto-keymap [beginning-of-buffer]
      '(menu-item "Beginning of buffer" beginning-of-buffer
		  :enable (not (bobp))))
    (define-key-after
      goto-keymap [end-of-buffer]
      '(menu-item "End of buffer" end-of-buffer
		  :enable (not (eobp))))
    (define-key-after
      goto-keymap [actions-goto-sep-2]
      '(menu-item "--"))
    (define-key-after
      goto-keymap [flymake-goto-next-error]
      '(menu-item "Next diagnostic" flymake-goto-next-error
                  :keys "C-c ! n"
                  :enable (and flymake-mode
                               t)))
                               ;; (or (> flymake-mode-line-error-counter 0)
                               ;;     (> flymake-mode-line-warning-counter 0)
                               ;;     (> flymake-mode-line-note-counter 0)))))

    (define-key-after
      search-keymap [isearch-forward]
      '(menu-item "Plaintext search..." isearch-forward
		  :keys "C-s"))
    (define-key-after
      search-keymap [isearch-backward]
      '(menu-item "Plaintext search backward..." isearch-backward
		  :keys "C-r"))
    (define-key-after
      search-keymap [query-replace]
      '(menu-item "Plaintext search/replace..." query-replace
		  :keys "M-%"))
    (define-key-after
      search-keymap [isearch-forward-regexp]
      '(menu-item "Regexp search..." isearch-forward-regexp
		  :keys "C-M-s"))
    (define-key-after
      search-keymap [isearch-backward-regexp]
      '(menu-item "Regexp search backward..." isearch-backward-regexp
		  :keys "C-M-r"))
    (define-key-after
      search-keymap [query-replace-regexp]
      '(menu-item "Regexp search/replace..." query-replace-regexp
		  :keys "C-M-%"))

    (define-key-after
      keymap [set-mark-command]
      '(menu-item "Set/clear mark" set-mark-command
		  :keys "C-<space>"))
    (define-key-after
      keymap [goto-menu-item]
      (cons "Go to" goto-keymap))
    (define-key-after
      keymap [search-menu-item]
      (cons "Search/replace" search-keymap))
    (define-key-after
      keymap [actions-sep-1]
      '(menu-item "--"))
    (define-key-after
      keymap [universal-argument]
      '(menu-item "Run command with context prefix..." duomacs/universal-argument
		  :keys "C-u"))
    (define-key-after
      keymap [actions-sep-2]
      '(menu-item "--"))
    (define-key-after
      keymap [keyboard-quit]
      '(menu-item "Cancel current command" keyboard-quit
                  :keys "C-g"))
    keymap))


(defun duomacs/options-menu ()
  "Internal function.
Creates the Options menu."
  ;; TODO
  (let ((keymap (make-sparse-keymap)))

    (define-key-after
      keymap [customize-variable]
      '(menu-item "Customize a variable..." customize-variable))
    (define-key-after
      keymap [customize-face]
      '(menu-item "Customize a font-face..." customize-face))
    (define-key-after
      keymap [customize-group]
      '(menu-item "Customize a group of options..." customize-group))
    (define-key-after
      keymap [customize-mode]
      '(menu-item "Customize options for current mode..." customize-mode))
    keymap))


(defun duomacs/help-menu ()
  "Internal function.
Creates the Help menu."
  (let ((keymap (make-sparse-keymap "duomacs/help-keymap"))
	(describe-submenu-keymap (make-sparse-keymap)))
   
    (define-key-after
      describe-submenu-keymap [describe-function]
      '(menu-item "Describe a function..." describe-function))
    (define-key-after
      describe-submenu-keymap [describe-variable]
      '(menu-item "Describe a variable..." describe-variable))
    (define-key-after
      describe-submenu-keymap [describe-key]
      '(menu-item "Describe a keybinding..." describe-key))
    (define-key-after
      describe-submenu-keymap [describe-keymap]
      '(menu-item "Describe a keymap layer..." describe-keymap))
    (define-key-after
      describe-submenu-keymap [describe-face]
      '(menu-item "Describe a font-face..." describe-face))
    (define-key-after
      describe-submenu-keymap [describe-char]
      '(menu-item "Describe character at point..." describe-char
		  :keys "C-u C-x ="))
    (define-key-after
      describe-submenu-keymap [describe-mode]
      '(menu-item "Describe current buffer modes..." describe-mode))
    (define-key-after
      describe-submenu-keymap [apropos]
      '(menu-item "Find something else..." apropos))

    (define-key-after
      keymap [emacs-tutorial]
      '(menu-item "Emacs Tutorial" help-with-tutorial-spec-language))
    (define-key-after
      keymap [describe-menu-item]
      (cons "Describe" describe-submenu-keymap))
    (define-key-after
      keymap [help-sep-1]
      '(menu-item "--"))
    (define-key-after
      keymap [about-emacs]
      '(menu-item "About Emacs..." about-emacs
		  :keys "C-h C-a"))
    keymap))
    
(let ((menu-bar-keymap (make-sparse-keymap)))
  (define-key
   global-map [menu-bar]
   menu-bar-keymap)
  (define-key-after
    menu-bar-keymap [file]
    (cons "File" (duomacs/file-menu)))
  (define-key-after
    menu-bar-keymap [edit]
    (cons "Edit" (duomacs/edit-menu)))
  (define-key-after
    menu-bar-keymap [view]
    (cons "View" (duomacs/view-menu)))
  (define-key-after
    menu-bar-keymap [actions]
    (cons "Actions" (duomacs/actions-menu)))
  (define-key-after
    menu-bar-keymap [options]
    (cons "Options" (duomacs/options-menu)))
  (define-key-after
    menu-bar-keymap [help]
    (cons "Help" (duomacs/help-menu))))


(provide 'duomacs-menu)
;;; duomacs-menu.el ends here
