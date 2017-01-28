%{
#include <stdio.h>    
%}
%token VAR VAR_NAME REAL BOOLEAN INTEGER CHAR
%%
program : VAR typedecls ;
typedecls : typedecl | typedecls typedecl ;
typedecl : varlist ':' var_type ';' ;
varlist : VAR_NAME | varlist ',' VAR_NAME ;
var_type : REAL | BOOLEAN | INTEGER | CHAR ;
%%
main( argc, argv )
int argc;
char **argv;
{
extern FILE *yyin;
++argv, --argc; /* skip over program name */
if ( argc > 0 )
yyin = fopen( argv[0], "r" );
else
yyin = stdin;
//yylex();
yyparse();
}
yyerror(char *s)  
{  
 printf("\nError\n");  
}
#include "lex.yy.c"
