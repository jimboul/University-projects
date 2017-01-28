%{
#include <stdio.h>
%}
EXPRESSION {VERB}{PRONOUN}{GEOMETRIC_BEING}{GEOMETRIC_BEING_NAME}"."
VERB "Given"
PRONOUN "a"|"an"
GEOMETRIC_BEING "angle"|"line segment"|"triangle"|"square"|"pentagon"
GEOMETRIC_BEING_NAME [A-E]+
%%
^{EXPRESSION}              {printf("Not valid expression! Remember to put always at the end of a sentence a full stop.\n"); return 0;}
{VERB}                     printf("%s: is a verb\n", yytext);
{PRONOUN}		   printf("%s: is a pronoun\n", yytext);
{GEOMETRIC_BEING}          printf("%s: is a geometric being\n", yytext);
{GEOMETRIC_BEING_NAME}/"." printf("%s: is a geometric being name\n", yytext);
[ \t\n]+                   /* eat up whitespaces */
"."                        /* eat up full-stops */
.                          {printf("%s: Unrecognized word. Remember to put always at the end of a sentence a full stop.\n", yytext); return 0;}
