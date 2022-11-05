module Lib where

import Text.Show.Functions

{-Nos contactaron para hacer un sistema que ayude a tomar decisiones sobre series de TV a producir en un nuevo servicio llamado PdePrime Video.  En el sistema vamos a trabajar con series, de las cuales queremos saber cual es el nombre de la misma, quienes actúan en ella (y el orden de importancia), su presupuesto anual, cantidad de temporadas estimadas, el rating promedio que tiene y si está cancelada o no. También, de cada actor o actriz conocemos el nombre, cuál es su sueldo pretendido (anual) y qué restricciones tiene a la hora de trabajar. Por ejemplo, sabemos que el sueldo pretendido de Paul Rudd es de 41 millones al año y que sus restricciones son no actuar en bata y comer ensalada de rúcula todos los días.
  Resolver los siguientes requerimientos, maximizando el uso de composición​, aplicación parcial​ y orden superior​.  
Punto 1 
    a)Saber si la serie está en rojo, esto es si el presupuesto no alcanza a cubrir lo que quieren cobrar todos los actores. 
    b)Saber si una serie es problemática, esto ocurre si tienen más de 3 actores o actrices con más de 1 restricción 
  -}


data Serie = Serie {
    nombre :: String,
    actores :: [Actor],
    presupuestoAnual :: Int,
    temporadas :: Int,
    rating :: Int,
    cancelada :: Bool
} deriving Show

data Actor = Actor {
    nombreActor :: String,
    sueldoAnual :: Int,
    restricciones :: [String]
} deriving Show

paulRudd :: Actor
paulRudd = Actor "Paul Rudd" 41 ["noActuarEnBata", "comerEnsalada"]
lenon = Actor "Lenon" 40 ["caciiii"]
johnnyDeep = Actor "Johnny Deep" 20 []
helenaBonham = Actor "Helena Bonham" 15 []

breakingBad :: Serie
breakingBad = Serie "Breakin Bad" [lenon,johnnyDeep, lenon,paulRudd] 1000 2 100 False 

estaEnRojo :: Serie -> Bool
estaEnRojo serie = (presupuestoAnual serie <) . sum . (map sueldoAnual) . actores $ serie  

esProblematica :: Serie -> Bool
esProblematica serie = (3<) . actoresProblematicos . actores $ serie

actoresProblematicos :: [Actor] -> Int
actoresProblematicos actores = length . (filter (1<)) . (map length) . (map restricciones) $ actores

{-
Punto 2 
Queremos modelar diferentes tipos de productores, que evalúan qué se hace con las series:
    a) con favoritismos: elimina a los dos primeros actores de la serie y los reemplaza por sus actores favoritos. 
    b) tim burton: es un caso particular de un productor con favoritismos, siempre reemplaza a los primeros dos actores por johnny depp y helena bonham carter, cuyos sueldos pretendidos anuales son $20.000.000 y $15.000.000 respectivamente, y no tienen ninguna restricción.
    c) gatopardeitor: no cambia nada de la serie. 
    d) estireitor: duplica la cantidad de temporadas estimada de la serie. 
    e) desespereitor: hace un combo de alguna de las anteriores ideas, mínimo 2. 1 de 2 
    f) canceleitor: si la serie está en rojo o el rating baja de una cierta cifra, la serie se cancela. -}

type Productor = Serie->Serie

conFavoritismo :: [Actor] -> Productor 
conFavoritismo actoresFavoritos serie = (modificarActores serie) . (actoresFavoritos ++). (drop 2) . actores $ serie 

modificarActores :: Serie -> [Actor] -> Serie
modificarActores serie actores = serie {actores = actores}

timBurton :: Productor 
timBurton serie = conFavoritismo [johnnyDeep, helenaBonham] serie

gatopardeitor :: Productor 
gatopardeitor serie = id serie

estireitor :: Productor 
estireitor serie = serie {temporadas = 2 * temporadas serie}

desespereitor :: [Productor] -> Productor 
desespereitor combo serie = foldl (flip hacerProductor) serie combo

hacerProductor :: Productor -> Productor
hacerProductor produccion serie = produccion serie


canceleitor :: Int -> Productor
canceleitor cifraRating serie  
    | estaEnRojo serie     = cancelarSerie serie
    | cifraRating > rating serie = cancelarSerie serie
    | otherwise            = id serie

cancelarSerie :: Productor
cancelarSerie serie = serie {cancelada = True}

{-Punto 3
Calcular el bienestar de una serie, en base a la sumatoria de estos conceptos:  
    - Si la serie tiene estimadas más de 4 temporadas, su bienestar es 5, de lo contrario es (10 - cantidad de temporadas estimadas) * 2 
    - Si la serie tiene menos de 10 actores, su bienestar es 3, de lo contrario es (10 - cantidad de actores que tienen restricciones), con un mínimo de 2.  
    Aparte de lo mencionado arriba, si la serie está cancelada, su bienestar es 0 más allá de cómo diesen el bienestar por longitud y por reparto. 
-}

