%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    double val;  // Declaración de tipo para yylval
}

%token <val> NUMBER
%type <val> expression  // Declaración del tipo para las expresiones

%left '+' '-'
%left '*' '/'
%token EOL

%%
calculation:
    /* vacío */
    | calculation expression EOL   { printf("Resultado: %lf\n", $2); }
    ;

expression:
    NUMBER                          { $$ = $1; }
    | '-' expression %prec '-'      { $$ = -$2; }  
    | expression '+' expression     { $$ = $1 + $3; }
    | expression '-' expression     { $$ = $1 - $3; }
    | expression '*' expression     { $$ = $1 * $3; }
    | expression '/' expression     { 
                                       if ($3 == 0) {
                                           yyerror("División por cero");
                                           exit(EXIT_FAILURE);
                                       } else {
                                           $$ = $1 / $3;
                                       }
                                     }
    | '|' expression '|'            { $$ = fabs($2); }
    | '(' expression ')'            { $$ = $2; }
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Calculadora mejorada\n");
    yyparse();
    return 0;
}

