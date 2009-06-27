all: gdl2lap clean

gdl2lap: syntax.tab.o lex.yy.o 
	gcc -o gdl2lap syntax.tab.c -lfl

syntax.tab.o: syntax.y
	bison -d syntax.y

lex.yy.o: scanner.l
	flex scanner.l
	gcc -c lex.yy.c -lfl	

clean:	
	@rm -f scanner syntax.tab.[ch] lex.yy.c *.out *.o *~ *\;

