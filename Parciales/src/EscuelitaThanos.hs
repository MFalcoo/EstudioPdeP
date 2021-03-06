module Lib where

import Text.Show.Functions

{-
Los enanos de Nidavellir nos han pedido modelar los guanteletes que ellos producen en su herrería. Un guantelete está hecho de un material (“hierro”, “uru”, etc.) y sabemos las gemas que posee. También se sabe de los personajes que tienen una edad, una energía, una serie de habilidades (como por ejemplo “usar espada”, “controlar la mente”, etc), su nombre y en qué planeta viven. Los fabricantes determinaron que cuando un guantelete está completo -es decir, tiene las 6 gemas posibles- y su material es “uru”, se tiene la posibilidad de chasquear un universo que contiene a todos sus habitantes y reducir a la mitad la cantidad de dichos personajes. Por ejemplo si tenemos un universo en el cual existen ironMan, drStrange, groot y wolverine, solo quedan los dos primeros que son ironMan y drStrange. Si además de los 4 personajes estuviera viudaNegra, quedarían también ironMan y drStrange porque se considera la división entera.

Punto 1: (2 puntos) Modelar Personaje, Guantelete y Universo como tipos de dato e implementar el chasquido de un universo.
-}

data Guantelete = Guantelete {
    material :: String,
    gemas :: [Gema]
} deriving Show

data Personaje = Personaje {
    nombre :: String,
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    planeta :: String 
} deriving Show

ironMan = Personaje "Iron Man" 40 100 ["Ingeniero"] "Earth"
doctroStrange = Personaje "Dr.Strange" 50 75 ["Magia", "Capo"] "Earth"

type Universo = [Personaje]

chasquidoUniverso :: Guantelete -> Universo -> Universo
chasquidoUniverso guantelete universo 
    | gemasCompletas guantelete && materialEsUru guantelete = reducirUniverso universo
    | otherwise                                             = universo

gemasCompletas :: Guantelete -> Bool
gemasCompletas guantelete = (==6) . length . gemas $ guantelete

materialEsUru :: Guantelete-> Bool
materialEsUru guantelete = (=="Uru") . material $ guantelete

reducirUniverso :: Universo -> Universo
reducirUniverso universo = drop (mitadDeUniverso universo) universo

mitadDeUniverso :: Universo-> Int
mitadDeUniverso universo = div (length universo) 2

{-
Punto 2: (3 puntos) Resolver utilizando únicamente orden superior.
Saber si un universo es apto para péndex, que ocurre si alguno de los personajes que lo integran tienen menos de 45 años.
Saber la energía total de un universo que es la sumatoria de todas las energías de sus integrantes que tienen más de una habilidad.
-}

aptoParaPendex :: Universo -> Bool
aptoParaPendex universo = (any (45>)) . (map edad) $ universo

energiaTotalUniverso :: Universo -> Int
energiaTotalUniverso universo = sum . (map energia) . (filter unaHabilidad) $ universo

unaHabilidad :: Personaje -> Bool
unaHabilidad personaje = (>1) . length . habilidades $ personaje

{-
A su vez, aunque el guantelete no se encuentre completo con las 6 gemas, el poseedor puede utilizar el poder del mismo contra un enemigo, es decir que puede aplicar el poder de cada gema sobre el enemigo. Las gemas del infinito fueron originalmente parte de la entidad primordial llamada Némesis, un ser todopoderoso del universo anterior quién prefirió terminar su existencia en lugar de vivir como la única conciencia en el universo. Al morir, dio paso al universo actual, y el núcleo de su ser reencarnó en las seis gemas: 
    -La mente que tiene la habilidad de debilitar la energía de un usuario en un valor dado.
    -El alma puede controlar el alma de nuestro oponente permitiéndole eliminar una habilidad en particular si es que la posee. Además le quita 10 puntos de energía. 
    -El espacio que permite transportar al rival al planeta x (el que usted decida) y resta 20 puntos de energía.
    -El poder deja sin energía al rival y si tiene 2 habilidades o menos se las quita (en caso contrario no le saca ninguna habilidad).
    -El tiempo que reduce a la mitad la edad de su oponente pero como no está permitido pelear con menores, no puede dejar la edad del oponente con menos de 18 años. Considerar la mitad entera, por ej: si el oponente tiene 50 años, le quedarán 25. Si tiene 45, le quedarán 22 (por división entera). Si tiene 30 años, le deben quedar 18 en lugar de 15. También resta 50 puntos de energía.
    -La gema loca que permite manipular el poder de una gema y la ejecuta 2 veces contra un rival.

Punto 3: (3 puntos) Implementar las gemas del infinito, evitando lógica duplicada. 
-}

