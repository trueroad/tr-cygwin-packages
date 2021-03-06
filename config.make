# Stage 1 packages: depends only on Cygwin official package
STAGE1PKG_DIRS = \
	emacs-w32-ime \
	qdbm \
	jpegoptim \
	freetype2 \
	python-scipy \
	python-cycler \
	python-dateutil \
	python-kiwisolver \

# Stage 2 packages: depends on phase 1 packages
STAGE2PKG_DIRS = \
	Mew \
	hyperestraier-encore \
	python-matplotlib \

SUBDIRS = $(STAGE1PKG_DIRS) $(STAGE2PKG_DIRS)

#WWW_DIST_ROOT = /srv/www/htdocs/dist
WWW_DIST_ROOT = $(CURDIR)/$(DEPTH)/dist
