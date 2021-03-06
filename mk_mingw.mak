# $Id$
#
# Makefile for Exuberant Ctags under Win32 with MinGW compiler
#

include source.mak

REGEX_DEFINES = -DHAVE_REGCOMP -D__USE_GNU -Dbool=int -Dfalse=0 -Dtrue=1 -Dstrcasecmp=stricmp

CFLAGS = -Wall -Wno-unused-variable -Wno-unused-but-set-variable
DEFINES = -DWIN32 $(REGEX_DEFINES)
INCLUDES = -I. -Ignu_regex
CC = gcc

ctags.exe: OPT = -O4
dctags.exe: OPT = -g
dctags.exe: DEBUG = -DDEBUG
dctags.exe: SOURCES += debug.c

stags: ctags.exe
	cp ctags.exe stags.exe
	strip stags.exe

ctags.exe dctags.exe: $(SOURCES) $(REGEX_SOURCES) $(HEADERS) $(REGEX_HEADERS)
	$(CC) $(OPT) $(CFLAGS) $(DEFINES) $(INCLUDES) -o $@ $(SOURCES) $(REGEX_SOURCES)

readtags.exe: readtags.c
	$(CC) $(OPT) $(CFLAGS) -DREADTAGS_MAIN $(DEFINES) $(INCLUDES) -o $@ $<

clean:
	- rm -f ctags.exe stags.exe
	- rm -f dctags.exe
	- rm -f tags
