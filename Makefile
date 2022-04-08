CC = gcc

HAVE_GNOME_H = 0

ifeq ($(HAVE_GNOME_H),1)
CFLAGS = -g -O4 -Wall -I. `gnome-config --cflags gnome gnomeui`
LDFLAGS=  `gnome-config --libs gnome gnomeui`  
else
CFLAGS = -g -O4 -Wall -I.
LDFLAGS=  
endif

LIBS = -lm 
CPU = x86_64

SRC=	Src
BIN=	Bin/$(CPU)
SOBJS=   $(SRC)/stab_snd.c $(SRC)/realtime.c $(SRC)/hash.c $(SRC)/hash.c
ROBJS=$(SRC)/plot.c $(SRC)/realtime.c $(SRC)/stab_rcv.c $(SRC)/alloc_rcv.c $(SRC)/chirps_rcv.c $(SRC)/compute_bw_contextsw_rcv.c $(SRC)/loss_reorder_rcv.c $(SRC)/open_files_rcv.c $(SRC)/parse_cmd_line_rcv.c $(SRC)/signal_alrm_rcv.c  $(SRC)/control_rcv.c $(SRC)/hash.c 
OBJS=$(SOBJS) $(ROBJS)

TARGETS=$(BIN)/stab_snd $(BIN)/stab_rcv

all: $(TARGETS)

# insert my library here
$(BIN)/stab_snd: $(SRC)/jam_prob.c $(SRC)/jam_prob.h $(SRC)/driver.c $(SRC)/stab_snd.c $(SRC)/stab.h \
			$(SRC)/delay.h config.h $(SRC)/stab_snd.h \
			$(SRC)/realtime.c $(SRC)/realtime.h $(SRC)/hash.c
	./mkinstalldirs $(BIN)
	$(CC) $(CFLAGS)  $(SOBJS) -o $(BIN)/stab_snd $(LIBS) $(LDFLAGS)

$(BIN)/stab_rcv: $(SRC)/jam_prob.c $(SRC)/jam_prob.h $(SRC)/driver.c \ 
			$(SRC)/plot.c $(SRC)/stab_rcv.c $(SRC)/stab.h \
		      $(SRC)/realtime.c $(SRC)/realtime.h config.h \
		      $(SRC)/alloc_rcv.c $(SRC)/chirps_rcv.c \
                  $(SRC)/compute_bw_contextsw_rcv.c $(SRC)/loss_reorder_rcv.c \
                  $(SRC)/open_files_rcv.c $(SRC)/parse_cmd_line_rcv.c \
		  $(SRC)/signal_alrm_rcv.c  $(SRC)/control_rcv.c \
		  $(SRC)/stab_rcv.h $(SRC)/hash.c \
	./mkinstalldirs $(BIN)
	$(CC) $(CFLAGS) $(LDFLAGS) $(ROBJS) -o $(BIN)/stab_rcv $(LIBS) 

clean: 
	rm -f ${TARGETS}
	rm -f config.cache config.log config.status

distclean: clean
	rm -f Makefile configure config.h

configure: configure.in
	autoconf

Makefile: Makefile.in configure
	./configure
