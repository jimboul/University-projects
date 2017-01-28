%{
  #include "exercise4.tab.h"
%}

%option noinput nounput noyywrap nodefault
%option yylineno

%%
[ \t\n]+                { /* Ignore all whitespaces */ }
var                     { return VAR; }
real                    { return REAL; }
boolean                 { return BOOLEAN; }
integer                 { return INTEGER; }
char                    { return CHAR; }
[a-zA-Z][a-zA-Z0-9_]*   { return VAR_NAME; }
.                       { return yytext[0]; }
