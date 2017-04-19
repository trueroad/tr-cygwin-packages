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

DEPTH ?= ..

include $(DEPTH)/config.make

PN := $(NAME)
PV := $(VERSION)
PR := $(RELEASE)

P := $(NAME)-$(VERSION)
PVR := $(VERSION)-$(RELEASE)
PF := $(NAME)-$(VERSION)-$(RELEASE)

ARCH ?= $(shell uname -m)
ifeq ($(ARCH),i686)
ARCHDIR := x86
else
ARCHDIR := $(ARCH)
endif

WORKDIR := $(PF).$(ARCH)

.PHONY: all install \
	show \
	clean fetchclean \
	fetch prep compile check cygport-install package \
	store genini genini-all

all: package
install: store genini

show:
	@echo "NAME = $(NAME)"
	@echo "VERSION = $(VERSION)"
	@echo "RELEASE = $(RELEASE)"

	@echo "PN = $(NAME)"
	@echo "PV = $(VERSION)"
	@echo "PR = $(RELEASE)"

	@echo "P = $(NAME)-$(VERSION)"
	@echo "PVR = $(VERSION)-$(RELEASE)"
	@echo "PF = $(NAME)-$(VERSION)-$(RELEASE)"

	@echo "ARCH = $(ARCH)"
	@echo "ARCHDIR = $(ARCHDIR)"

	@echo "WORKDIR = $(WORKDIR)"

	@echo "CYGPORT_FILE = $(CYGPORT_FILE)"
	@echo "FETCH_FILES = $(FETCH_FILES)"

	@echo "WWW_DIST_ROOT = $(WWW_DIST_ROOT)"

clean:
	rm -fr $(WORKDIR)

fetchclean: clean
	rm -f $(FETCH_FILES)

fetch:			$(FETCH_FILES)
prep:			$(WORKDIR)
compile:		$(WORKDIR)/log/$(PF)-compile.log
check:			$(WORKDIR)/log/$(PF)-check.log
cygport-install:	$(WORKDIR)/log/$(PF)-install.log
package:		$(WORKDIR)/log/$(PF)-pkg.log

store: $(WORKDIR)/dist/$(PN)
	mkdir -p $(WWW_DIST_ROOT)/$(ARCHDIR)/release/
	cp -R $(WORKDIR)/dist/$(PN) $(WWW_DIST_ROOT)/$(ARCHDIR)/release/

include $(DEPTH)/genini.make

$(FETCH_FILES):
	LANG=C cygport $(CYGPORT_FILE) fetch

$(WORKDIR): $(FETCH_FILES)
	LANG=C cygport $(CYGPORT_FILE) prep

$(WORKDIR)/log/$(PF)-compile.log: $(WORKDIR)
	LANG=C cygport $(CYGPORT_FILE) compile

$(WORKDIR)/log/$(PF)-check.log: $(WORKDIR)/log/$(PF)-compile.log
	LANG=C cygport $(CYGPORT_FILE) check

$(WORKDIR)/log/$(PF)-install.log: $(WORKDIR)/log/$(PF)-check.log
	LANG=C cygport $(CYGPORT_FILE) install

$(WORKDIR)/log/$(PF)-pkg.log: $(WORKDIR)/log/$(PF)-install.log
	LANG=C cygport $(CYGPORT_FILE) package
