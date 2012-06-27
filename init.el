;;; 初期化ファイル

(setq user-full-name "Yasuo Hojo")
(setq user-email-address "yhojo@pp.iij4u.or.jp")

(require 'cl)

;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; 環境に合わせた初期化を実行する。
(cond ((eq window-system 'ns)
       ;; MacOS Cocoa Emacs
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
	'japanese-jisx0208
	'("M+1VM+IPAG circle" . "iso10646-1"))
       (set-fontset-font
	(frame-parameter nil 'font)
	'mule-unicode-0100-24ff
	'("monaco" . "iso10646-1"))
       ;; Mac用IME設定
       (mac-input-method-mode)
       ))

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emu")

(load-library "pukiwiki-mode")
(setq pukiwiki-process-timeout 300)
(setq pukiwiki-site-list
      '(("MyWiki" "http://10.8.9.1/~yhojo/wiki/index.php")
      ))

