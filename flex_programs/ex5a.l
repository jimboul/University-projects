%{
#include <stdio.h>
%}
EXPRESSION {VERB}{GEOMETRIC_BEING}{GEOMETRIC_BEING_NAME}"."
VERB "Dinetai"
GEOMETRIC_BEING {ANGLE}|{LINE_SEGMENT}|{TRIANGLE}|{SQUARE}|{PENTAGON}
ANGLE  "gwnia"|"gonia"
LINE_SEGMENT "euthigrammo tmima"|"euthigrammo tmhma"
TRIANGLE  "trigwno"|"trigono"
SQUARE  "tetragwno"|"tetragono"
PENTAGON  "pentagwno"|"pentagono"|"polygwno"|"polygono"
GEOMETRIC_BEING_NAME [A-E]{1,5}
%%
{VERB}                         	printf("%s: einai rima\n", yytext);                                	  
{GEOMETRIC_BEING}		printf("%s: einai geometriki ontotita\n", yytext);
{GEOMETRIC_BEING_NAME}/"."      printf("%s: einai onoma geometrikis ontotitas\n", yytext);          
[ \t\n]+                   /* eat up whitespaces */
"."                        /* eat up full-stops */
.                          {printf("%s: Unrecognized word. Remember to put always at the end of a sentence a full stop.\n", yytext); return 0;}