type Gema = Personaje -> Personaje

modificarEnergia :: (Int->Int) -> Personaje -> Personaje
modificarEnergia funcion personaje = personaje {energia = funcion (energia personaje) }

mente :: Int -> Gema
mente valor personaje = modificarEnergia (+ (-valor)) personaje

alma :: String -> Gema
alma habilidad personaje = modificarEnergia (+ (-10)) . borrarHabilidad habilidad $ personaje

borrarHabilidad :: String-> Gema
borrarHabilidad habilidad personaje = personaje {habilidades = filter (/=habilidad) (habilidades personaje)}

espacio :: String -> Gema
espacio planeta personaje = modificarEnergia (+ (-20)) . transportar planeta $ personaje

transportar :: String -> Gema
transportar planeta personaje = personaje {planeta = planeta}

poder :: Gema
poder personaje = modificarEnergia (* 0) . quitarHabilidades $ personaje

quitarHabilidades :: Gema
quitarHabilidades personaje 
    | cantidadHabilidades personaje <= 2 = personaje { habilidades = [] }
    | otherwise                = personaje    

cantidadHabilidades :: Personaje -> Int
cantidadHabilidades personaje = length . habilidades $ personaje

tiempo :: Gema
tiempo personaje 
    | reducirEdad personaje >= 18 = modificarEnergia (+ (-50)) personaje {edad = reducirEdad personaje}
    | otherwise         = modificarEnergia (+ (-50)) personaje {edad = 18} 

reducirEdad :: Personaje -> Int
reducirEdad personaje = (flip div 2) . edad $ personaje

gemaLoca :: Gema -> Gema
gemaLoca gema personaje = gema . gema $ personaje
 
{-
Punto 4: (1 punto) Dar un ejemplo de un guantelete de goma con las gemas tiempo, alma que quita la habilidad de “usar Mjolnir” y la gema loca que manipula el poder del alma tratando de eliminar la “programación en Haskell”.
-}

guanteDeEjemplo :: Guantelete
guanteDeEjemplo = Guantelete "Goma" [tiempo, alma "usar Mjolnir", gemaLoca (alma "Programacion en Haskell") ]

{-
Punto 5: (2 puntos). No se puede utilizar recursividad. Generar la función utilizar  que dado una lista de gemas y un enemigo ejecuta el poder de cada una de las gemas que lo componen contra el personaje dado. Indicar cómo se produce el “efecto de lado” sobre la víctima.
-}

utilizar :: [Gema] -> Personaje -> Personaje
utilizar listaGemas personaje = foldl utilizarGema personaje listaGemas

utilizarGema :: Personaje -> Gema -> Personaje 
utilizarGema personaje gema = gema personaje 

{-
Punto 6: (2 puntos). Resolver utilizando recursividad. Definir la función gemaMasPoderosa que dado un guantelete y una persona obtiene la gema del infinito que produce la pérdida más grande de energía sobre la víctima. 
-}
gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa guantelete personaje = mayorPerdidaDeEnergia personaje (gemas guantelete)

mayorPerdidaDeEnergia :: Personaje -> [Gema] -> Gema
mayorPerdidaDeEnergia personaje [gema] = gema
mayorPerdidaDeEnergia personaje (gema1:restoGemas)
    | energia (gema1 personaje) < energia ((head restoGemas) personaje) = mayorPerdidaDeEnergia personaje (gema1:tail restoGemas)
    | otherwise                                                         = mayorPerdidaDeEnergia personaje (restoGemas)

{-
Punto 7: (1 punto) Dada la función generadora de gemas y un guantelete de locos:
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas tiempo)

Y la función 
usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

Justifique si se puede ejecutar, relacionándolo con conceptos vistos en la cursada:
-gemaMasPoderosa punisher guanteleteDeLocos

esta funcion no se podra ejecutar debido a que al pasarle el guantelete de locos, jamas terminara de usarse la recursividad debido a que 
es una lista infinita de gemas la que estaremos analizando.

-usoLasTresPrimerasGemas guanteleteDeLocos punisher

en este caso si se ejecutara la funcion, esto se debe a que a pesar de estar trabajando sobre una lista infinita, solo necesitamos de los 3 primeros elementos de la lista y estos se pueden obtener sin recorrer la lista entera.
-}

