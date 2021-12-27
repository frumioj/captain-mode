;;; capnp-mode.el --- major mode for editing capnproto schemas. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2021, John Kemp

;; Author: John Kemp ( stable.pseudonym@gmail.com )
;; Version: 0.1
;; Created: December 2021
;; Keywords: languages
;; Homepage: n/a

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 2.

;;; Commentary:

;; short description here

;; full doc on how to use here

;;; Code:

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq capnp-font-lock-keywords
      (let* (
            ;; define several category of keywords
            (x-keywords '("using" "import" "const" "annotation" "extends" "struct" "enum" "interface"
			  "union" "for" "if" "return" "state" "while" "in" "of"))
            (x-types '("group" "Void" "Bool" "Text" "Date" "List" "Int8" "Int16" "Int32" "Int64"
		       "UInt8" "UInt16" "UInt32" "UInt64" "Text" "Data" "Float32" "Float64"))
            (x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
            (x-events '("at_rot_target" "at_target" "attach"))
            (x-functions '("llAbs" "llAcos" "llAddToLandBanList" "llAddToLandPassList"))

            ;; generate regex string for each category of keywords
            (x-keywords-regexp (regexp-opt x-keywords 'words))
            (x-types-regexp (regexp-opt x-types 'words))
            (x-constants-regexp (regexp-opt x-constants 'words))
            (x-events-regexp (regexp-opt x-events 'words))
            (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . 'font-lock-type-face)
          (,x-constants-regexp . 'font-lock-constant-face)
          (,x-events-regexp . 'font-lock-builtin-face)
          (,x-functions-regexp . 'font-lock-function-name-face)
          (,x-keywords-regexp . 'font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

(defvar capnp-mode-syntax-table nil "Syntax table for `capnp-mode'.")

(setq capnp-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?# "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))

;;;###autoload
(define-derived-mode capnp-mode c-mode "capnproto mode"
  "Major mode for editing capnproto schemas"

  ;;; apparently not needed due to the name being auto-picked up
  (set-syntax-table capnp-mode-syntax-table)
  
  ;; code for syntax highlighting
  (setq font-lock-defaults '((capnp-font-lock-keywords))))

;; add the mode to the `features' list
(provide 'capnp-mode)

;;; capnp-mode.el ends here
