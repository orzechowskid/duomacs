;;; duomacs-theme-base.el --- duomacs theme colors -*- lexical-binding: t; -*-
;;; Summary:
;;; Commentary:
;;; Code:

;; palette colors

(defconst duomacs--color-gray-100 "#212121")
(defconst duomacs--color-gray-200 "#424242")
(defconst duomacs--color-gray-300 "#616161")
(defconst duomacs--color-gray-400 "#757575")
(defconst duomacs--color-gray-500 "#9e9e9e")
(defconst duomacs--color-gray-600 "#bdbdbd")
(defconst duomacs--color-gray-700 "#e0e0e0")
(defconst duomacs--color-gray-800 "#f4f4f4")
(defconst duomacs--color-gray-900 "#fafafa")
(defconst duomacs--color-gray-1000 "#ffffff")

(defconst duomacs--color-red-100 "#b71c1c")
(defconst duomacs--color-red-200 "#c62828")
(defconst duomacs--color-red-300 "#d32f2f")
(defconst duomacs--color-red-400 "#e53935")
(defconst duomacs--color-red-500 "#f44336")
(defconst duomacs--color-red-600 "#ef5350")
(defconst duomacs--color-red-700 "#e57373")
(defconst duomacs--color-red-800 "#ef9a9a")
(defconst duomacs--color-red-900 "#ffcdd2")
(defconst duomacs--color-red-1000 "#ffebee")

(defconst duomacs--color-orange-100 "#e65100")
(defconst duomacs--color-orange-200 "#ef6c00")
(defconst duomacs--color-orange-300 "#f57c00")
(defconst duomacs--color-orange-400 "#fb8c00")
(defconst duomacs--color-orange-500 "#ff9800")
(defconst duomacs--color-orange-600 "#ffa726")
(defconst duomacs--color-orange-700 "#ffb74d")
(defconst duomacs--color-orange-800 "#ff8c00")
(defconst duomacs--color-orange-900 "#ffe0b2")
(defconst duomacs--color-orange-1000 "#fff3e0")

(defconst duomacs--color-yellow-100 "#f57f17")
(defconst duomacs--color-yellow-200 "#f9a825")
(defconst duomacs--color-yellow-300 "#fbc02d")
(defconst duomacs--color-yellow-400 "#fdd835")
(defconst duomacs--color-yellow-500 "#ffeb3b")
(defconst duomacs--color-yellow-600 "#ffee58")
(defconst duomacs--color-yellow-700 "#fff176")
(defconst duomacs--color-yellow-800 "#fff59d")
(defconst duomacs--color-yellow-900 "#fff9c4")
(defconst duomacs--color-yellow-1000 "#fffde7")

(defconst duomacs--color-green-100 "#1b5e20")
(defconst duomacs--color-green-200 "#2e7d32")
(defconst duomacs--color-green-300 "#388e3c")
(defconst duomacs--color-green-400 "#43a047")
(defconst duomacs--color-green-500 "#4caf50")
(defconst duomacs--color-green-600 "#66bb6a")
(defconst duomacs--color-green-700 "#81c784")
(defconst duomacs--color-green-800 "#a5d6a7")
(defconst duomacs--color-green-900 "#c8e6c9")
(defconst duomacs--color-green-1000 "#e8f5e9")

(defconst duomacs--color-blue-100 "#01579b")
(defconst duomacs--color-blue-200 "#0277bd")
(defconst duomacs--color-blue-300 "#0288d1")
(defconst duomacs--color-blue-400 "#039be5")
(defconst duomacs--color-blue-500 "#03a9f4")
(defconst duomacs--color-blue-600 "#29b6f6")
(defconst duomacs--color-blue-700 "#4fc3f7")
(defconst duomacs--color-blue-800 "#81d4fa")
(defconst duomacs--color-blue-900 "#b3e5fc")
(defconst duomacs--color-blue-1000 "#e1f5fe")

(defconst duomacs--color-bluegray-100 "#263238")
(defconst duomacs--color-bluegray-200 "#37474f")
(defconst duomacs--color-bluegray-300 "#455a64")
(defconst duomacs--color-bluegray-400 "#546e7a")
(defconst duomacs--color-bluegray-500 "#607d8b")
(defconst duomacs--color-bluegray-600 "#78909c")
(defconst duomacs--color-bluegray-700 "#90a4ae")
(defconst duomacs--color-bluegray-800 "#b0bec5")
(defconst duomacs--color-bluegray-900 "#cfd8dc")
(defconst duomacs--color-bluegray-1000 "#eceff1")

;; semantic variables, set by various themes and userland code

(defvar duomacs-color-background duomacs--color-gray-900
  "Preferred default background color.")
(defvar duomacs-color-background-highlight-permanent duomacs--color-gray-700
  "Preferred background color for long-lived background elements.")
(defvar duomacs-color-background-highlight-transient duomacs--color-bluegray-900
  "Preferred background color for temporary elements created via user-action.")
(defvar duomacs-color-background-secondary duomacs--color-bluegray-600)
(defvar duomacs-color-background-tertiary duomacs--color-bluegray-800)
(defvar duomacs-color-comment duomacs--color-green-200)
(defvar duomacs-color-constant duomacs--color-bluegray-300)
(defvar duomacs-color-foreground duomacs--color-gray-200)
(defvar duomacs-color-foreground-secondary duomacs--color-gray-600)
(defvar duomacs-color-foreground-tertiary duomacs--color-gray-500)
(defvar duomacs-color-function-call duomacs--color-bluegray-300)
(defvar duomacs-color-error duomacs--color-red-300)
(defvar duomacs-color-info duomacs--color-bluegray-300)
(defvar duomacs-color-keyword duomacs--color-bluegray-500)
(defvar duomacs-color-typedef duomacs--color-bluegray-300)
(defvar duomacs-color-string duomacs--color-red-100)
(defvar duomacs-color-warning duomacs--color-orange-200)

;; single-purpose variables

(defvar duomacs-color-foreground-mode-line duomacs--color-gray-900)
(defvar duomacs-color-background-mode-line duomacs--color-bluegray-400)

(provide 'duomacs-theme-base)
;;; duomacs-theme-base.el ends here
