module Lib where

import Text.Show.Functions

{-Todo héroe tiene un nombre, pero por lo general nos referimos a ellos por su epíteto. Sin embargo, hay muchos héroes que no conocemos. Esto se debe a que todo héroe tiene un reconocimiento y aquellos con uno bajo no han logrado pasar a la historia, aunque agradecemos eternamente su coraje ante la adversidad. Para ayudarse en sus pesares del día a día, los héroes llevan consigo diversos artefactos, que tienen una rareza, indicativos de lo valiosos que son.
Punto 1 
Modelar a los héroes. Tip: lean todo el enunciado!
-}
data Heroe = Heroe {
    epiteto        :: String,
    reconocimiento :: Int,
    artefactos     :: [Artefacto],
    tareas         :: [Tarea]
} deriving (Show)

cambiarEpiteto        funcion heroe = heroe { epiteto = funcion (epiteto heroe) }
cambiarReconocimiento funcion heroe = heroe { reconocimiento = funcion (reconocimiento heroe) }
cambiarArtefactos     funcion heroe = heroe { artefactos = funcion (artefactos heroe) }

data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
} deriving (Show)

{-Punto 2
Hacer que un héroe pase a la historia. Esto varía según el índice de reconocimiento que tenga el héroe a la hora de su muerte:
Si su reconocimiento es mayor a 1000, su epíteto pasa a ser "El mítico", y no obtiene ningún artefacto. ¿Qué artefacto podría desear tal espécimen?
Si tiene un reconocimiento de al menos 500, su epíteto pasa a ser "El magnífico" y añade a sus artefactos la lanza del Olimpo (100 de rareza). 
Si tiene menos de 500, pero más de 100, su epíteto pasa a ser "Hoplita" y añade a sus artefactos una Xiphos (50 de rareza).
En cualquier otro caso, no pasa a la historia, es decir, no gana ningún epíteto o artefacto.
-}
nuevoEpiteto :: String -> Tarea
nuevoEpiteto unEpiteto unHeroe = cambiarEpiteto (const unEpiteto) unHeroe 

agregarArtefacto :: Artefacto -> Tarea
agregarArtefacto unArtefacto unHeroe = cambiarArtefactos (unArtefacto :) unHeroe

nuevoEpitetoYArtefacto :: String -> Artefacto -> Tarea
nuevoEpitetoYArtefacto unEpiteto unArtefacto heroe = nuevoEpiteto unEpiteto . agregarArtefacto unArtefacto $ heroe

pasarALaHistoria :: Tarea
pasarALaHistoria heroe
    | reconocimiento heroe > 1000 = nuevoEpiteto "El mítico" heroe
    | reconocimiento heroe >= 500 = nuevoEpitetoYArtefacto "El magnífico" lanzaDelOlimpo heroe
    | reconocimiento heroe >  100 = nuevoEpitetoYArtefacto "Hoplita" xiphos heroe
    | otherwise                   = heroe

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo =  Artefacto "Lanza del Olimpo" 100

xiphos :: Artefacto
xiphos =  Artefacto "Xiphos" 50

{-Punto 3 
Modelar las tareas descritas, contemplando que en el futuro podría haber más:
Día a día, los héroes realizan tareas. Llamamos tareas a algo que modifica a un héroe de alguna manera, algo tan variado como aumentar su reconocimiento, obtener un nuevo epíteto o artefacto, y muchas más. Tras realizar una tarea, los héroes se la anotan en una lista, para luego recordarlas y presumirlas ante sus compañeros. Hay infinidad de tareas que un héroe puede realizar, por el momento conocemos las siguientes:
Encontrar un artefacto: el héroe gana tanto reconocimiento como rareza del artefacto, además de guardarlo entre los que lleva.
Escalar el Olimpo: esta ardua tarea recompensa a quien la realice otorgándole 500 unidades de reconocimiento y triplica la rareza de todos sus artefactos, pero desecha todos aquellos que luego de triplicar su rareza no tengan un mínimo de 1000 unidades. Además, obtiene "El relámpago de Zeus" (un artefacto de 500 unidades de rareza).
Ayudar a cruzar la calle: incluso en la antigua Grecia los adultos mayores necesitan ayuda para ello. Los héroes que realicen esta tarea obtiene el epíteto "Groso", donde la última 'o' se repite tantas veces como cuadras haya ayudado a cruzar. Por ejemplo, ayudar a cruzar una cuadra es simplemente "Groso", pero ayudar a cruzar 5 cuadras es "Grosooooo".
Matar una bestia: Cada bestia tiene una debilidad (por ejemplo: que el héroe tenga cierto artefacto, o que su reconocimiento sea al menos de tanto). Si el héroe puede aprovechar esta debilidad, entonces obtiene el epíteto de "El asesino de <la bestia>". Caso contrario, huye despavorido, perdiendo su primer artefacto. Además, tal cobardía es recompensada con el epíteto  "El cobarde".
-}
type Tarea = Heroe -> Heroe

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto artefacto heroe = agregarArtefacto artefacto . cambiarReconocimiento (+ rareza artefacto) $ heroe

escalarElOlimpo :: Tarea
escalarElOlimpo = agregarArtefacto relampagoDeZeus . desecharArtefactosComunes . triplicarRarezaArtefactos . cambiarReconocimiento (+500)

triplicarRarezaArtefactos :: Tarea
triplicarRarezaArtefactos heroe = cambiarArtefactos (map triplicarRareza) heroe

triplicarRareza :: Artefacto -> Artefacto
triplicarRareza artefacto = artefacto { rareza = 3 * rareza artefacto }

