;;; duomacs-modeline.el --- duomacs modeline setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(defun duomacs/render-modeline (left-content right-content)
  "Internal function.  Renders mode-line contents."
  (let* ((left-str (format-mode-line left-content))
				 (minor-mode-str (format-mode-line minor-mode-alist))
				 (right-str (format-mode-line right-content))
				 (mid-spacing (- (window-total-width)
												 (length left-str)
												 (length minor-mode-str)
												 (length right-str)
												 4))) ; account for padding on either side of mode-line
    (set-text-properties 0 (length minor-mode-str) nil minor-mode-str)
    (set-text-properties 0 (length right-str) nil right-str)
    (format " %s%s%s%s "
						left-str
						minor-mode-str
						(format (format "%%%ds" mid-spacing) "")
						right-str)))

(defun duomacs/build-modeline-left-side ()
  "Internal function.  Creates the formatter for the left side of the modeline."
  (list
   (cond
    (buffer-read-only
     "%")
    ((and (buffer-modified-p)
					(buffer-file-name))
     "●")
    (t
     " "))
   " "
   (propertize "%b" 'face 'mode-line-buffer-id)
   " "
   (format "%s"
					 (if (listp mode-name)
							 (car mode-name)
						 mode-name))))

(defun duomacs/build-modeline-right-side ()
  "Internal function.  Creates the formatter for the right side of the modeline."
  (list
   (cond
    ((or (derived-mode-p '(special-mode
													 tabulated-list-mode
													 magit-stash-mode))
				 (string= (buffer-name)
									"*About GNU Emacs*"))
     "Type 'q' to dismiss this buffer")
    ((stringp vc-mode)
     (format "%s"
						 (format "%s%s"
										 (char-to-string 57504)
										 (format-mode-line '(vc-mode vc-mode) t))))
    (t
     ""))
	 (cond
		((eq major-mode 'eat-mode)
		 "Terminal")
		((derived-mode-p '(special-mode))
		 "")
		(t
		 " %l:%c"))))

(setq-default
 header-line-format '((:eval
											 (duomacs/render-modeline (duomacs/build-modeline-left-side)
																								(duomacs/build-modeline-right-side))))
 mode-line-format nil)

(provide 'duomacs-modeline)
;;; duomacs-modeline.el ends here
