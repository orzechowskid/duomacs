;;; duomacs-keys.el --- duomacs keybindings setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

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

(provide 'duomacs-keys)
;; duomacs-keys.el ends here
