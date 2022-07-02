;;; duomacs-modeline.el --- duomacs modeline setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/render-modeline (left-content right-content)
  "Internal function.  Renders modeline."
  (let* ((left-str (format-mode-line left-content))
	 (right-str (format-mode-line right-content))
	 (mid-spacing (- (window-total-width)
		     (length left-str)
		     (length right-str)
		     2))) ; 2 = 1 char padding on each side
    (format " %s%s%s "
	    left-str
	    (format (format "%%%ds" mid-spacing) "")
	    right-str)))

(defun duomacs/build-modeline-left-half ()
  "Internal function.  Constructs the left side of the modeline."
  (list
   (cond
    (buffer-read-only
     "-")
    ((and (buffer-modified-p)
	  (buffer-file-name))
     "●")
    (t " "))
   " "
   (propertize "%b" 'face 'mode-line-buffer-id)
   " "
   mode-name
   minor-mode-alist))

(defun duomacs/build-modeline-right-half ()
  "Internal function.  Constructs the right side of the modeline."
  (list
   (cond
    ((or
      (eq major-mode 'help-mode)
      (eq major-mode 'special-mode)
      (eq major-mode 'Custom-mode))
     "Type 'q' to dismiss this window")
    ((stringp vc-mode)
     (format "%s"
	     (format "%s%s"
		     (char-to-string 57504)
		     (format-mode-line '(vc-mode vc-mode)))))
    (t ""))))

(setq-default
 mode-line-format
 '((:eval (duomacs/render-modeline
	   (duomacs/build-modeline-left-half)
	   (duomacs/build-modeline-right-half)))))

(provide 'duomacs-modeline)
;; duomacs-modeline.el ends here
