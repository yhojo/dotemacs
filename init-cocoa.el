;; MacOS X Cocoa Emacs向けの初期化を行う。

(cond ((eq window-system 'ns)
       ;; ツールバーはいらないので消す。
       (tool-bar-mode -1)
       ;; default screen size
       (setq default-frame-alist
	     (append (list
		      '(width . 120)
		      '(height . 37)
		      '(top . 0)
		      '(left . 0)
		      '(foreground-color . "white")
		      '(background-color . "black")
		      '(cursor-color     . "white"))
		     default-frame-alist))
       ;; 透過表示設定
       (set-frame-parameter (selected-frame) 'alpha '(80 65))
       (add-hook 'after-make-frame-functions
		 (function (lambda (frame) (set-frame-parameter frame 'alpha '(80 65)))))
       ;; kill-ringはテキスト属性を保存しない
       (defadvice kill-new (around my-kill-ring-disable-text-property activate)
	 (let ((new (ad-get-arg 0)))
	   (set-text-properties 0 (length new) nil new)
	   ad-do-it))
       ;; MacOS Cocoa Emacs font settings
       (setenv "LANG" "ja_JP.UTF-8")
       ;; Unicode NFD problem. see http://www.sakito.com/2010/05/mac-os-x-normalization.html
       (require 'ucs-normalize)
       (setq shell-mode-hook
	     (function (lambda()
			 (set-buffer-process-coding-system 'utf-8-hfs
							   'utf-8))))
       (set-face-attribute
	'default nil
	:family "M+1VM+IPAG circle"
	:height 140)
       (set-fontset-font
	(frame-parameter nil 'font)
	'japanese-jisx0208
	'("M+1VM+IPAG circle" . "iso10646-1"))
       (set-fontset-font
	(frame-parameter nil 'font)
	'katakana-jisx0201
	'("M+1VM+IPAG circle" . "iso10646-1"))
       (set-fontset-font
	(frame-parameter nil 'font)
	'mule-unicode-0100-24ff
	'("monaco" . "iso10646-1"))
       ;; Mac用IME設定
       (setq default-input-method "MacOSX")
;       (mac-input-method-mode 1)
       ;;
       ;; トラックパッド・スクロールの設定
       ;;
       (defun scroll-down-with-lines ()
	 "" (interactive) (scroll-down 3))
       (defun scroll-up-with-lines ()
	 "" (interactive) (scroll-up 3))
       (global-set-key [wheel-up] 'scroll-down-with-lines)
       (global-set-key [wheel-down] 'scroll-up-with-lines)
       (global-set-key [double-wheel-up] 'scroll-down-with-lines)
       (global-set-key [double-wheel-down] 'scroll-up-with-lines)
       (global-set-key [triple-wheel-up] 'scroll-down-with-lines)
       (global-set-key [triple-wheel-down] 'scroll-up-with-lines)
       ;;
       ;; 謝ってCMD-Qを押してしまうことの対策。
       ;;
       (setq confirm-kill-emacs 'y-or-n-p)
       )

      ;;
      ;; PATH変数を引き継ぐための関数定義
      ;;
      (defun set-exec-path-from-shell-PATH ()
        "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
        (interactive)
        (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
          (setenv "PATH" path-from-shell)
          (setq exec-path (split-string path-from-shell path-separator))))
      ;; PATH変数を引き継ぐ
      (set-exec-path-from-shell-PATH)
      )
