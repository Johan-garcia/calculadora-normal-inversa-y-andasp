# calculadora-normal-inversa-y-andasp

creado por:  Daniel Reyes, Juan Marco Duarte, Willian Cordero, Johan Garcia

Este es un proyecto de una calculadora aritmética simple implementada utilizando Bison y Flex. La calculadora puede evaluar expresiones aritméticas básicas que incluyen suma, resta, multiplicación, división y manejo de paréntesis.

## Características

- Soporta las operaciones básicas: `+`, `-`, `*`, `/`
- Manejo de paréntesis para definir el orden de operaciones
- Soporte para números enteros positivos y negativos

## Requisitos

Para compilar y ejecutar este proyecto, necesitas tener instalados los siguientes paquetes en tu sistema linux:


### Instalación en terminal Ubuntu

```bash
sudo apt-get update
sudo apt-get install bison flex gcc
```

### Instrucciones de apertura del proyecto
```bash
-Descarga el archivo .zip y extraelo
-Entra a la carpeta en donde se extrajo el archivo y dar clic derecho y clickear en la opcion "abrir en terminal"
```
### Compila el proyecto utilizando Bison, Flex y GCC:
Esto generara un ejecutable llamado calc

```bash

    bison -d calc.y
    flex calc.l
    gcc calc.tab.c lex.yy.c -o calc -lm
```

### Ejecutar el archivo resultante de la compilacion

```bash
./calc

```
