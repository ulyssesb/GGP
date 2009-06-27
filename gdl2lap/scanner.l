%{
#include <stdio.h>
#include <string.h>
#include "syntax.tab.h"
YYSTYPE yylval ;

%}

DIGIT [[:digit:]]
AXIOM [[:alnum:]]*

%x comment

%%

"role" return t_ROLE;
"init" return t_INIT;
"true" return t_TRUE;
"does" return t_DOES;
"next" return t_NEXT;
"legal" return t_LEGAL;
"goal" return t_GOAL;
"terminal" return t_TERMINAL;
"<=" return t_RELATION;
"(" return t_OP;
")" return t_CP;

"?"{AXIOM} yylval = strdup(yytext); return t_VAR;
{DIGIT}+   yylval = strdup(yytext); return t_NUM; 
{AXIOM}+   yylval = strdup(yytext); return t_AXIOM;


";".*
[ \t\n]+


%%

