(cond ((eq system-type 'windows-nt)
       (menu-bar-mode -1)
       (tool-bar-mode -1)
       (w32-ime-initialize)
       (setq default-input-method "W32-IME")))
