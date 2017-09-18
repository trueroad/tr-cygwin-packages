# Stage 1 packages: depends only on Cygwin official package
STAGE1PKG_DIRS = \
	ghostscript \
	emacs-w32-ime \
	qdbm \
	pth \
	jpegoptim \

# Stage 2 packages: depends on phase 1 packages
STAGE2PKG_DIRS = \
	Mew \
	hyperestraier-encore \
	gnupg2.0 \

SUBDIRS = $(STAGE1PKG_DIRS) $(STAGE2PKG_DIRS)

#WWW_DIST_ROOT = /srv/www/htdocs/dist
WWW_DIST_ROOT = $(CURDIR)/$(DEPTH)/dist
