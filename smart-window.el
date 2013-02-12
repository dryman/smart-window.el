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
;; sw-move (left, right, above, below)

(defun sw-move-i (arg)
  (let ((window (selected-window))
        (dir (intern arg)))
    (select-window (split-window (frame-root-window) nil dir))
    (delete-window window)))

(defun sw-move ()
  (sw-move-i
   (completing-read "Move window: (left/right/above/below) "
                    '(("left" 1) ("right" 2) ("above" 3) ("below" 4)))))





;;; smart-window.el ends here
