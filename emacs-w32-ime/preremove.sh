PV=26.1

/usr/sbin/update-alternatives \
    --remove emacs /usr/emacs-w32-ime/${PV}/bin/emacs.exe
/usr/sbin/update-alternatives \
    --remove emacsclient /usr/emacs-w32-ime/${PV}/bin/emacsclient.exe
rm /usr/emacs-w32-ime/${PV}/share/emacs/site-lisp/emacs-site-lisp
