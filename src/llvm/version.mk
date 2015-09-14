ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
ifndef ROLLPY
  ROLLPY = python
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = sdsc-llvm
VERSION        = 3.6.2
RELEASE        = 2
PKGROOT        = /opt/llvm

SRC_SUBDIR     = llvm

SOURCE_NAME    = llvm
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).src.$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(SOURCE_VERSION).src

TAR_GZ_PKGS       = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
