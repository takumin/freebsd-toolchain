TARGET?=i686-pc-linux-gnu

PKGNAME!=basename ${.CURDIR}
PKGVER=6.0.0
SUFFIX=tar.bz2

SRCDIR?=${.CURDIR}/../source
OBJDIR?=/tmp/build/${TARGET}-${PKGNAME}-${PKGVER}
PREFIX?=${.CURDIR}/../toolchain/${TARGET}

SRCSITE?=http://ftp.gnu.org/gnu/${PKGNAME}

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
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-fetch-${PKGNAME}: ${SRCDIR}/${PKGNAME}-${PKGVER}a.${SUFFIX}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-fetch-${PKGNAME}
${SRCDIR}/${PKGNAME}-${PKGVER}a.${SUFFIX}:
	@fetch -o ${SRCDIR} ${SRCSITE}/${PKGNAME}-${PKGVER}a.${SUFFIX}

extract: fetch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}: ${SRCDIR}/${PKGNAME}-${PKGVER}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-extract-${PKGNAME}
${SRCDIR}/${PKGNAME}-${PKGVER}:
	@tar -xv -C ${SRCDIR} -f ${SRCDIR}/${PKGNAME}-${PKGVER}.${SUFFIX}

configure: extract ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}:
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		${SRCDIR}/${PKGNAME}-${PKGVER}/configure \
			--prefix=${PREFIX}
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}

build: configure ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}:
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		gmake -j 8
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}

install: build ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}:
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		gmake install -j 8
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}

clean:
	@rm -fr ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}
