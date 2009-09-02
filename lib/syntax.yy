%name GDLParser

%define MEMBERS \
    virtual ~GDLParser() {} \
    private: \
        yyFlexLexer scanner; \
        string atomName; \
    public: \
        GDLStruct gdl; 


%define LEX_BODY {return scanner.yylex();}
%define ERROR_BODY {fprintf(stderr, "error at line: %d ; %s\n", scanner.lineno(),scanner.YYText());}
%define STYPE vector<GDLTerm>

%header{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include "gdlStruct.hh"
%}

%token t_ROLE t_INIT t_TRUE t_DOES t_NEXT t_LEGAL t_GOAL
%token t_TERMINAL t_ATOM t_NOT t_RELATION t_OP t_CP t_VAR
%token t_DISTINCT t_OR

%start game_desc


%%
game_desc: role_set init_set rules;

role_set: role |
          role_set role;
role:     t_OP t_ROLE t_ATOM {gdl.gameRoles.push_back(GDLTerm(scanner.YYText()))} t_CP;


init_set: init |
          init_set init;
init:     t_OP t_INIT arg_lst t_CP {gdl.gameStatements.push_back(GDLTerm($3.front().name, $3.front().arity, $3.front().args))};


arg_lst: arg {$$=$1} |
         arg_lst arg {
             $1.insert($1.end(), $2.begin(), $2.end()); 
             $$=$1};
arg:     t_VAR {$$.push_back(GDLTerm(scanner.YYText()))}| 
         term  {$$=$1};
term:    t_OP t_TRUE     arg_lst t_CP {$$.push_back(GDLTerm("true",     $3.size(), $3))}|
         t_OP t_NOT         term t_CP {$$.push_back(GDLTerm("not",      $3.size(), $3))}|
         t_OP t_OR       arg_lst t_CP {$$.push_back(GDLTerm("or",       $3.size(), $3))}|
         t_OP t_DOES     arg_lst t_CP {$$.push_back(GDLTerm("does",     $3.size(), $3))}|
         t_OP t_ROLE     arg_lst t_CP {$$.push_back(GDLTerm("role",     $3.size(), $3))}|
         t_OP t_LEGAL    arg_lst t_CP {$$.push_back(GDLTerm("legal",    $3.size(), $3))}|
         t_OP t_GOAL     arg_lst t_CP {$$.push_back(GDLTerm("goal",     $3.size(), $3))}|
         t_OP t_DISTINCT arg_lst t_CP {$$.push_back(GDLTerm("distinct", $3.size(), $3))}| 
         t_OP t_ATOM {atomName=scanner.YYText()} arg_lst t_CP {$$.push_back(GDLTerm(atomName, $4.size(), $4));}|
         t_TERMINAL {$$.push_back(GDLTerm(scanner.YYText()))}|  
         t_ATOM     {$$.push_back(GDLTerm(scanner.YYText()))};



rules:     t_OP rules_aux t_CP |
           t_OP rules_aux t_CP rules ;
rules_aux: statement | relation ;



statement: t_ATOM arg_lst |
           t_LEGAL arg_lst ;



relation: t_RELATION rel_head rel_body | t_RELATION rel_head ;
rel_head: t_OP t_NEXT arg_lst t_CP | term;
rel_body: term | term rel_body ;

%%


