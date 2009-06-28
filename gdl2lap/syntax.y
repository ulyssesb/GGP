%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE const char *
%}

%token t_ROLE t_INIT t_TRUE t_DOES t_NEXT t_LEGAL t_GOAL t_NOT
%token t_TERMINAL t_AXIOM t_NUM t_RELATION t_OP t_CP t_VAR
%token t_DISTINCT

%start game_desc


%%
game_desc: role_set init_set rules;

role_set: role |
		  role_set role;
role:	  t_OP t_ROLE t_AXIOM t_CP;


init_set: init |
		  init_set init;
init:	  t_OP t_INIT arg_lst t_CP;


arg_lst: args |
		 args arg_lst ;
args: 	 t_NUM | t_VAR | axiom | distinct;

axiom:	 t_OP t_AXIOM arg_lst t_CP |
		 t_AXIOM ;


rules:     t_OP rules_aux t_CP |
		   t_OP rules_aux t_CP rules ;
rules_aux: t_RELATION rule_head rule_body |
		   move_update |
		   terminal ;

rule_head: next | legal | goal | new_rule ;
rule_body: true rule_body | 
		   does rule_body |
		   not  rule_body |
		   distinct rule_body | ;

next:     t_OP t_NEXT arg_lst t_CP;
legal:    t_OP t_LEGAL player arg_lst t_CP ;
goal:     t_OP t_GOAL player score t_CP;
terminal: t_TERMINAL;

true: 	  t_OP t_TRUE arg_lst t_CP ;
does: 	  t_OP t_DOES player axiom t_CP;
not:  	  t_OP t_NOT axiom t_CP;
distinct: t_OP t_DISTINCT arg_lst t_CP ;
new_rule: t_AXIOM |
		  t_OP t_AXIOM t_CP |
		  t_OP t_AXIOM arg_lst t_CP ;

move_update: does;

player: t_AXIOM | t_VAR ;
score:  t_NUM ;
%%

int main() {
	yyparse();
}


int yyerror(char *s){
	fprintf(stderr,"%s\n", s);
	return 0;
}

#include "lex.yy.c"
