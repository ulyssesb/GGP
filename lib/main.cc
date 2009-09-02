#include "syntax.tab.hh"
#include <iostream>

using namespace std;

int main(int argc, char ** argv)
{
    GDLParser parser;
    parser.yyparse();

    int i, j;
    
    cout << "players: ";
    for (i=0 ; i < parser.gdl.gameRoles.size() ; i++) {
        cout << parser.gdl.gameRoles[i].name << " " ;
    };
    cout << endl;

    for (i=0 ; i < parser.gdl.gameStatements.size() ; i++){
        cout << parser.gdl.gameStatements[i].name <<"(";
        
        for (j=0 ; j < parser.gdl.gameStatements[i].args.size() ; j++){
            cout << parser.gdl.gameStatements[i].args[j].name ;
            if ((j+1) < parser.gdl.gameStatements[i].args.size())
                cout << ",";
        }
        
        cout << ")" << endl;
    };


    return 0;
}












