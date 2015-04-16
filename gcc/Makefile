TARGET?=i686-pc-linux-gnu

PKGNAME!=basename ${.CURDIR}
PKGVER=4.9.0
SUFFIX=tar.bz2

SRCDIR?=${.CURDIR}/../source
OBJDIR?=/tmp/build
PREFIX?=${.CURDIR}/../toolchain/${TARGET}

SRCSITE?=http://ftp.gnu.org/gnu/${PKGNAME}/${PKGNAME}-${PKGVER}

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
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		${SRCDIR}/${PKGNAME}-${PKGVER}/configure \
			--target=${TARGET} \
			--prefix=${PREFIX} \
			--with-local-prefix=${PREFIX} \
			--with-native-system-header-dir=${PREFIX}/include \
			--with-gmp=${PREFIX} \
			--with-mpfr=${PREFIX} \
			--with-mpc=${PREFIX} \
			--with-newlib \
			--without-headers \
			--disable-nls \
			--disable-shared \
			--disable-multilib \
			--disable-decimal-float \
			--disable-threads \
			--disable-libatomic \
			--disable-libgomp \
			--disable-libitm \
			--disable-libmudflap \
			--disable-libquadmath \
			--disable-libsanitizer \
			--disable-libssp \
			--disable-libstdc++-v3 \
			--enable-languages=c,c++
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-configure-${PKGNAME}

build: configure ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}:
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		gmake all-gcc -j 8
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-build-${PKGNAME}

install: build ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}
${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}:
	@cd ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}; \
		gmake install-gcc -j 8
	@touch ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}/.toolchain-install-${PKGNAME}

clean:
	@rm -fr ${OBJDIR}/${TARGET}-${PKGNAME}-${PKGVER}
