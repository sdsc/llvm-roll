# As of v3.6.2, llvm configure/build only works w/gnu compilers.
override ROLLCOMPILER = gnu
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef RPMS
  RPMS = 20
endif

BUILD_LLDB = $(subst lldb=,,$(lastword $(filter lldb=%,$(ROLLOPTS))))

NAME           = sdsc-llvm
VERSION        = 4.0.1
RELEASE        = 2
PKGROOT        = /opt/llvm

SRC_SUBDIR     = llvm

SOURCE_NAME    = llvm
SOURCE_SUFFIX  = tar.xz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).src.$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(SOURCE_VERSION).src

CLANG_NAME     = cfe
CLANG_SUFFIX   = tar.xz
CLANG_VERSION  = $(VERSION)
CLANG_PKG      = $(CLANG_NAME)-$(CLANG_VERSION).src.$(CLANG_SUFFIX)
CLANG_DIR      = $(CLANG_NAME)-$(CLANG_VERSION).src

LLDB_NAME      = lldb
LLDB_SUFFIX    = tar.xz
LLDB_VERSION   = $(VERSION)
LLDB_PKG       = $(LLDB_NAME)-$(LLDB_VERSION).src.$(LLDB_SUFFIX)
LLDB_DIR       = $(LLDB_NAME)-$(LLDB_VERSION).src

TOOLS_NAME     = clang-tools-extra
TOOLS_SUFFIX   = tar.xz
TOOLS_VERSION  = $(VERSION)
TOOLS_PKG      = $(TOOLS_NAME)-$(TOOLS_VERSION).src.$(TOOLS_SUFFIX)
TOOLS_DIR      = $(TOOLS_NAME)-$(TOOLS_VERSION).src

TAR_XZ_PKGS    = $(SOURCE_PKG) $(CLANG_PKG) $(LLDB_PKG) $(TOOLS_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
