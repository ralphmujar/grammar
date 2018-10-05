%{
    #include <stdio.h>
    #include <string.h>

    int yylex(void);
    void yyerror(char *);
    FILE *yyin;
    int sym[26];
%}


%token INTEGER VAR AND LESSTHANEQUAL


%%

program:
   program s '\n'	// { printf("%d\n", $2); }
        |
        ;

/*e:         t '-' f         { $$ = $1 - $3; }
        |  t '+' f         { $$ = $1 + $3; }
        ;

t:                      
        | '+' f f           { $$ = $2 + $3; }
        | '-' f f           { $$ = $2 - $3; }
        | '(' t ')'         { $$ = $2; }
	;*/

s: e       {printf("%d\n", $1);}
| v '=' e  {sym[$1] = $3;}
 ;


e : f
| v		{$$ = sym[$1];}
| e '-' e 	{$$ = $1 -  $3;}
| e '+' '+' 	{$$ = $1 + 1;}
| e '+' e 	{$$ = $1 + $3;}
| e '/' e 	{$$ = $1 /  $3;}
| e '*' e 	{$$ = $1 * $3;}
| '(' e ')'	{$$ = $2;}
| e  LESSTHANEQUAL e      {$$ = $1 <= $3;}
| e '>' e       {$$ = $1 > $3;}
| e '<' e       {$$ = $1 < $3;}
| e AND e       {$$ = $1 && $3;}
;



f: INTEGER { $$ = $1;};
v: VAR { $$ = $1;}

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

/*int mainshell(void) {
    yyparse();
    return 0;
    }*/

int main(int argc, char *argv[])
{
   
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
   
    return 0;
}
