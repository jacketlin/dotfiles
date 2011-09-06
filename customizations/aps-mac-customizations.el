(if (string-equal system-type "darwin")
    (progn
      (setq mac-allow-anti-aliasing t)
      (setq browse-url-browser-function 'browse-url-default-macosx-browser)
      (setq delete-by-moving-to-trash t)
      (setq ns-pop-up-frames nil)
      (set-face-font 'default "-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
      (global-set-key (kbd "s-<return>") 'ns-toggle-fullscreen)
      (global-set-key (kbd "C-z M-w") 'mac-pbcopy)
      (global-set-key (kbd "C-z C-y") 'mac-pbpaste)))
