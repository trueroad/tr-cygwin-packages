PV=26.1

/usr/sbin/update-alternatives \
    --install /usr/bin/emacs emacs /usr/emacs-w32-ime/${PV}/bin/emacs.exe 40
/usr/sbin/update-alternatives \
    --install /usr/bin/emacsclient emacsclient /usr/emacs-w32-ime/${PV}/bin/emacsclient.exe 40
ln -s /usr/share/emacs/site-lisp /usr/emacs-w32-ime/${PV}/share/emacs/site-lisp/emacs-site-lisp
