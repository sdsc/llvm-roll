#
# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzinita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

# NOTE: The "make rpm" invocation of this Makefile creates the sdsc-llvm rpm
# and uses recursive calls to create -llvm_2, -llvm_3, .. -llvm_$(RPMS).
# llvm files are packaged round-robin from a sorted listing of the source
# package contents--the 1st in sdsc-llvm, 2nd in -llvm_2, 3rd in -llvm_3, etc.

# NOTE: The llvm test files libbogus\*.a, used to test the linker's response
# to errors, cause problems during packaging and so are deleted.

RPM_TO_BUILD = 1

LLVM_CACHE = $(REDHAT.ROOT)/cache/build-llvm

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	$(MODULE_LOAD_PYTHON); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_PYTHON) \
	) > $@

LICENSE: $(SRC_DIRS)
	$(CHECK_LICENSE_FILES)
	echo "Open Source" > $@

build: $(SRC_DIRS)
	rm -f $(CLANG_PKG) $(LLDB_PKG) $(SOURCE_PKG) $(TOOLS_PKG)
	if test "$(RPM_TO_BUILD)" = "1"; then \
	  if test "$(BUILD_CLANG)" != "no"; then \
	    mv $(CLANG_DIR) $(SOURCE_DIR)/tools/clang; \
	    mv $(TOOLS_DIR) $(SOURCE_DIR)/tools/clang/tools/extra; \
	    if test "$(BUILD_LLDB)" != "no"; then \
	      mv $(LLDB_DIR) $(SOURCE_DIR)/tools/lldb; \
	    else \
	      rm -fr $(LLDB_DIR); \
	    fi; \
	  else \
	    rm -fr $(CLANG_DIR) $(LLDB_DIR) $(TOOLS_DIR); \
	  fi; \
	  $(MODULE_LOAD_CMAKE); \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_PYTHON); \
	  export CC=$(CC); \
	  export CXX=$(CXX); \
	  mkdir $(SOURCE_DIR)/build; \
	  cd $(SOURCE_DIR)/build; \
	  cmake -DCMAKE_INSTALL_PREFIX=$(PKGROOT) ..; \
	  $(MAKE); \
	else \
	  rm -fr $(CLANG_DIR) $(LLDB_DIR) $(SOURCE_DIR) $(TOOLS_DIR); \
	fi
	@echo "::: Package $(NAME) build complete :::"
	
install::
	if test "$(RPM_TO_BUILD)" = "1"; then \
	  $(PKGROOT_BIND_MOUNT); \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_PYTHON); \
	  cd $(SOURCE_DIR)/build; \
	  $(MAKE) install; \
	  $(PKGROOT_BIND_UMOUNT); \
	  cd ../..; \
	  $(INSTALL_LICENSE_FILES); \
	  mkdir -m 755 $(ROOT)/$(PKGROOT)/example; \
	  cp test.c $(ROOT)/$(PKGROOT)/example/; \
	  rm -fr $(LLVM_CACHE) || true; \
	  mv $(ROOT)/$(PKGROOT) $(LLVM_CACHE); \
	  rm -f `find $(LLVM_CACHE) -name libbogus\*`; \
	  for rpm in `seq 2 $(RPMS)`; do \
	    $(MAKE) NAME=$(NAME)_$$rpm RPM_TO_BUILD=$$rpm rpm; \
	  done; \
	fi
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	cd $(LLVM_CACHE); \
	find . -type f | sort | perl -e 'for(my $$i=0;<>;$$i++){chomp and `/bin/cp --parents "$$_" $(ROOT)/$(PKGROOT)/` if $$i%$(RPMS)+1 == $(RPM_TO_BUILD);}'
	versionedCompiler=`/bin/ls $(ROOT)/$(PKGROOT)/bin | /bin/grep '^clang-[0-9].*'`; \
	if test -n "$$versionedCompiler"; then \
	  ln -s $$versionedCompiler $(ROOT)/$(PKGROOT)/bin/clang || true; \
	fi
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) DESCRIPTION LICENSE
