■各パッチについて
  emacs-25.1-*.diff は emacs-25.1 に対するパッチです。

  GNU emacs(x64) (http://hp.vector.co.jp/authors/VA052357/emacs.html)
  の追加機能の主なものを切り出したものと自作のものをいくつか。

# 以前は GNU emacs(x64) に近い形で IME関連、イメージフィットオプション、cmigemo組み込み を
# まとめたものを *-x64.diff として置いていましたが、各機能は個別のパッチにわけてあるし面倒にも
# なってきたので^^; *-x64.diffは削除しました。
# 必要に応じ個別のパッチを使用するようにしてください。

  GNU emacs(x64) で独自に実装されていたダイナミックロード機能は私にはうまく動かせなかったので
  そのパッチはありませんが、emacs-25 で dynamic module 機能が実装されたので似たようなことは
  できるかと思います。
  cmigemo を dynamic module で組み込むようにしてみたものを
  https://github.com/rzl24ozi/cmigemo-module
  に置いているので興味があればお試しください。

  なお GNU emacs(x64) のオリジナルの emacs からの修正部分は GNU emacs(x64) インストール後に
  C:\Program Files\GNU\Emacs23\distfiles\ にパッチがあります。


□emacs-25.1-w32-ime.diff (https://gist.github.com/rzl24ozi/8c20b904c9f5e588ba99)
  GNU emacs(x64) の IME 関連部分を切り出したものです。
  mingw版 emacs、 cygwin版 emacs-w32 に適用できます。

  configure に以下のオプションを追加しています。
  デフォルトで W32-IME, RECONVERSION, DOCUMENTFEED が有効ですが無効にしたい場合に指定してください。

--without-w32-ime      : W32-IME無効(同時にRECONVERSION、DOCUMENTFEEDも無効)
--without-reconversion : RECONVERSION無効(同時にDOCUMENTFEEDも無効)
--without-documentfeed : DOCUMENTFEED無効

□emacs-25.1-image-fit.diff (https://gist.github.com/rzl24ozi/bceff92df3359267657b)
  GNU emacs(x64) のイメージフィットオプション追加部分を切り出したものです。
  イメージフィットオプションについては GNU emacs(x64) のページを参照してください。
 
  MSYS2 や cygwin のパッケージの jpeg は libjpeg-turbo のようですが この場合イメージフィットオプションが
  効かないようです。
  試してみるなら http://www.ijg.org/ からソースを取得し自ビルドして使用するなどしてください。

□emacs-25.1-cmigemo.diff (https://gist.github.com/rzl24ozi/6b1207d20970737f44c7)
  GNU emacs(x64) でダイナミックロード機能が独自に実装される前の cmigemo 組み込み部分です。

  configure に以下のオプションを追加しています。
  デフォルトで cmigemo 組み込みが有効ですが無効にしたい場合に以下を指定してください。

--without-cmigemo      : cmigemo組み込み無効

  emacs 本体に修正を加えるのがためらわれるなら dynamic module として組み込むもの
  (https://github.com/rzl24ozi/cmigemo-module)もありますのでお試しください。

□emacs-25.1-cygwin-rsvg.diff (https://gist.github.com/rzl24ozi/b0165eaf404a0c5a47ae)
  cygwin版 emacs-w32 に rsvg を組み込みます。

□emacs-25.1-mingw-imagemagick.diff (https://gist.github.com/rzl24ozi/69c54eb86974fa1cbea1)
  mingw版 emacs に imagemagick を組み込みます。

□emacs-25.1-disable-w32-ime.diff (https://gist.github.com/rzl24ozi/76aadcfc58404d9e7326)
  mingw版 emacs、cygwin版 emacs-w32 に 以下の関数を追加します。

  (disable-w32-ime)    ; IME無効化(IMEをONにできなくなります)
  (enable-w32-ime)     ; IME無効化を元に戻す
  (w32-ime-disabled-p) ; IMEが無効化されている場合 t を返す

□emacs-25.1-ImmDisableIME.diff (https://gist.github.com/rzl24ozi/4808fbd8fb3122933d7f)
  mingw版 emacs、cygwin版 emacs-w32 で 起動時に ImmDisableIME () を使用して IME を無効化します。
  IME 有効にはできません。W32-IMEイラネ な人向け。やっていることは
  http://d.hatena.ne.jp/pekke/20140525/1401001174
  にあるものと同じです。


■w32-imeパッチ済バイナリ
  本家 emacs リリース直後などは emacs が最新版でないかもしれませんが w32-imeパッチ済バイナリが以下で
  公開されています。
  IME パッチ版を手っ取り早く動かしたい方はどうぞ。

  mingw64版: chuntaro 氏により https://github.com/chuntaro/NTEmacs64 にて
  mingw32版: Wurly 氏により http://cha.la.coocan.jp/doc/NTEmacs.html にて
  cygwin版(32bit): gnupack (http://sourceforge.jp/projects/gnupack/) に
                   w32-ime, cygwin-rsvg, disable-w32-ime パッチ済 emacs-w32 が同梱


■MinGW 版のビルド
  MSYS2 インストールについて詳細は
  http://sourceforge.net/p/msys2/wiki/MSYS2%20installation/
  などご参照ください。
  その他、chuntaro 氏が https://github.com/chuntaro/NTEmacs64 にて公開されているビルド手順など参考に
  させていただきました。
  ありがとうございます。こちらもご参照ください。

□MSYS2
  MSYS2 インストーラー
  https://sourceforge.net/projects/msys2/files/Base/x86_64/ の msys2-x86_64-YYYYMMDD.exe (64bit Windows の場合)
  https://sourceforge.net/projects/msys2/files/Base/i686/ の msys2-i686-YYYYMMDD.exe (32bit Windows の場合)
  (YYYYMMDDは年月日)
  をダウンロード、実行しインストール。インストーラーが起動しないようなら別の日付のものを試してみてください。
  インストーラー終了時 MSYS2 実行中のチェックを入れたまま完了、起動した MSYS2 シェルで

$ pacman -Syuu

  としてシステムを更新。終わったら Alt+F4 で終了。


□emacs のビルド
  cygwin をインストールしている環境で cygwin の bin などを PATH に入れているとうまくビルドできない
  ことがあるようなので cygwin は PATH から除外しておいてください。
  ビルドの邪魔になることがあるのでセキュリティソフトなどは一時的に停止しておいた方がよいかと思います。

  以下は 64bit 版のビルドになります。
  32bit 版のビルドであれば mingw32.exe を起動し x86_64 を i686 に読みかえて作業してください。
  Windows が 32bit 版の場合は当然 64bit 版のビルドは無理なので 32bit 版をビルドしてください。

  MSYS2 インストール先の mingw64.exe を起動し、

$ pacman -S base-devel
$ pacman -S mingw-w64-x86_64
$ pacman -S mingw-w64-x86_64-gcc
$ pacman -S mingw-w64-x86_64-giflib
$ pacman -S mingw-w64-x86_64-gnutls
$ pacman -S mingw-w64-x86_64-librsvg
$ pacman -S mingw-w64-x86_64-xpm-nox

  でビルド関連のパッケージをインストール。

  emacs-25.1 ソースを展開しソーストップディレクトリに移動。
  必要に応じパッチを当ててください。

  configure.ac を変更するパッチを当てた場合は

$ ./autogen.sh

  を実行し configure を生成しなおしておいてください。


  emacs-25.1 ソーストップディレクトリで

$ ./configure --host=x86_64-w64-mingw32 --prefix=(emacsインストール場所)
$ make
$ make install

  で emacs 本体のインストール完了。


  32bit 版では emacs が終了時にクラッシュすることがあるようなので LDFLAGS=-shared-libgcc を指定して
  おいた方がよいでしょう。

  --prefix は x:/... の形式で指定すると src/epaths.h の PATH_SITELOADSEARCH の設定に失敗し site-lisp
  が load-path の デフォルトに入らなくなります。/x/...  のように指定してください。


  デフォルトで CFLAGS が -g3 -O2 になるのでビルドされた emacs のファイルサイズがデバッグ情報のため
  大きくなります。デバッグする必要がないなら configure 時に CFLAGS=-O2 などと指定するか、
  make install-strip でインストールするなどしてください。


  デフォルトで make install 時に .info や .el が圧縮されますが圧縮したくない場合は configure に
  --without-compress-install を指定するか、

$ make GZIP_PROG="" install

  でインストールしてください。


[imagemagick組み込み]
  emacs-25.1-mingw-imagemagick.diff を当てた場合は ImageMagick が組み込めますが、emacs 本体が
  ImageMagick-6 までにしか対応していないようなので MSYS2 パッケージの mingw-w64-x86_64-imagemagick
  最新版は使えません。以前の ImageMagick-6 のときに何故かうまく画像が表示できなかったこともあり私は
  ImageMagick を以下のように自ビルドしています。


  パッケージの mingw-w64-x86_64-imagemagick をインストールしていたら

$ pacman -Rs mingw-w64-x86_64-imagemagick

  で削除。


  http://www.imagemagick.org/download/releases/
  から ImageMagick-6.8.9-10 ソースをダウンロードし展開、ソーストップディレクトリに移動して

$ ./configure --host=x86_64-w64-mingw32 --enable-hdri --with-rsvg --prefix=(ImageMagickインストール場所)
$ make install


  emacs の configure 実行時に PKG_CONFIG_PATH を
  PKG_CONFIG_PATH=(ImageMagickインストール場所)/lib/pkgconfig:$PKG_CONFIG_PATH
  に設定、emacs の make 時に PATH に (ImageMagickインストール場所)/bin を追加しておいてください。

  ここではとりあえずソースに修正を加えずビルドできたバージョンの imagemagick を使用しましたが、
  https://sourceforge.net/projects/msys2/files/REPOS/MINGW/Sources/
  の mingw-w64-x86_64-imagemagick-6 パッケージソース(いずれ削除されるかもしれませんが)に含まれている
  パッチを参考にすれば ImageMagick-6.9.* はビルドできるかと思います。
  新しめのものの方がいいとかであればお試しください。


[cmigemo組み込み]
  emacs-25.1-cmigemo.diff を当てた場合は cmigemo が組み込めます。組み込む場合は
  https://osdn.jp/projects/nkf/downloads/64158/nkf-2.1.4.tar.gz/
  から nkf のソースを取得してmake、インストールしておき
  http://www.kaoriya.net/software/cmigemo (https://github.com/koron/cmigemo)
  から C/Migemo のソースコードを取得して展開、ソーストップディレクトリに
  移動して

$ ./configure --prefix=(cmigemoインストール場所)
$ make mingw-install

  でインストール。
  emacs の configure 実行時に

$ CPPFLAGS=-I(cmigemoインストール場所)/include ./confiugre ...

  のように指定してください。


[DLLなどのコピー]
  MSYS2 環境外でも使えるように dynamic-library-alist にある dll とそれらが依存する dll、emacs 本体が
  依存する dll を /mingw64/ 下 (32bit 版であれば /mingw32/ 下) から (emacsインストール場所)/bin/ 下へ
  コピーしておいてください。

  dll の依存関係は Dependency Walker (http://www.dependencywalker.com/) などでわかります。
  私の場合は以下をコピーしました。


libgcc_s_seh-1.dll # 64bit版の場合
libgcc_s_dw2-1.dll # 32bit版の場合

libXpm-noX4.dll
libbz2-1.dll
libcairo-2.dll
libcroco-0.6-3.dll
libexpat-1.dll
libffi-6.dll
libfontconfig-1.dll
libfreetype-6.dll
libgdk_pixbuf-2.0-0.dll
libgif-7.dll
libgio-2.0-0.dll
libglib-2.0-0.dll
libgmodule-2.0-0.dll
libgmp-10.dll
libgnutls-30.dll
libgobject-2.0-0.dll
libgraphite2.dll
libharfbuzz-0.dll
libhogweed-4-2.dll
libiconv-2.dll
libidn-11.dll
libintl-8.dll
libjpeg-8.dll
liblzma-5.dll
libnettle-6-2.dll
libp11-kit-0.dll
libpango-1.0-0.dll
libpangocairo-1.0-0.dll
libpangoft2-1.0-0.dll
libpangowin32-1.0-0.dll
libpcre-1.dll
libpixman-1-0.dll
libpng16-16.dll
librsvg-2-2.dll
libstdc++-6.dll
libtasn1-6.dll
libtiff-5.dll
libwinpthread-1.dll
libxml2-2.dll
zlib1.dll

  imagemagick を組み込んだ場合はさらに

libgomp-1.dll

  および (ImageMagickインストール場所)/bin から

libMagickCore-6.Q16HDRI-2.dll
libMagickWand-6.Q16HDRI-2.dll

  を、cmigemo を組み込んだ場合は (cmigemoインストール場所)/bin から

migemo.dll

  をコピーしておいてください。

  cmigemo を組み込んだ場合は
  (cmigemoインストール場所)/share/migemo/utf-8/*
  も (emacsインストール先)/share/emacs/25.1/etc/migemo/utf-8/ 下へコピーしておいてください。
  cmigemo.el を load すれば migemo のインクリメンタル検索ができます。
  cmigemo.el は emacs-25.1-cmigemo.diff を当てた後の site-lisp/ 下にあります。

■cygwin emacs-w32 のビルド
  ビルド関連のライブラリはパッケージの *-devel をインストールしておけばよいです。
  pkg-config, autoconf, automake 他、ビルドに必要なコマンド類もパッケージからインストールしておいて
  ください。

  configure.ac を変更するパッチを当てた場合は configure 実行前に

$ ./autogen.sh

  を実行して configure を生成しなおしておいてください。

  emacs-25.1-cmigemo.diff を当てて cmigemo を組み込むなら
  https://osdn.jp/projects/nkf/downloads/64158/nkf-2.1.4.tar.gz/
  から nkf のソースを取得してmake、インストールしておき
  http://www.kaoriya.net/software/cmigemo (https://github.com/koron/cmigemo)
  から C/Migemo ソースコードを取得、

$ ./configure
$ make cyg-install

  でインストールしておいてください。

  emacs-25.1 ソーストップディレクトリで

$ ./configure --with-w32 --prefix=(emacsインストール場所)
$ make
$ make install

 でインストール完了です。

以上
