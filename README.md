# Paradigmas de Lenguajes de Programación

## Trabajo Práctico 1a: Juego de la vida (Programacion Funcional)

Se pide programar en Haskell el juego de la vida de Conway. Este consiste en una
simulación de reproducción de bacterias en una superficie. La superficie donde se
desarrolla esta simulación deberá ser una matriz de n filas por n columnas, donde en
cada posición de esta matriz se representa la presencia o ausencia de una bacteria
(cada bacteria ocupa una sola posición de la matriz). La simulación se refleja en el
cambio del estado de la matriz de un instante dado al siguiente (lo que da una idea de
pasos de simulación). Las características del tablero se mantienen para toda la
simulación.
El pasaje de un estado del tablero al siguiente se realiza posición por posición en
función del contenido de la posición equivalente del estado del paso anterior. El
pseudoalgoritmo para calcular el contenido de una posición cualquiera en función del
contenido de la posición equivalente del estado anterior es el siguiente:

~~~~  
Procedimiento PróximoPaso(UAnt : Posición; PAnt : Lógico; var PSig : Lógico)
Comenzar
Si (PAnt) entonces
Si ((CantVecOcup(UAnt) &lt; 3) o (CantVecOcup(UAnt) &gt; 4)) entonces
PSig  Falso (muerte por aislamiento o asfixia repectivamente)
Sino
PSig  Verdadero (supervivencia)
FinSi
Sino
Si (CantVecOcup(UAnt) = 3) entonces
PSig  Verdadero (nacimiento por reproducción)
Sino
PSig  Falso (ausencia)
FinSi
FinSi
Fin 
~~~~

La función ```CantVecOcup``` representa la cantidad de celdas vecinas (las que rodean a
la posición en cuestión) que están ocupadas por bacterias.

**Entradas del programa:**
- Dimensión del tablero (valor de n).
- Representación del tablero (influye en el cálculo de vecinos en los bordes):
- plana (las posiciones de los bordes no tienen vecinos más allá de losbordes)
- toroidal (el borde derecho debe considerarse unido al izquierdo y el borde superior debe considerarse unido al inferior).
- Estado inicial del tablero.
- Cantidad de pasos de la simulación.

**Salidas del programa:**
- Estados del tablero desde el tablero inicial hasta el tablero correspondiente al número de paso establecido en la entrada.
Características del programa:
- Se apreciará el uso de tipos de datos y de funciones de orden superior.
- El reductor principal deberá ser main, y su tipo deberá ser IO ().
El trabajo deberá ser presentado en máquina ante los responsables de la cátedra
(con presencia de todos los integrantes del grupo) el día asignado previamente.
