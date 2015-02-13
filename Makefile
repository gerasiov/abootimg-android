TC=$(HOME)/tc
CC=$(TC)/bin/arm-linux-androideabi-gcc
#CPPFLAGS=-DHAS_BLKID
CFLAGS=-O3 -Wall --sysroot=$(TC)/sysroot/
#LDLIBS=-lblkid
LDFLAGS=--sysroot=$(TC)/sysroot/ -lc -static

all: abootimg

version.h:
	if [ ! -f version.h ]; then \
	if [ -d .git ]; then \
	echo '#define VERSION_STR "$(shell git describe --tags --abbrev=0)"' > version.h; \
	else \
	echo '#define VERSION_STR ""' > version.h; \
	fi \
	fi

abootimg.o: bootimg.h version.h

abootimg: abootimg.o getline.o fmemopen.o fopencookie.o open_memstream.o

clean:
	rm -f abootimg *.o version.h

.PHONY:	clean all

