#
# TrueRoad's Cygwin Packages
# https://github.com/trueroad/tr-cygwin-packages
#
# Copyright (C) 2017, 2021 Masamichi Hosoda.
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

genini:
ifneq ("$(wildcard $(WWW_DIST_ROOT)/$(INIDIR))","")
	rm -f $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini
	mksetupini --arch $(INIDIR) \
		--disable-check missing-depended-package \
		--inifile $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini \
		--okmissing required-package \
		--releasearea $(WWW_DIST_ROOT)
	bzip2 -zck $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini > \
		$(WWW_DIST_ROOT)/$(INIDIR)/setup.bz2
	xz -zck $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini > \
		$(WWW_DIST_ROOT)/$(INIDIR)/setup.xz
	zstd -zck $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini > \
		$(WWW_DIST_ROOT)/$(INIDIR)/setup.zst
endif

signini: $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini.sig \
	$(WWW_DIST_ROOT)/$(INIDIR)/setup.bz2.sig \
	$(WWW_DIST_ROOT)/$(INIDIR)/setup.xz.sig \
	$(WWW_DIST_ROOT)/$(INIDIR)/setup.zst.sig

%.ini.sig: %.ini
	gpg -b $<
%.bz2.sig: %.bz2
	gpg -b $<
%.xz.sig: %.xz
	gpg -b $<
%.zst.sig: %.zst
	gpg -b $<

verifyini:
	gpg $(WWW_DIST_ROOT)/$(INIDIR)/setup.ini.sig
	gpg $(WWW_DIST_ROOT)/$(INIDIR)/setup.bz2.sig
	gpg $(WWW_DIST_ROOT)/$(INIDIR)/setup.xz.sig
	gpg $(WWW_DIST_ROOT)/$(INIDIR)/setup.zst.sig

genini-all:
	$(MAKE) INIDIR=x86_64 genini
	$(MAKE) INIDIR=x86 genini

signini-all:
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86_64)","")
	$(MAKE) INIDIR=x86_64 signini
endif
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86)","")
	$(MAKE) INIDIR=x86 signini
endif

verifyini-all:
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86_64)","")
	$(MAKE) INIDIR=x86_64 verifyini
endif
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86)","")
	$(MAKE) INIDIR=x86 verifyini
endif
