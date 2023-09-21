;;; duomacs-keys.el --- duomacs keybindings setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/delete-word (arg)
  "Delete a word (instead of placing it on the kill ring).
If a numerical ARG is given, do it that many times."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun duomacs/delete-word-backward (arg)
  "Forward-delete a word (instead of placing it on the kill ring).
If a numerical ARG is given, do it that many times."
  (interactive "p")
  (duomacs/delete-word (- arg)))

;; Ctrl-PgDn -> next window
(global-set-key
 (kbd "C-<next>")
 'other-window)
;; Ctrl-Tab -> next window
(global-set-key
 (kbd "C-<tab>")
 'other-window)
;; Ctrl-PgUp -> previous window
(global-set-key
 (kbd "C-<prior>")
 (lambda ()
   (interactive)
   (other-window -1)))
;; Ctrl-a -> select all
(global-set-key
 (kbd "C-a")
 'mark-whole-buffer)
;; Ctrl-<Backspace> -> delete a word instead of killing it
(global-set-key
 (kbd "C-<backspace>")
 'duomacs/delete-word-backward)
;; Ctrl-<Delete> -> forward-delete a word instead of killing it
(global-set-key
 (kbd "C-<delete>")
 'duomacs/delete-word)

;; remove keybinding for suspend-frame since it's too easy to fat-finger
(global-set-key
 (kbd "C-x C-z")
 nil)
;; remove keybinding for kill-region since cua-mode C-x is preferred when a
;; region is active, and  kills to point-min if no region is active (!)
(global-set-key
 (kbd "C-w")
 nil)

(provide 'duomacs-keys)
;;; duomacs-keys.el ends here
