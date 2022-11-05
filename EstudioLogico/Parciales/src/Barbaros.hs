module Lib where

import Text.Show.Functions
import Data.Char

{-
Punto 1
Se sabe que los bárbaros tienen nombre, fuerza, habilidades y
objetos, que los ayudarán más adelante en su lucha contra el mal.
Por ejemplo:
-}
data Barbaro = Barbaro {
  nombre :: String,
  fuerza :: Int,
  habilidades :: [String],
  objetos :: [Objeto]
} deriving (Show)

marco = Barbaro "Marco" 56 ["Ayudaracaca","Benezolano","Aaa"] []

cambiarHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
cambiarHabilidades funcion barbaro =
  barbaro { habilidades = funcion . habilidades $ barbaro }

cambiarNombre :: (String -> String) -> Barbaro -> Barbaro
cambiarNombre funcion barbaro =
  barbaro { nombre = funcion . nombre $ barbaro }

cambiarFuerza :: (Int -> Int) -> Barbaro -> Barbaro
cambiarFuerza funcion barbaro =
  barbaro { fuerza = funcion . fuerza $ barbaro }

cambiarObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
cambiarObjetos funcion barbaro =
  barbaro { objetos = funcion . objetos $ barbaro }

type Objeto = Barbaro -> Barbaro

espada :: Int -> Objeto
espada peso = cambiarFuerza (+ (peso * 2))

amuletosMisticos :: String -> Objeto
amuletosMisticos habilidad = agregarHabilidad habilidad

varitasDefectuosas :: Objeto
varitasDefectuosas = vaciarObjetos . agregarHabilidad "hacerMagia"

agregarHabilidad :: String -> Barbaro -> Barbaro
agregarHabilidad habilidad = cambiarHabilidades (habilidad:)

vaciarObjetos :: Barbaro -> Barbaro
vaciarObjetos = cambiarObjetos (const [])

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda = (.)
{-
Punto 2
El megafono es un objeto que potencia al bárbaro, concatenando sus habilidades y poniéndolas en mayúsculas.
*Main> megafono dave
Barbaro "Dave" 100 ["TEJERESCRIBIRPOESIA"] [<function>,<function>]
* Sabiendo esto, definir al megafono,
* megafonoBarbarico, que está formado por una cuerda, una ardilla y un megáfono.
-}
megafono :: Objeto
megafono = cambiarHabilidades ((:[]). map toUpper . concat)

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono

{-
Punto 3 - Aventuras
Los bárbaros suelen ir de aventuras por el reino luchando
contra las fuerzas del mal, pero ahora que tienen nuestra
ayuda, quieren que se les diga si un grupo de bárbaros puede
sobrevivir a cierta aventura.  Una aventura se compone de
uno o más eventos, por ejemplo:
* invasionDeSuciosDuendes: Un bárbaro sobrevive si sabe
  "Escribir Poesía Atroz"
* cremalleraDelTiempo: Un bárbaro sobrevive si no tiene
  pulgares. Los bárbaros llamados Faffy y Astro no tienen
  pulgares, los demás sí.
* ritualDeFechorias: Un bárbaro puede sobrevivir si pasa
  alguna de las pruebas como las siguientes:
  * saqueo: El bárbaro debe tener la habilidad de robar y
    tener más de 80 de fuerza.
  * gritoDeGuerra: El bárbaro debe tener un poder de grito
    de guerra igual a la cantidad de letras de sus habilidades.
    El poder necesario para aprobar es 4 veces la cantidad de
    objetos del bárbaro.
  * caligrafia: El bárbaro tiene caligrafía perfecta (para el
    estándar barbárico de la época) si sus habilidades
    contienen más de 3 vocales y comienzan con mayúscula.
Sabiendo esto, se pide:
* Definir los eventos, modelar las aventuras y dar un ejemplo.
* Definir la función sobrevivientes que tome una lista de
  bárbaros y una aventura, y diga cuáles bárbaros la sobreviven
  (es decir, pasan todas las pruebas)
-}
type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes barbaro =
  (elem "Escribir Poesía Atroz" . habilidades) barbaro

cremalleraDelTiempo :: Evento
cremalleraDelTiempo (Barbaro "Faffy" _ _ _) = True
cremalleraDelTiempo (Barbaro "Astro" _ _ _) = True
cremalleraDelTiempo _                       = False

