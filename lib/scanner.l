%option c++
%option noyywrap

%{
#include <sstream>
#include "syntax.tab.hh"
#include <cstdlib>
%}


AXIOM [[:alnum:]\+\-\_\#\|\<\>]*

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

or       return GDLParser::t_OR;
role     return GDLParser::t_ROLE;
init     return GDLParser::t_INIT;
true     return GDLParser::t_TRUE;
does     return GDLParser::t_DOES;
next     return GDLParser::t_NEXT;
legal    return GDLParser::t_LEGAL;
goal     return GDLParser::t_GOAL;
not      return GDLParser::t_NOT;
terminal return GDLParser::t_TERMINAL;
distinct return GDLParser::t_DISTINCT;

"<=" return GDLParser::t_RELATION;
"("  return GDLParser::t_OP;
")"  return GDLParser::t_CP;

"?"{AXIOM}  return GDLParser::t_VAR;
{AXIOM}+    return GDLParser::t_ATOM;


";".*
[ \t\n]+


%%