bienestar :: Serie -> Int
bienestar serie 
    | cancelada serie = 0 
    | otherwise       = bienestarPorTemporadas (temporadas serie) + bienestarPorActores (actores serie)

bienestarPorTemporadas :: Int -> Int
bienestarPorTemporadas temporadas 
    | temporadas > 4 = 5
    | otherwise      = (*2) . (+ 10)  $ (-temporadas)

bienestarPorActores :: [Actor] -> Int
bienestarPorActores actores 
    | length actores < 10 = 3
    | otherwise           = (max 2) . (+ 10) . (*(-1)) . length $ actores

{-
Punto 4
Dada una lista de series y una lista de productores, aplicar para cada serie el productor que la haga más efectiva: es decir, el que le deja más bienestar. 
-}

productorMasEfectivo :: [Serie] -> [Productor] -> [Serie]
productorMasEfectivo series productores = map (masEfectivo productores) series

masEfectivo :: [Productor] -> Serie -> Serie
masEfectivo [productor] serie = productor serie 
masEfectivo (productor1:productores) serie
  | bienestar (productor1 serie) > bienestar (head productores $ serie) = masEfectivo (productor1:tail productores) serie
  | otherwise = masEfectivo productores serie

{-
Punto 5
Responder, justificando en cada caso:  
    a) ¿Se puede aplicar el productor gatopardeitor cuando tenemos una lista infinita de actores? 
    b) ¿Y a uno con favoritismos? ¿De qué depende? -}

-- a)-- ¿Se puede aplicar el productor gatopardeitor cuando tenemos una lista infinita de actores?
-- si, se puede aplicar gatopardeitor con una lista infinita de actores. no se traba en consola.
-- como la funcion es la funcion id (identidad) devuelve infinitamente la serie que le paso, con la lista infinita de actores.
-- El problema es que como tiene que mostrar una lista infinita de actores, nunca llego a ver los demas
-- atributos de la serie (temporadas, rating, etc).
-- si bien funciona en consola, no cumple con el proposito de la funcion.

serieEjemplo :: Serie
serieEjemplo = Serie "serie ejemplo" actoresInfinitos 100 2 5 False

actoresInfinitos = johnnyDeep : actoresInfinitos

-- > Resultados : 
-- Serie {nombre = "serie ejemplo", actores = [Actor {nombreActor = "johnny depp", sueldo = 20000000, restricciones = []},Actor {nombreActor = "johnny depp", sueldo = 20000000, restricciones = []} ....

-- ¿Y a uno con favoritismos? ¿De qué depende?

-- b) al aplicar conFavoritismo no hay problema al hacer el drop de los primero 2 elementos.
-- cuando se quiere agregar los favoritos a la lista puede ocurrir el problema: si se agregan al principio de la lista
-- no hay problema alguno, pero sí lo hay si se agregan al final de la lista (ya que nunca encontrara el final
-- de una lista infinita). 
-- por lo que depende de si agregamos a los actores al principio o al final

{-
Punto 6 
Saber si una serie es controvertida, que es cuando no se cumple que cada actor de la lista cobra más que el siguiente. 
-}

esControvertida serie = controvertida . actores $ serie 

controvertida :: [Actor]->Bool
controvertida [actor] = False
controvertida (actor1:actores)
    | sueldoAnual actor1 < sueldoAnual (head actores) = controvertida (actor1:tail actores)
    | otherwise = True

-- Punto 7
-- funcionLoca :: (Int -> Int) -> (a -> [b]) -> [a] -> [Int]
-- funcionLoca x y = filter (even.x) . map (length.y)

-- primero sabemos que hay dos parametro : x e y
-- como la primer funcion que se va a aplicar es map, sabemos que hay un tercer parametro implicito: z
-- z es una lista, no sabemos de que
-- funcionLoca :: -> -> [a] -> 
-- como y recibe la lista de z, debe tener su mismo tipo, pero puede devolver algo de otro tipo. lo unico que 
-- sabemos de este algo es que debe ser una lista, pues luego se le aplica la funcion length
-- funcionLoca :: -> (a -> [b]) -> [a] -> 
-- luego, se aplica filter. sabemos que el map devuelve una lista de Int y que sobre esa lista se aplicara el filter.
-- por lo que x es una funcion que recibe Int y devuelve un Int (ya que luego se le aplica even)
-- finalmente la funcion funcionLoca devuelve una lista de Int:
-- funcionLoca :: (Int -> Int) -> (a -> [b]) -> [a] -> [Int]