cremalleraDelTiempo' :: Evento
cremalleraDelTiempo' (Barbaro nombre _ _ _) =
  nombre == "Faffy" || nombre == "Astro"

cremalleraDelTiempo'' :: Evento
cremalleraDelTiempo'' = not . tienePulgares

tienePulgares (Barbaro "Faffy" _ _ _) = False
tienePulgares (Barbaro "Astro" _ _ _) = False
tienePulgares _                       = True

ritualDeFechorias :: [Prueba] -> Evento
ritualDeFechorias pruebas barbaro = any (supero barbaro) pruebas

supero barbaro prueba = prueba barbaro

type Prueba = Barbaro -> Bool

caligrafia :: Prueba
caligrafia barbaro =  contieneTresVocales (habilidades barbaro) && empiezaMayus (habilidades barbaro) 

contieneTresVocales :: [String] -> Bool
contieneTresVocales habilidades = all tieneTresVocales habilidades

tieneTresVocales :: String->Bool
tieneTresVocales habilidad = (3<) . length . filter vocal $ habilidad  

vocal :: Char -> Bool
vocal 'a' = True
vocal 'e' = True
vocal 'i' = True
vocal 'o' = True
vocal 'u' = True
vocal _ = False

empiezaMayus :: [String]->Bool
empiezaMayus habilidades = all letraMayus habilidades

letraMayus :: String -> Bool
letraMayus habilidad = mayuscula (head habilidad) 

mayuscula 'A' = True
mayuscula 'B' = True
mayuscula 'C' = True
mayuscula 'D' = True
--Etcetera
mayuscula _ = False
{-
Punto 4 - Dinastía
A - Los bárbaros se marean cuando tienen varias habilidades
    iguales. Por todo esto, nos piden desarrollar una
    función que elimine los elementos repetidos de una
    lista (sin utilizar nub ni nubBy)

> sinRepetidos [1,2,3,4,4,5,5,6,7]
[1,2,3,4,5,6,7]

Nota: Puede usarse recursividad para este punto.
-}
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs)
  | elem x xs = sinRepetidos xs
  | otherwise = x : sinRepetidos xs

sinRepetidos' :: Eq a => [a] -> [a]
sinRepetidos' [] = []
sinRepetidos' (x:xs) = x : sinRepetidos' (filter (/= x) xs)

sinRepetidos'' :: Eq a => [a] -> [a]
sinRepetidos'' lista = foldl (\xs x -> x : filter (/= x) xs) [] lista
{-
B - Los bárbaros son una raza muy orgullosa, tanto que
quieren saber cómo van a ser sus descendientes y asegurarse
de que los mismos reciban su legado.
El descendiente de un bárbaro comparte su nombre, y un asterisco
por cada generación. Por ejemplo "Dave*", "Dave**", "Dave***", etc.
Además, tienen en principio su mismo poder, habilidades sin
repetidos, y los objetos de su padre, pero antes de pasar a
la siguiente generación, utilizan (aplican sobre sí mismos)
los objetos. Por ejemplo, el hijo de Dave será equivalente a:
(ardilla.varitasDefectuosas) (Barbaro "Dave*" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas])

Definir la función descendientes, que dado un bárbaro nos de
sus infinitos descendientes.
-}
descendientes :: Barbaro -> [Barbaro]
descendientes barbaro = iterate descendiente barbaro

descendiente :: Barbaro -> Barbaro
descendiente barbaro = agregarObjetosDelBarbaro . agregarAsteriscoAlNombre . habilidadesSinRepetidos . aplicarObjetos $ barbaro
  where
    aplicarObjetos barbaro   = foldl (flip ($)) barbaro (objetos barbaro)
    habilidadesSinRepetidos  = cambiarHabilidades sinRepetidos
    agregarAsteriscoAlNombre = cambiarNombre (++ "*")
    agregarObjetosDelBarbaro = cambiarObjetos (objetos barbaro ++)
{-
C. Pregunta: ¿Se podría aplicar sinRepetidos sobre la
lista de objetos? ¿Y sobre el nombre de un bárbaro?
¿Por qué?
Sobre la lista de objetos no se puede aplicar ya que los objetos, 
al ser funciones, no cumplen con la clase de tipo Eq, 
es decir que no se pueden comparar con (==).
Sobre el nombre sí, porque es una lista de caracteres
y estos son Equiparables.
-}