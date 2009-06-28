%{
#include <stdio.h>
#include <string.h>
#include "syntax.tab.h"
YYSTYPE yylval ;

%}

DIGIT [[:digit:]]
AXIOM [[:alnum:]]*

%x comment

a [Aa]
b [Bb]
c [Cc]
d [Dd]
e [Ee]
f [Ff]
g [Gg]
h [Hh]
i [Ii]
j [Jj]
k [Kk]
l [Ll]
m [Mm]
n [Nn]
o [Oo]
p [Pp]
q [Qq]
r [Rr]
s [Ss]
t [Tt]
u [Uu]
v [Vv]
w [Ww]
x [Xx]
y [Yy]
z [Zz]

%%

role     return t_ROLE;
init     return t_INIT;
true     return t_TRUE;
does     return t_DOES;
next     return t_NEXT;
legal    return t_LEGAL;
goal     return t_GOAL;
not      return t_NOT;
terminal return t_TERMINAL;
distinct return t_DISTINCT;

"<=" return t_RELATION;
"("  return t_OP;
")"  return t_CP;

"?"{AXIOM} yylval = strdup(yytext); return t_VAR;
{DIGIT}+   yylval = strdup(yytext); return t_NUM; 
{AXIOM}+   yylval = strdup(yytext); return t_AXIOM;


";".*
[ \t\n]+


%%

