%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE const char *
%}

%token t_ROLE t_INIT t_TRUE t_DOES t_NEXT t_LEGAL t_GOAL
%token t_TERMINAL t_AXIOM t_NUM t_RELATION t_OP t_CP t_VAR

%start game_desc


%%
game_desc: role_set init_set;

role_set: role |
		  role_set role ;
role:	  t_OP t_ROLE t_AXIOM t_CP;


init_set: init |
		  init init_set;
init:	  t_OP t_INIT axiom_lst t_CP;

axiom_lst: axiom |
		   axiom axiom_lst;
axiom:	   t_OP t_AXIOM arg_lst t_CP |
		   t_AXIOM ;

args_lst: args |
		  args arg_lst ;
args: 	  t_NUM | t_VAR | t_AXIOM;


%%

int main() {
	yyparse();
}


int yyerror(char *s){
	fprintf(stderr,"%s\n", s);
	return 0;
}

#include "lex.yy.c"
