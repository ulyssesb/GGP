TRASH = syntax.tab.cc syntax.tab.hh lex.yy.cc

all: parserGDL clean

parserGDL: syntax.tab.o lex.yy.o main.cc
	g++ -o parserGDL main.cc syntax.tab.o lex.yy.o

syntax.tab.o: syntax.yy
	bison++ -d -h syntax.tab.hh -o syntax.tab.cc syntax.yy
	g++ -c syntax.tab.cc -Wno-write-strings

lex.yy.o: scanner.l
	flex++ scanner.l
	g++ -c lex.yy.cc

clean:	
	@rm -f ${TRASH} *.out *.o *~ *\;
