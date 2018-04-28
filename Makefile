#EXECS = retrogame gamera
EXECS = gpio2kbd
CC    = gcc $(CFLAGS) -Wall -Ofast -fomit-frame-pointer -funroll-loops -s

all: $(EXECS)

gpio2kbd: retrogame.c keyTable.h
	$(CC) $< -o $@
	strip $@

KEYFILE = /usr/include/linux/input-event-codes.h
keyTable.h: keyTableGen.sh $(KEYFILE)
	sh $^ >$@

gamera: gamera.c
	$(CC) $< -lncurses -lmenu -lexpat -o $@
	strip $@

install:
	mv $(EXECS) /usr/local/bin

clean:
	rm -f $(EXECS) keyTable.h
