;;; duomacs-modeline.el --- duomacs modeline setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/render-modeline (left-content right-content)
  "Internal function.
Renders modeline from LEFT-CONTENT and RIGHT-CONTENT."
  (let* ((left-str (format-mode-line left-content))
         (minor-mode-str (format-mode-line (list minor-mode-alist)))
	 (right-str (format-mode-line right-content))
	 (mid-spacing (- (window-total-width)
		         (length left-str)
                         (length minor-mode-str)
		         (length right-str)
		         2))) ; 2 = 1 char padding on each edge of modeline
    (set-text-properties 0 (length minor-mode-str) nil minor-mode-str)
    (set-text-properties 0 (length right-str) nil right-str)
    (format " %s%s%s%s "
	    left-str
            minor-mode-str
	    (format (format "%%%ds" mid-spacing) "")
	    right-str)))

(defun duomacs/build-modeline-left-half ()
  "Internal function.
Constructs the left side of the modeline."
  (list
   (cond
    (buffer-read-only
     "%")
    ((and (buffer-modified-p)
	  (buffer-file-name))
     "●")
    (t " "))
   (propertize " " 'display '(raise 0.2)) ; apply some padding to modeline
   (propertize "%b" 'face 'mode-line-buffer-id)
   (propertize " " 'display '(raise -0.2)) ; apply some more padding to modeline
   mode-name))

(defun duomacs/build-modeline-right-half ()
  "Internal function.
Constructs the right side of the modeline."
  (list
   (cond
    ((or
      (derived-mode-p
       'tabulated-list-mode 'help-mode 'special-mode 'image-mode)
      (string= (buffer-name) "*About GNU Emacs*"))
     "Type 'q' to dismiss this window")
    ((stringp vc-mode)
     (format "%s"
	     (format "%s%s"
		     (char-to-string 57504)
		     (format-mode-line '(vc-mode vc-mode) t))))
    (t ""))))


;; do not allow for clicking on the mode-line
(global-set-key [mode-line mouse-1] nil)
(global-set-key [mode-line mouse-2] nil)
(global-set-key [mode-line mouse-3] nil)


(setq-default
 mode-line-format
 '((:eval (duomacs/render-modeline
	   (duomacs/build-modeline-left-half)
	   (duomacs/build-modeline-right-half)))))


(provide 'duomacs-modeline)
;;; duomacs-modeline.el ends here
