#
# TrueRoad's Cygwin Packages
# https://github.com/trueroad/tr-cygwin-packages
#
# Copyright (C) 2017 Masamichi Hosoda.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

DEPTH := .

include $(DEPTH)/config.make

TARGETS := all store clean fetchclean

# subdir_name/.target_name
SUBDIRS_TARGETS := \
	$(foreach t,$(TARGETS),$(addsuffix $(addprefix /.,$t),$(SUBDIRS)))

.PHONY:	all install clean fetchclean $(SUBDIRS_TARGETS) \
	show distclean genini genini-all \
	signini signini-all verifyini verifyini-all

all:		$(addsuffix /.all,$(SUBDIRS))
install:	$(addsuffix /.store,$(SUBDIRS)) genini-all

stage1:		$(addsuffix /.all,$(STAGE1PKG_DIRS))
stage1-install:	$(addsuffix /.store,$(STAGE1PKG_DIRS)) genini-all
stage2:		$(addsuffix /.all,$(STAGE2PKG_DIRS))
stage2-install:	$(addsuffix /.store,$(STAGE2PKG_DIRS)) genini-all

clean:		$(addsuffix /.clean,$(SUBDIRS))
fetchclean:	$(addsuffix /.fetchclean,$(SUBDIRS))

distclean:
	rm -fr $(WWW_DIST_ROOT)

include $(DEPTH)/genini.make

show:
	@echo "SUBDIRS = $(SUBDIRS)"
	@echo "TARGETS = $(TARGETS)"
	@echo "SUBDIRS_TARGETS = $(SUBDIRS_TARGETS)"
	@echo "WWW_DIST_ROOT = $(WWW_DIST_ROOT)"

# For subdir_name/.taraget_name:
#  make -C subdir_name target_name
$(SUBDIRS_TARGETS):
	$(MAKE) -C $(@D) $(@F:.%=%)
