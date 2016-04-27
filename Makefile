CFLAGS= -std=c11 -D_GNU_SOURCE -lm
LEX=flex
YACC=bison
YFLAGS= -d

SRC=configparse.c parse.tab.c tokens.c

all: configparse

configparse: configparse.o tokens.o parse.tab.o

configparse.o: configparse.[ch]

parse.tab.o: parse.tab.c

parse.tab.c parse.tab.h: parse.y
	${YACC.y} parse.y

tokens.o: tokens.c parse.tab.h
tokens.c: tokens.l

depend: parse.tab.c
	makedepend ${SRC} -Y >& /dev/null

clean:
		rm -f *.o tokens.c parse.tab.[ch] parseconfig

test:
		cat example.txt | ./configparse
