%option noyywrap
%{
#include <stdio.h>
#include "parser.tab.h"
%}
%%
[ \t]	; // ignore all whitespace
[A-Za-z_]+[A-Za-z0-9_$]* { yylval.string = strdup(yytext); return STR; }
[0-9]+\.[0-9]+ 	{yylval.floating = atof(yytext); return FLOAT;}
[0-9]+		{yylval.number = atoi(yytext); return INT;}
\n		{return NEW;}
"+"		{return ADD;}
"-"		{return SUBT;}
"*"		{return MULT;}
"/"		{return DIV;}
"("		{return LPAR;}
")"		{return RPAR;}
%%
