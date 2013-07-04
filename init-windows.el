(cond ((eq system-type 'windows-nt)
       (menu-bar-mode -1)
       (tool-bar-mode -1)
       (setq default-frame-alist
	     (append '((foreground-color     . "white") ;; 文字色
		       (background-color     . "black") ;; 背景色
		       (cursor-color         . "white"  ) ;; カーソル色
		       (alpha                . (80 54)) ;; 透過設定
		       ) default-frame-alist))
       (setq initial-frame-alist default-frame-alist)
       (w32-ime-initialize)
       (setq default-input-method "W32-IME")
       (set-default-font "M+1VM+IPAG circle-10")
       (set-fontset-font (frame-parameter nil 'font)
			 'japanese-jisx0208
			 '("M+1VM+IPAG circle" . "unicode-bmp"))))
