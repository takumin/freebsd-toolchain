TARGET?=i686-pc-linux-gnu

PKGNAME=linux
PKGVER=3.14.4
SUFFIX=tar.xz

SRCDIR?=${.CURDIR}/../source
OBJDIR?=/tmp/build/${TARGET}-${PKGNAME}-${PKGVER}
PREFIX?=${.CURDIR}/../toolchain/${TARGET}

SRCSITE?=https://www.kernel.org/pub/linux/kernel/v3.x

.POSIX:

all: install

.PHONY: all dirs fetch extract build install clean

dirs: ${SRCDIR} ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER} ${PREFIX}
${SRCDIR}:
	@mkdir -p ${SRCDIR}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}:
	@mkdir -p ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}
${PREFIX}:
	@mkdir -p ${PREFIX}

fetch: dirs ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-fetch-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-fetch-${PKGNAME}: ${SRCDIR}/${PKGNAME}-${PKGVER}.${SUFFIX}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-fetch-${PKGNAME}
${SRCDIR}/${PKGNAME}-${PKGVER}.${SUFFIX}:
	@fetch -o ${SRCDIR} ${SRCSITE}/${PKGNAME}-${PKGVER}.${SUFFIX}

extract: fetch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}: ${SRCDIR}/${PKGNAME}-${PKGVER}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}
${SRCDIR}/${PKGNAME}-${PKGVER}:
	@tar -xv -C ${SRCDIR} -f ${SRCDIR}/${PKGNAME}-${PKGVER}.${SUFFIX}

configure: extract ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}:
	@gmake mrproper -C ${SRCDIR}/${PKGNAME}-${PKGVER}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}

build: configure ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}:
	@gmake INSTALL_HDR_PATH=${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER} \
		headers_install -C ${SRCDIR}/${PKGNAME}-${PKGVER}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}

install: build ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}:
	@cp -rv ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/include/* ${PREFIX}/include
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}

clean:
	@rm -fr ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}
