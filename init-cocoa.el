;; MacOS X Cocoa Emacs向けの初期化を行う。

(cond ((eq window-system 'ns)
       ;; ツールバーはいらないので消す。
       (tool-bar-mode -1)
       ;; default screen size
       (setq default-frame-alist
	     (append (list
		      '(width . 60) ;; TODO: 何故か、Cocoa Emacsでは幅が全角ベース
		      '(height . 37)
		      '(top . 0)
		      '(left . 0))
		     default-frame-alist))
       ;; 透過表示設定
       (set-frame-parameter (selected-frame) 'alpha '(79 60))
       ;; kill-ringはテキスト属性を保存しない
       (defadvice kill-new (around my-kill-ring-disable-text-property activate)
	 (let ((new (ad-get-arg 0)))
	   (set-text-properties 0 (length new) nil new)
	   ad-do-it))
       ;; MacOS Cocoa Emacs font settings
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
       (setq default-input-method "MacOSX")
;       (mac-input-method-mode 1)
       ))