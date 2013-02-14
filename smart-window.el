;;; smart-window.el --- vim-like window controlling plugin

;; Copyright (C) 2013 by Felix Chern

;; Author: Felix Chern <idryman@gmail.com>
;; $Id: smart-windows.el 1 2013-02-11 dryman $
;; Keywords: tools, unix
;; Compatibility: Emacs 24 and above

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Code:

;; commands
;; sw-split  need more design to be vim-like
;; sw-vsplit
;; sw-buffer-split
;; sw-buffer-vsplit
;; sw-move (left, right, above, below)

;; (defvar smart-window-mode-hook nil)
;; (defvar smart-window-mode-map
;;   (let ((smart-window-map (make-keymap)))
;;     (define-key 

(defgroup smart-window nil
  "vim-like window controlling system"
  :group nil
  :prefix "smart-window")

(defvar smart-window-remap-keys t)

(global-set-key (kbd "C-x w") 'smart-window-move)
(global-set-key (kbd "C-x W") 'smart-window-buffer-split)
(global-set-key (kbd "C-x M-w") 'smart-window-file-split)
(define-key (current-global-map) (kbd "C-x 2") (if smart-window-remap-keys 'sw-below 'split-window-below))
(define-key (current-global-map) (kbd "C-x 3") (if smart-window-remap-keys 'sw-right 'split-window-right))


;; if some parameter...(global-set-key (kbd "C-x 2") 'sw-left)...


;;;###autoload
(defun smart-window-move (dir)
  (interactive 
   (list (completing--direction "Move window: ")))
      (let ((window (selected-window)))
    (select-window (split-window (frame-root-window) nil dir))
    (delete-window window)))

;;;###autoload
(defun smart-window-buffer-split (buffer-name)
  (interactive "BSelect buffer: ")
  (smart-window--split
   buffer-name
   (completing--direction "Direction: ")))

;;;###autoload
(defun smart-window-file-split (file-name)
  (interactive "FSelect file: ")
  (smart-window--split
   (find-file-noselect file-name)
   (completing--direction "Direction: ")))

;;;###autoload
(defun sw-below (buffer-name)
  (interactive "BSelect buffer: ")
  (smart-window--split buffer-name 'below))

;;;###autoload
(defun sw-above (buffer-name)
  (interactive "BSelect buffer: ")
  (smart-window--split buffer-name 'above))

;;;###autoload
(defun sw-left (buffer-name)
  (interactive "BSelect buffer: ")
  (smart-window--split buffer-name 'left))

;;;###autoload
(defun sw-right (buffer-name)
  (interactive "BSelect buffer: ")
  (smart-window--split buffer-name 'right))


;; internal functions

(defun smart-window--split (buffer-name dir)
  (set-window-buffer (select-window (split-window nil nil dir)) buffer-name))

(defun completing--direction (prompt)
  (intern (completing-read
           (concat prompt " (left/right/above/Below) ")
           (split-string "left right above below")
           nil t nil nil "below")))



(provide 'smart-window)


;;; smart-window.el ends here
