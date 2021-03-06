# Intel compilers through 2018 all flag the llvm source code's STL usage as
# syntax errors. Gnu works.
override ROLLCOMPILER = gnu
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef RPMS
  RPMS = 20
endif

BUILD_CLANG = $(subst clang=,,$(lastword $(filter clang=%,$(ROLLOPTS))))
BUILD_LLDB = $(subst lldb=,,$(lastword $(filter lldb=%,$(ROLLOPTS))))

NAME           = sdsc-llvm
VERSION        = 7.0.1
RELEASE        = 0
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

RPM.EXTRAS     = AutoReq:No\n%global __strip `which strip`\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX     = $(PKGROOT)
