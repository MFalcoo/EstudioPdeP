module Lib where

import Text.Show.Functions

{-Enunciado general
El fondo monetario internacional nos solicitó que modelemos su negocio, basado en realizar préstamos a países en apuros financieros. Sabemos de cada país el "ingreso per cápita" que es el promedio de lo que cada habitante necesita para subsistir, también conocemos la población activa en el sector público y la activa en el sector privado, la lista de recursos naturales (ej: "Minería", "Petróleo", "Industria pesada") y la deuda que mantiene con el FMI.

El FMI es especialista en dar recetas. Cada receta combina una o más estrategias que se describen a continuación: prestarle n millones de dólares al país, esto provoca que el país se endeude en un 150% de lo que el FMI le presta (por los intereses) reducir x cantidad de puestos de trabajo del sector público, lo que provoca que se reduzca la cantidad de activos en el sector público y además que el ingreso per cápita disminuya en 20% si los puestos de trabajo son más de 100 ó 15% en caso contrario darle a una empresa afín al FMI la explotación de alguno de los recursos naturales, esto disminuye 2 millones de dólares la deuda que el país mantiene con el FMI pero también deja momentáneamente sin recurso natural a dicho país. No considerar qué pasa si el país no tiene dicho recurso. establecer un “blindaje”, lo que provoca prestarle a dicho país la mitad de su Producto Bruto Interno (que se calcula como el ingreso per cápita multiplicado por su población activa, sumando puestos públicos y privados de trabajo) y reducir 500 puestos de trabajo del sector público. Evitar la repetición de código.

Se pide implementar en Haskell los siguientes requerimientos explicitando el tipo de cada función:

Punto 1 (2 puntos)
Representar el TAD País. Dar un ejemplo de cómo generar al país Namibia, cuyo ingreso per cápita es de 4140 u$s, la población activa del sector= público es de 400.000, la población activa del sector privado es de 650.000, su riqueza es la minería y el ecoturismo y le debe 50 (millones de u$s) al FMI.
-}

data Pais = Pais {
    ingresoPerCapita :: Int,
    sectorPublico :: Int,
    sectorPrivado :: Int,
    recursos :: [String],
    deuda :: Int 
} deriving (Eq, Show)

namibia = Pais 4140 400000 650000 ["mineria","ecoturismo","petroleo"] 30
argentina = Pais 4000 200 300 ["petroleo"] 200
{-
Punto 2 (4 puntos) Implementar las estrategias que forman parte de las recetas del FMI. 
-}

type Estrategia = Pais -> Pais

prestamo :: Int -> Estrategia
prestamo monto pais = modificarDeuda (+ (div (monto * 150) 100)) pais 

modificarDeuda :: (Int->Int)-> Estrategia
modificarDeuda funcion pais = pais {deuda = funcion (deuda pais)}

reducirPublico :: Int -> Estrategia
reducirPublico rajados pais = modificarSectorPublico (+ (-rajados)) . disminuirIngreso rajados $ pais

modificarSectorPublico :: (Int->Int) -> Estrategia
modificarSectorPublico funcion pais = pais {sectorPublico = funcion (sectorPublico pais)}

disminuirIngreso :: Int -> Estrategia
disminuirIngreso rajados pais 
    | sectorPublico pais > 100 = modificarIngresoPerCapita (+ (- div (20 * (ingresoPerCapita pais)) 100)) pais
    | otherwise                = modificarIngresoPerCapita (+ (- div (15 * (ingresoPerCapita pais)) 100)) pais


modificarIngresoPerCapita :: (Int->Int) -> Estrategia
modificarIngresoPerCapita funcion pais = pais {ingresoPerCapita = funcion (ingresoPerCapita pais)}

fmiExplota :: String -> Estrategia
fmiExplota recurso pais = pais {recursos = filter (/=recurso) (recursos pais), deuda = deuda pais - 2 } 

blindaje :: Estrategia
blindaje pais = modificarSectorPublico (+ (-500)) . modificarDeuda (+  div (div (pbi pais) 2) 1000000) $ pais

pbi :: Pais -> Int
pbi pais = ingresoPerCapita pais * poblacionActiva pais

poblacionActiva :: Pais -> Int
poblacionActiva pais = sectorPrivado pais + sectorPublico pais 



{-
Punto 3 (2 puntos)
Modelar una receta que consista en prestar 200 millones, y darle a una empresa X la explotación de la “Minería” de un país.
Ahora queremos aplicar la receta del punto 3.a al país Namibia (creado en el punto 1.b). Justificar cómo se logra el efecto colateral.
-}
type Receta = [Estrategia]

recetaUno = [prestamo 200, fmiExplota "mineria"]
recetaDos = [prestamo 100]

aplicarReceta :: Receta -> Pais -> Pais
aplicarReceta receta pais = foldl hacerEstrategia pais receta

hacerEstrategia :: Pais -> Estrategia -> Pais
hacerEstrategia pais estrategia = estrategia pais 

{-
Punto 4 (3 puntos) Resolver todo el punto con orden superior, composición y aplicación parcial, no puede utilizar funciones auxiliares.
Dada una lista de países conocer cuáles son los que pueden zafar, aquellos que tienen "Petróleo" entre sus riquezas naturales.
Dada una lista de países, saber el total de deuda que el FMI tiene a su favor.
Indicar en dónde apareció cada uno de los conceptos (solo una vez) y justificar qué ventaja tuvo para resolver el requerimiento.
-}
puedenZafar :: [Pais] -> [Pais]
puedenZafar = filter $ elem "Petroleo" . recursos

aFavorFmi :: [Pais] -> Int
aFavorFmi listaPaises = sum . map deuda $ listaPaises



{-
Punto 5 (2 puntos) Debe resolver este punto con recursividad: dado un país y una lista de recetas, saber si la lista de recetas está ordenada de “peor” a “mejor”, en base al siguiente criterio: si aplicamos una a una cada receta, el PBI del país va de menor a mayor. Recordamos que el Producto Bruto Interno surge de multiplicar el ingreso per cápita por la población activa (privada y pública). 
-}

recetaDePeorAMejor :: Pais -> [Receta] -> Bool
recetaDePeorAMejor pais [receta] = True
recetaDePeorAMejor pais (receta1:receta2:recetas) = revisarPBI receta1 pais <= revisarPBI receta2 pais && recetaDePeorAMejor pais (receta2:recetas)

revisarPBI receta pais = pbi . aplicarReceta receta $ pais 


{-
Punto 6 (1 punto) Si un país tiene infinitos recursos naturales, modelado con esta función
recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos
¿qué sucede evaluamos la función 4a con ese país? 
¿y con la 4b?
Justifique ambos puntos relacionándolos con algún concepto.
-}
-- a) Al evaluarlo en 4a no obtendremos una respuesta debido a que se quedara evaluando infinitamente si contiene el petroleo.
--b) al evaluarlo en 4b si se puede evaluar debido a que no entra en la lista de recursos, sino que da un resultado Int.(solo se evalua lo necesario).