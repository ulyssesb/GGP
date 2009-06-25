%{
#include <stdio.h>
#include <string.h>
//#include "pascal.tab.h"
//YYSTYPE yylval ;

#define _role "role"
#define _init "init"
#define _true "true"
#define _does "does"
#define _next "next"
#define _legal "legal"
#define _goal "goal"
#define _terminal "terminal"
#define _axiom "axiom"
#define _num "num"
#define _relation "<="
#define _op "("
#define _cp ")"
#define _var "var"

/*
{DIGIT}+ yylval = strdup(yytext); return _num; 
{AXIOM}+ yylval = strdup(yytext); return _axiom;
*/

%}

DIGIT [[:digit:]]
AXIOM [[:alnum:]]*

%x comment

%%

"role" return _role;
"init" return _init;
"true" return _true;
"does" return _does;
"next" return _next;
"legal" return _legal;
"goal" return _goal;
"terminal" return _terminal;

"?"{AXIOM} return _var;
{DIGIT}+ return _num; 
{AXIOM}+ return _axiom;

"<=" return _relation;
"(" return _op;
")" return _cp;

";".*
[ \t]+


%%

int main() {
char * token;
//int token;
while (token = yylex()) printf ("%s ", token);

return 0;
}



