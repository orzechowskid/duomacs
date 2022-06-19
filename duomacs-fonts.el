;;; duomacs-fonts.el --- duomacs font setup -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

(use-package use-ttf
  :straight t)

(let ((font-path (concat duomacs-root "fonts/")))
  (setq use-ttf-default-ttf-fonts
	(mapcar (lambda (el) (concat font-path el))
		'("Adobe_Source_Code_Pro/static/SourceCodePro-Light.ttf"
		  "Adobe_Source_Code_Pro/static/SourceCodePro-LightItalic.ttf"
		  "Adobe_Source_Code_Pro/static/SourceCodePro-Medium.ttf"
		  "Adobe_Source_Code_Pro/static/SourceCodePro-MediumItalic.ttf"
		  "Adobe_Source_Code_Pro/static/SourceCodePro-Bold.ttf"
		  "Adobe_Source_Code_Pro/static/SourceCodePro-BoldItalic.ttf")))
  (setq use-ttf-default-ttf-font-name "Source Code Pro Bold"))

(provide 'duomacs-fonts)
;;; duomacs-fonts.el ends here