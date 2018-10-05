%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[a-zA-Z]+   {
yylval = *yytext;
return VAR;
            }

[-+/*()\n=><]      return *yytext;

"<="       { return LESSTHANEQUAL; }

"&&"       { return AND; }

[ \t]       ; /* skip whitespace */

.           yyerror("invalid character");

%%

int yywrap(void) {
    return 1;
}


