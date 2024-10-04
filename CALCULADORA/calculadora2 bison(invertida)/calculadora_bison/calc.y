%{

/*
    Importar librerias
*/

#include <stdio.h> //standart input - output header -> declaraciones de funciones estándar
#include <stdlib.h> // Gestión de memoria, conversión de tipos de datos.
#include <math.h> // Funciones matemáticas,como pow (para pontencia) y abs (para valor absoluto)

//Manejar errores y la tokenización
void yyerror(const char *s); //Declaración de la función de manejo de errores.
int yylex(void); //Función que realiza el análisis léxico (tokenización)

int error_occurred = 0;  // Variable global para controlar si ocurrió un error

%}

%union {
    double val; //Almacenar valores de tipo double, se usa para tokens que usan números de tipo flotante
}

%token <val> NUMBER //Token para números, asociados al tipo 'val' en la unión.
%token ADD SUB MUL DIV EXP EOL ABS //Token para operadores y delimitadores.

%left MUL DIV 
%left ADD SUB 
%right EXP  
%right UMINUS //Operador valor absoluto.

%type <val> expr //variable para las expresiones 'val', definido en la unión.

%%

calculo:
    expr EOL { //Se realiza el cálculo en una sola línea, el salto de línea ejecuta la función
        if (!error_occurred) { //Verifica si ocurrió un error durante la evaluación.
            printf("%.2f\n", $1); //Se formatea el resultado a dos decimales
        }
        error_occurred = 0;  //  Se resetea la bandera de error hasta la siguiente entrada
    }
    | calculo expr EOL { //Esta regla va a permitir múltiples expresiones, cada una seguida del salto de línea
        if (!error_occurred) { //Sino se presentan excepciones
            printf("%.2f\n", $2); //Se imprime en la consola el resultado
        }
        error_occurred = 0;  // Reinicia el error hasta la siguiente bandera
    }
    ;

expr:
    NUMBER          { $$ = $1; } //Asigna el valor a una variable
    | expr ADD expr { $$ = $1 + $3; } //Regla de la suma
    | expr SUB expr { $$ = $1 - $3; } //Regla de la resta
    | expr MUL expr { $$ = $1 * $3; } //Regla de la multiplicación
    | expr DIV expr { //Regla de la división
        if ($3 == 0) { //Evaluar si el divisor es 0
            yyerror("Error: División por cero");//Mostrar el error
            error_occurred = 1;  // Crear la bandera del error
        } else {
            $$ = $1 / $3; //Realizar la división
        }
    }
    | expr EXP expr { $$ = pow($1, $3); } //Regla para la potenciación de las expresiones
    | SUB expr %prec UMINUS { $$ = -$2; } //Operador unario negativo, y cambio del mismo a absoluto
    | ABS expr ABS  { $$ = fabs($2); }  // Declarar el delimitador del valor absoluto.
    | '|' expr '|'  { $$ = fabs($2); }  // Declarar la expresión del valor absoluto con '|'
    | '(' expr ')'  { $$ = $2; } //Regla para agrupación de expresiones entre paréntesis
    ;

%%

//manejo de errores, se imprime el mensaje
void yyerror(const char *s) {
    //Usar el puntero global stderr para identificar donde sucedió
    fprintf(stderr, "%s\n", s); //imprimir el error recibido por calculo o por expr, en la consola
}

//Función main
int main(void) {
    //Solicitar el valor de la expresión matemática
    printf("Ingrese una expresión matemática:\n");
    return yyparse(); //Llamar al parser, para analizar la entrada por consola
}
