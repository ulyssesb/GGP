#include "syntax.tab.hh"
#include <iostream>
using namespace std;
int main(int argc, char ** argv)
{
    GDLParser parser;
    parser.yyparse();
    int i;

    cout << "players: ";
    for (i=0 ; i < parser.gdl.gameRoles.size() ; i++) {
        cout << parser.gdl.gameRoles[i].name << " " ;
    };
    cout << endl;


    return 0;
}












