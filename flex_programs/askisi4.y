%{
  #include <stdio.h>

  extern int yylineno;
  int yylex();
  void yyerror(const char* msg);
%}
   
%define parse.lac full
%error-verbose

%token VAR VAR_NAME REAL BOOLEAN INTEGER CHAR

%%

program   : VAR typedecls
typedecls : typedecl
          | typedecls typedecl
typedecl  : varlist ':' var_type ';'
varlist   : VAR_NAME
          | varlist ',' VAR_NAME ;
var_type  : REAL | BOOLEAN | INTEGER | CHAR ;

%%

int main( int argc, char** argv ) {
  extern FILE *yyin;
  if ( argc > 1 )
    yyin = fopen( argv[1], "r" );
  else
    yyin = stdin;
  if (!yyin) {
    perror("Could not open file for reading");
    return 1;
  }
  return yyparse();
}

void yyerror(const char* msg) {
  fprintf(stderr, "At line %d: %s\n", yylineno, msg);
}
