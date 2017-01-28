%{
#include <stdio.h>
%}
%%
[ \t\n]+                { /* Ignore all whitespaces */ }
";"			{ /* Ignore all semicolons */ }
":"			{ /* Ignore all colons */ }
var                     { printf("A keyword: %s\n",yytext); return VAR; }
real                    { printf("A variable type: %s\n",yytext); return REAL; }
boolean                 { printf("A variable type: %s\n",yytext); return BOOLEAN; }
integer                 { printf("A variable type: %s\n",yytext); return INTEGER; }
char                    { printf("A variable type: %s\n",yytext); return CHAR; }
[a-zA-Z][a-zA-Z0-9_]*   { printf("A variable name: %s\n",yytext); return VAR_NAME; }
.                       { printf("Unrecognized character!\n"); return yytext[0]; }
%%
