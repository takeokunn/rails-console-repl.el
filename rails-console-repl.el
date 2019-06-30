;;; rails-console-repl.el --- rails console repl

;; Copyright (C) 2019 by takeokunn

;; Author: takeokunn <bararararatty@gmail.com>
;; URL: https://github.com/takeokunn/rails-console-repl.el
;; Version: 0.01
;; Package-Requires: ((comint-mode))

;; GPL v3

;;; Code:

(require 'comint)
(require 'f)

(defconst rails-console-repl-number "0.01"
    "rails console repl version number.")

(defgroup rails-console-repl nil
    "rails console repl"
    :tag "Rails"
    :prefix "rails-console-repl-"
    :group 'ruby
    :link '(url-link :tag "repo" "https://github.com/takeokunn/rails-console-repl.el"))

(defcustom rails-console-repl-exec-command '("bundle" "exec" "rails" "console")
    "Rails console repl exec command"
    :group 'rails-console-repl
    :tag "Rails console repl execution command"
    :type '())

(defvar rails-console-repl-mode-hook nil
    "List of functions to be executed on entry to `rails-console-repl-mode'.")

(define-derived-mode rails-console-repl-mode comint-mode "Rails Console"
    "Major-mode for rails console REPL.")

;;;###autoload
(defun rails-console-repl-run ()
    (interactive)
    (let ((buf-name "rails-console-repl")
             (my-dir (read-directory-name "DIRECTORY: ")))
        (setq default-directory my-dir)
        (switch-to-buffer
            (apply 'make-comint-in-buffer buf-name my-dir (car rails-console-repl-exec-command) nil (cdr rails-console-repl-exec-command)))
        (rails-console-repl-mode)
        (run-hooks 'rails-console-repl-hook)))

(provide 'rails-console-repl)

;;; rails-console-repl.el ends here
