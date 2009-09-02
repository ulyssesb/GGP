#ifndef _GDL_STRUCT_HH_
#define _GDL_STRUCT_HH_

#include <iostream>
#include <string>
#include <vector>

using namespace std;

class GDLTerm {
public:
    int arity;
    string name;
    vector<GDLTerm> args;
    
    GDLTerm() {};
    GDLTerm (string name_, int arity_=0, vector<GDLTerm> args_=vector<GDLTerm>()) {
        arity = arity_;
        name = name_;
        args = args_;
    }

    int operator==(const GDLTerm &term) {
        return (this->name == term.name);
    }

    int operator<(const GDLTerm &term) {
        return 0;
    }

    bool isAtom () {
        return (this->arity==0)? true : false;
    }
};

class GDLPredicate : public GDLTerm {
public:
    vector<GDLTerm> rules;
};

class GDLStruct {
public:
    GDLStruct(){};

    vector<GDLTerm> gameStatements;
    vector<GDLTerm> gameRoles;
    vector<GDLPredicate> gamePredicates;
};

extern GDLStruct gdl;


#endif
