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

axiom:	 t_AXIOM | 
		 t_AXIOM arg_lst ;


rules:     t_OP rules_aux t_CP |
		   t_OP rules_aux t_CP rules ;
rules_aux: t_RELATION t_OP rule_head t_OP rule_body |
   		   t_RELATION terminal rule_body|		  
		   move_update |
		   statement ;


rule_head: next | legal | goal | new_rule ;
next:      t_NEXT arg_lst;
legal:     t_LEGAL player arg_lst;
goal:      t_GOAL player score;
new_rule:  t_AXIOM | t_AXIOM arg_lst ;
terminal:  t_TERMINAL;



rule_body: t_OP body_aux t_CP | 
		   t_OP body_aux t_CP rule_body | ;
body_aux:  true | does | not | distinct | axiom;
true:      t_TRUE arg_lst ;
does:      t_DOES player axiom;
not:       t_NOT axiom ;
distinct:  t_DISTINCT arg_lst;


move_update: does;
statement:   axiom;


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
