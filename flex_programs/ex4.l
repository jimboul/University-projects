%{
#include <stdio.h>
%}
EXPRESSION {VAR_DEFINER}{SUBEXPRESSION}
SUBEXPRESSION [{VAR_NAME}[","{VAR_NAME}]*":"[ \t\n]*{VAR_TYPE}";"]+
VAR_DEFINER "var"
VAR_NAME [a-zA-Z][a-zA-Z0-9_]*
VAR_TYPE "real"|"boolean"|"integer"|"char"
%%                     
";"[ \t\n]*{VAR_DEFINER}    {
			        printf("The keyword 'var' is defined once at the beginning of a new line. You can not use it again\n");
		                return 0;
			    }
{VAR_DEFINER}                     printf("A keyword: %s\n", yytext);      
{VAR_TYPE}";"                     printf("The variable type is: %s\n", yytext);
{VAR_NAME}                        printf("A variable name: %s\n", yytext);
","/[ \t\n]*{VAR_NAME}            /* eat up commas */
":"/[ \t\n]*{VAR_TYPE}";"         /* eat up single colon */
[ \t\n]+                          /* eat up whitespace */
.                           {
				printf("Error!\n");
				return 0;
			    }
%%
main(argc, argv)
int argc;
char** argv;
{
++argv, --argc;
if (argc > 0) 
yyin = fopen(argv[0],"r");
else 
yyin = stdin;
yylex();
}


