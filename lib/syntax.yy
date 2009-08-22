%name GDLParser

%define MEMBERS \
    virtual ~GDLParser() {} \
    private: \
        yyFlexLexer scanner;

%define LEX_BODY {return scanner.yylex();}
%define ERROR_BODY {fprintf(stderr, "error at line: %d ; %s\n", scanner.lineno(),scanner.YYText());}
%define SVAL char *

%header{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include <stdio.h>
using namespace std;
%}

%token t_ROLE t_INIT t_TRUE t_DOES t_NEXT t_LEGAL t_GOAL
%token t_TERMINAL t_ATOM t_NOT t_RELATION t_OP t_CP t_VAR
%token t_DISTINCT t_OR

%start game_desc


%%
game_desc: role_set init_set rules;

role_set: role |
          role_set role;
role:     t_OP t_ROLE t_ATOM t_CP;


init_set: init |
          init_set init;
init:     t_OP t_INIT arg_lst t_CP;


arg_lst: arg |
         arg arg_lst ;
arg:     t_VAR  | term;
term:    t_OP t_TRUE     arg_lst t_CP |
         t_OP t_NOT         term t_CP |
         t_OP t_OR       arg_lst t_CP |
         t_OP t_DOES     arg_lst t_CP |
         t_OP t_ROLE     arg_lst t_CP |
         t_OP t_LEGAL    arg_lst t_CP |
         t_OP t_GOAL     arg_lst t_CP |
         t_OP t_DISTINCT arg_lst t_CP | 
         t_OP t_ATOM     arg_lst t_CP |
         t_TERMINAL | t_ATOM ;



rules:     t_OP rules_aux t_CP |
           t_OP rules_aux t_CP rules ;
rules_aux: statement | relation ;



statement: t_ATOM arg_lst |
           t_LEGAL arg_lst ;



relation: t_RELATION rel_head rel_body | t_RELATION rel_head ;
rel_head: t_OP t_NEXT  arg_lst t_CP | term;
rel_body: term | term rel_body ;

%%


