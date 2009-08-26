#ifndef _GDL_STRUCT_HH_
#define _GDL_STRUCT_HH_

#include <iostream>
#include <string>
#include <vector>

using namespace std;

class GDLAtom {
public:
    string name;

    GDLAtom();
    GDLAtom(const string atom_name) {
        this->name = atom_name;
    }

    int operator==(const GDLAtom &atom) {
        if (this->name.compare(atom.name) == 0)
            return 1;
        return 0;
    }

    int operator<(const GDLAtom &atom) {
        return 0;
    }
};

class GDLTerm {
public:
    GDLTerm () ;

    int arity;
    GDLAtom functor;
    vector<GDLTerm> args;

    int operator==(const GDLTerm &term) {
        return (this->functor == term.functor);
    }

    int operator<(const GDLTerm &term) {
        return 0;
    }
};

class GDLStruct {
public:
    GDLStruct(){};

    vector<GDLTerm> gameStatements, gameNexts, gameGoals,
                    gameTerminals, gameRelations;
    vector<GDLAtom> gameRoles;
};

extern GDLStruct gdl;


#endif
