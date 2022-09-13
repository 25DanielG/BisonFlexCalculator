compile:
	bison -dv parser.y
	flex parser.l
	gcc -o calculator parser.tab.c lex.yy.c

run:
	./calculator

remove:
	rm calculator 
	rm parser.output
