;;; rails-console-repl.el --- rails console repl

;; Copyright (C) 2019 by takeokunn

;; Author: takeokunn <bararararatty@gmail.com>
;; URL: https://github.com/takeokunn/rails-console-repl.el
;; Version: 0.01

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

(define-derived-mode rails-console-repl-mode comint-mode "Rails Console"
    "Major-mode for rails console REPL.")

(defvar rails-console-repl-mode-map
    (let ((map (make-sparse-keymap)))
        map))

(defvar rails-console-repl-mode-hook nil
    "List of functions to be executed on entry to `rails-console-repl-mode'.")

(defcustom rails-console-repl-exec-command '("bundle" "exec" "rails" "console")
    "Rails console repl exec command"
    :group 'rails-console-repl
    :tag "Rails console repl execution command"
    :type '())

(defvar rails-console-repl-comint-buffer-process
    nil
    "A list (buffer-name process) is arguments for `make-comint'.")
(make-variable-buffer-local 'rails-console-repl-comint-buffer-process)

(defun rails-console-repl--detect-buffer ()
    "Return tuple list, comint buffer name and program."
    (or rails-console-repl-comint-buffer-process
        '("rails-console-repl" "rails-console-repl")))

(defun rails-console-repl--make-process ()
    (apply 'make-comint-in-buffer
        (car (rails-console-repl--detect-buffer))
        (cadr (rails-console-repl--detect-buffer))
        (car rails-console-repl-exec-command)
        nil
        (cdr rails-console-repl-exec-command)))

;;;###autoload
(defun rails-console-repl ()
    (interactive)
    (let ((buf-name "rails-console-repl")
             (my-dir (read-directory-name "DIRECTORY: ")))
        (setq default-directory my-dir)
        (switch-to-buffer (rails-console-repl--make-process))
        (rails-console-repl-mode)
        (run-hooks 'rails-console-repl-hook)))
(put 'rails-console-repl 'interactive-only 'rails-console-repl-run)

;;;###autoload
(defun rails-console-repl-run (buf-name process)
    (let ((rails-console-repl-comint-buffer-process (list buf-name process)))
        (call-interactively 'rails-console-repl)))

;;;###autoload
(defun rails-console-repl-send-line ()
    (let ((str (thing-at-point 'line 'no-properties)))
        (comint-send-string (cadr (rails-console-repl--detect-buffer)) str)))


(provide 'rails-console-repl)

;;; rails-console-repl.el ends here
