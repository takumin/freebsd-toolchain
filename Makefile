TARGET?=i686-pc-linux-gnu
PATH=./toolchain/${TARGET}/bin:${PATH}

.POSIX:

all: install

.PHONY: all install clean

install:
	@${MAKE} -C gmp install
	@${MAKE} -C mpfr install
	@${MAKE} -C mpc install
	@${MAKE} -C binutils install
	@${MAKE} -C gcc install
	@${MAKE} -C linux-header install

clean:
	@${MAKE} -C gmp clean
	@${MAKE} -C mpfr clean
	@${MAKE} -C mpc clean
	@${MAKE} -C binutils clean
	@${MAKE} -C gcc clean
	@${MAKE} -C linux-header clean
	@rm -fr ${OBJDIR}
	@rm -fr ${PREFIX}
