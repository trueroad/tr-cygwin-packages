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

genini:
ifneq ("$(wildcard $(WWW_DIST_ROOT)/$(ARCHDIR))","")
	rm -f $(WWW_DIST_ROOT)/$(ARCHDIR)/setup.ini
	mksetupini --arch $(ARCHDIR) \
		--inifile $(WWW_DIST_ROOT)/$(ARCHDIR)/setup.ini \
		--okmissing required-package \
		--releasearea $(WWW_DIST_ROOT)
	bzip2 -zck $(WWW_DIST_ROOT)/$(ARCHDIR)/setup.ini > \
		$(WWW_DIST_ROOT)/$(ARCHDIR)/setup.bz2
	xz -zck $(WWW_DIST_ROOT)/$(ARCHDIR)/setup.ini > \
		$(WWW_DIST_ROOT)/$(ARCHDIR)/setup.xz
endif

signini: $(WWW_DIST_ROOT)/$(ARCHDIR)/setup.ini.sig \
	$(WWW_DIST_ROOT)/$(ARCHDIR)/setup.bz2.sig \
	$(WWW_DIST_ROOT)/$(ARCHDIR)/setup.xz.sig

%.ini.sig: %.ini
	gpg -b $<
%.bz2.sig: %.bz2
	gpg -b $<
%.xz.sig: %.xz
	gpg -b $<

genini-all:
	$(MAKE) ARCHDIR=x86_64 genini
	$(MAKE) ARCHDIR=x86 genini
	$(MAKE) ARCHDIR=noarch genini

signini-all:
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86_64)","")
	$(MAKE) ARCHDIR=x86_64 signini
endif
ifneq ("$(wildcard $(WWW_DIST_ROOT)/x86)","")
	$(MAKE) ARCHDIR=x86 signini
endif
ifneq ("$(wildcard $(WWW_DIST_ROOT)/noarch)","")
	$(MAKE) ARCHDIR=noarch signini
endif
