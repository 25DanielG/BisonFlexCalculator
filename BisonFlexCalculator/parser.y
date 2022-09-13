%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyparse();
void yyerror(char* s);
%}
%token<number> INT
%token<floating> FLOAT
%token<string> STR
%token ADD SUBT MULT DIV LPAR RPAR NEW DONE
%type<number> EXP
%type<floating> fEXP
%start prob
%union {
	int number;
	char* string;
	float floating;
}
%%
prob:
	| prob line
;
line: NEW
    | fEXP NEW { printf("Ans: %f\n", $1);}
    | EXP NEW { printf("Ans: %i\n", $1); }
    | STR NEW { printf("Exiting\n"); exit(0); }
;
fEXP: FLOAT          { $$ = $1; }
	| fEXP ADD fEXP	 { $$ = $1 + $3; }
	| fEXP SUBT fEXP { $$ = $1 - $3; }
	| fEXP MULT fEXP { $$ = $1 * $3; }
	| fEXP DIV fEXP	 { $$ = $1 / $3; }
	| LPAR fEXP RPAR { $$ = $2; }
	| EXP ADD fEXP	 { $$ = $1 + $3; }
	| EXP SUBT fEXP	 { $$ = $1 - $3; }
	| EXP MULT fEXP  { $$ = $1 * $3; }
	| EXP DIV fEXP	 { $$ = $1 / $3; }
	| fEXP ADD EXP	 { $$ = $1 + $3; }
	| fEXP SUBT EXP	 { $$ = $1 - $3; }
	| fEXP MULT EXP  { $$ = $1 * $3; }
	| fEXP DIV EXP	 { $$ = $1 / $3; }
	| EXP DIV EXP	 { $$ = $1 / $3; }
;
EXP: INT			{ $$ = $1; }
	| EXP ADD EXP	{ $$ = $1 + $3; }
	| EXP SUBT EXP	{ $$ = $1 - $3; }
	| EXP MULT EXP	{ $$ = $1 * $3; }
	| LPAR EXP RPAR	{ $$ = $2; }
;
%%
int main() {
	while(!feof(stdin))
		yyparse();
	return 0;
}
void yyerror(char* s) {
	fprintf(stderr, "Error: %s\n", s);
	exit(1);
}