desecharArtefactosComunes :: Tarea
desecharArtefactosComunes heroe = cambiarArtefactos (filter (not . esComun)) heroe

esComun :: Artefacto -> Bool
esComun artefacto = rareza artefacto < 1000

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "Relámpago de Zeuz" 500

ayudarACruzarCalle :: Int -> Tarea
ayudarACruzarCalle unasCuadras heroe = nuevoEpiteto ("Gros" ++ replicate unasCuadras 'o') heroe

data Bestia = Bestia {
    nombreBestia :: String,
    debilidad    :: Debilidad
} 

type Debilidad = Heroe -> Bool

matarBestia :: Bestia -> Tarea
matarBestia bestia heroe
    | (debilidad bestia) heroe = nuevoEpiteto ("Asesino de " ++ nombreBestia bestia) heroe
    | otherwise                = (cambiarArtefactos (drop 1) . nuevoEpiteto "El cobarde") heroe

{-Punto 4
Modelar a Heracles, cuyo epíteto es "Guardián del Olimpo" y tiene un reconocimiento de 700. Lleva una pistola de 1000 unidades de rareza (es un fierro en la antigua Grecia, obviamente que es raro) y el relámpago de Zeus. Este Heracles es el Heracles antes de realizar sus doce tareas, hasta ahora sabemos que solo hizo una tarea...
-}
heracles :: Heroe
heracles = Heroe "Guardián del Olimpo" 700 [Artefacto "pistola" 1000, relampagoDeZeus] [matarAlLeonDeNemea]

{-Punto 5
Modelar la tarea "matar al león de Nemea", que es una bestia cuya debilidad es que el epíteto del héroe sea de 20 caracteres o más. Esta es la tarea que realizó Heracles.
-}
matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea heroe = matarBestia leonDeNemea heroe

leonDeNemea :: Bestia
leonDeNemea = Bestia "León de Nemea" (\heroe -> 20 <= length (epiteto heroe))

{-Punto 6
Hacer que un héroe haga una tarea. Esto nos devuelve un nuevo héroe con todos los cambios que conlleva realizar una tarea.
-}
realizarTarea :: Heroe -> Tarea -> Heroe
realizarTarea heroe tarea = agregarTarea tarea (tarea heroe)

agregarTarea :: Tarea -> Heroe -> Heroe
agregarTarea tarea heroe = heroe { tareas = tarea : tareas heroe }

{-Punto 7
Hacer que dos héroes presuman sus logros ante el otro. Como resultado, queremos conocer la tupla que tenga en primer lugar al ganador de la contienda, y en segundo al perdedor. Cuando dos héroes presumen, comparan de la siguiente manera:
Si un héroe tiene más reconocimiento que el otro, entonces es el ganador.
Si tienen el mismo reconocimiento, pero la sumatoria de las rarezas de los artefactos de un héroe es mayor al otro, entonces es el ganador.
Caso contrario, ambos realizan todas las tareas del otro, y vuelven a hacer la comparación desde el principio. Llegado a este punto, el intercambio se hace tantas veces sea necesario hasta que haya un ganador
-}
presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir heroe1 heroe2
    | reconocimiento heroe1 > reconocimiento heroe2 = (heroe1, heroe2)
    | reconocimiento heroe2 > reconocimiento heroe1 = (heroe2, heroe1)
    | sumaRarezaArtefactos heroe1 > sumaRarezaArtefactos heroe2  = (heroe1, heroe2)
    | sumaRarezaArtefactos heroe2 > sumaRarezaArtefactos heroe1  = (heroe2, heroe1)
    | otherwise                                                  = presumir (realizarTareasDe heroe2 heroe1) (realizarTareasDe heroe1 heroe2)

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe otroHeroe heroe = realizarTareas (tareas otroHeroe) heroe

sumaRarezaArtefactos :: Heroe -> Int
sumaRarezaArtefactos = sum . map rareza . artefactos

presumir' :: Heroe -> Heroe -> (Heroe, Heroe)
presumir' heroe1 heroe2
    | gana heroe1 heroe2 = (heroe1, heroe2)
    | gana heroe2 heroe1 = (heroe2, heroe1)
    | otherwise          = presumir (realizarTareasDe heroe2 heroe1) (realizarTareasDe heroe1 heroe2)

gana :: Heroe -> Heroe -> Bool
gana ganador perdedor = 
    reconocimiento ganador > reconocimiento perdedor ||
    (reconocimiento ganador == reconocimiento perdedor && sumaRarezaArtefactos ganador > sumaRarezaArtefactos perdedor)

{-Punto 8
¿Cuál es el resultado de hacer que presuman dos héroes con reconocimiento 100, ningún artefacto y ninguna tarea realizada?
-}

-- Queda infinitamente presumiendo

{-Punto 9
Obviamente, los Dioses no se quedan cruzados de brazos. Al contrario, son ellos quienes imparten terribles misiones ante nuestros héroes. Claro es el ejemplo de Heracles con sus doce tareas, o bien conocidas bajo el nombre de labores. Llamamos labor a un conjunto de tareas que un héroe realiza secuencialmente.
Hacer que un héroe realice una labor, obteniendo como resultado el héroe tras haber realizado todas las tareas.
-}

realizarTareas :: [Tarea] -> Heroe -> Heroe
realizarTareas tareas heroe = foldl realizarTarea heroe tareas

{-Punto 10
Si invocamos la función anterior con una labor infinita, ¿se podrá conocer el estado final del héroe? ¿Por qué?
-}

-- No, no se puede!!