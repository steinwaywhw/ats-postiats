#
# Makefile for [atscc]
#

######
#
CC=gcc -std=c99 -D_XOPEN_SOURCE
#
#CC=clang -std=c99 -D_XOPEN_SOURCE
#
######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######
#
CFLAGS :=
#
CFLAGS += -I./libcurl
CFLAGS += -I./libjson-c
#
CFLAGS += $(shell pkg-config --cflags json-c)
CFLAGS += $(shell pkg-config --cflags libcurl)
#
######
#
LDFLAGS :=
#
LDFLAGS += $(shell pkg-config --libs json-c)
LDFLAGS += $(shell pkg-config --libs libcurl)
#
######

all:: atsreloc_curl
all:: atsreloc_wget

######
#
atsreloc_curl: \
atsreloc_curl.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
#
######
#
atsreloc_wget: \
atsreloc_wget.dats \
atsreloc_wget_lib.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $^ $(LDFLAGS)
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) atsreloc_curl
cleanall:: ; $(RMF) atsreloc_wget

######

###### end of [Makefile] ######
