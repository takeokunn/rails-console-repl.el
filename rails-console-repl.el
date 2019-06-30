;;; rails-console-repl.el --- rails console repl

;; Copyright (C) 2019 by takeokunn

;; Author: takeokunn <bararararatty@gmail.com>
;; URL: https://github.com/takeokunn/rails-console-repl.el
;; Version: 0.01
;; Package-Requires: ((comint-mode))

;; GPL v3

;;; Code:

(require 'cc-mode)
(require 'comint)
(require 'thingatpt)
(require 's)
(require 'f)

(defgroup rails-console-repl nil
    "rails console repl"
    :tag "Rails"
    :prefix "rails-console-repl-"
    :group 'ruby)

(defvar rails-console-repl-map
    (let ((map (make-sparse-keymap)))
        map))

(defvar rails-console-repl-mode-hook nil
    "List of functions to be executed on entry to `rails-console-repl-mode'.")

(define-derived-mode rails-console-repl-mode comint-mode "Rails Console"
    "Major-mode for rails console REPL.")

;;;###autoload
(defun rails-console-repl-hoge ()
    (interactive)
    (let ((buf-name "rails-console-repl")
             (my-directory (read-directory-name "DIRECTORY: ")))
        (setq default-directory my-directory)
        (switch-to-buffer
            (apply 'make-comint-in-buffer buf-name my-directory  "bundle" nil '("exec" "rails" "c")))
        (rails-console-repl-mode)
        (run-hooks 'rails-console-repl-hook)))

(provide 'rails-console-repl)

;;; rails-console-repl.el ends here
