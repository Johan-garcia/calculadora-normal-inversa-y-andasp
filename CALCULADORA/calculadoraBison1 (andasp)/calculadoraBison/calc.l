%{
#include "calc.tab.h" 
#include <stdlib.h>   
#include <ctype.h>    
%}

%%

[0-9]+\.[0-9]+    { yylval.val = atof(yytext); return NUMBER; } // Números flotantes.
[0-9]+            { yylval.val = atof(yytext); return NUMBER; } // Números enteros.
"+"                { return ADD; } // Suma.
"-"                { return SUB; } // Resta.
"*"                { return MUL; } // Multiplicación.
"/"                { return DIV; } // División.
"^"                { return EXP; } // Exponenciación.
"\n"               { return EOL; } // Salto de línea.
"|"                { return ABS; } // Valor absoluto.
"("                { return '('; } // Paréntesis de apertura.
")"                { return ')'; } // Paréntesis de cierre.
[ \t]              { /* Ignorar espacios en blanco */ } // Ignorar espacios y tabulaciones.
.                  { /* Ignorar caracteres no permitidos */ } // Ignorar otros caracteres.

%%

int yywrap(void) {
    return 1; // Indica el final del archivo de entrada.
}
