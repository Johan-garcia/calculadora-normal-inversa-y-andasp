%{
#include "calc.tab.h"
%}

%%
[0-9]+(\.[0-9]+)?    { yylval.val = atof(yytext); return NUMBER; }  // Soporte para decimales
[ \t]+               { /* Ignorar espacios */ }
\n                   { return EOL; }
[-+*/()]             { return yytext[0]; }
"|"                  { return '|'; }  // Para manejar el operador de valor absoluto
.                    { /* Ignorar caracteres no reconocidos */ }
%%

int yywrap() {
    return 1;
}

