#include "syntax.tab.hh"
#include <iostream>
using namespace std;
int main(int argc, char ** argv)
{
    GDLParser parser;
    parser.yyparse();
    return 0;
}












