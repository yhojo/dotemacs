;;; 初期化ファイル

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

