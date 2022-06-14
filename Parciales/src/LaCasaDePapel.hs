module Lib where

import Text.Show.Functions

data Ladron = Ladron {
    nombre :: String,
    habilidades :: [String],
    armas :: [Arma]
}deriving Show

data Rehen = Rehen {
    nombreRehen :: String,
    complot :: Int,
    miedo :: Int,
    planContraLadrones :: Plan 
} deriving Show

type Arma = Rehen -> Rehen

pistola :: Int -> Arma
pistola calibre rehen = aumentaMiedo (letrasDelNombre rehen * 3) . modificarComplot (+ (-(calibre *5))) $ rehen

modificarComplot :: (Int->Int) -> Arma
modificarComplot funcion rehen = rehen { complot = funcion (complot rehen) }

aumentaMiedo :: Int -> Arma
aumentaMiedo valor rehen = rehen {miedo = miedo rehen + valor}

letrasDelNombre :: Rehen -> Int
letrasDelNombre rehen = length . nombreRehen $ rehen

ametralladora :: Int -> Arma
ametralladora balas rehen = aumentaMiedo (balas) . modificarComplot (flip div 2) $ rehen 

type PlanIntimidante = Ladron -> Arma

disparos :: PlanIntimidante
disparos ladron rehen = armaMasMiedo rehen (armas ladron) rehen

armaMasMiedo :: Rehen -> [Arma] -> Arma
armaMasMiedo rehen [arma] = arma
armaMasMiedo rehen (arma1:restoDeArmas) 
    | miedo (arma1 rehen) > miedo ((head restoDeArmas) rehen) = armaMasMiedo rehen (arma1:tail restoDeArmas)
    | otherwise                                               = armaMasMiedo rehen (restoDeArmas) 

hacerseElMalo :: PlanIntimidante
hacerseElMalo ladron rehen  
    | ladronBerlin ladron = aumentaMiedo (letrasDeHabilidades ladron) rehen
    | ladronRio ladron = modificarComplot (+ 20) rehen
    | otherwise = aumentaMiedo 10 rehen

ladronBerlin :: Ladron -> Bool
ladronBerlin ladron = (=="Berlin") . nombre $ ladron
ladronRio :: Ladron -> Bool
ladronRio ladron = (=="Rio") . nombre $ ladron
letrasDeHabilidades :: Ladron -> Int
letrasDeHabilidades ladron = length . concat . habilidades $ ladron

type Plan = Ladron -> Ladron

rebelarse :: Plan -> Rehen -> Ladron -> Ladron
rebelarse plan rehen ladron 
    | masComplotQueMiedo rehen = atacar plan ladron
    | otherwise          = ladron

masComplotQueMiedo :: Rehen ->Bool
masComplotQueMiedo rehen = complot rehen > miedo rehen

atacar :: Plan -> Plan
atacar plan ladron = plan ladron

atacarLadron :: String -> Plan
atacarLadron compa ladron = ladron {armas = drop (letrasNombreCompa compa) (armas ladron)}

letrasNombreCompa :: String -> Int
letrasNombreCompa compa = flip div 10 . length $ compa

esconderse :: Plan
esconderse ladron = perderArmas ladron

perderArmas :: Plan
perderArmas ladron = ladron {armas = armasRestantes ladron}

armasRestantes :: Ladron -> [Arma]
armasRestantes ladron = drop (habilidadesDivididoTres (habilidades ladron)) (armas ladron)

habilidadesDivididoTres :: [String] -> Int
habilidadesDivididoTres habilidades = flip div 3 . length $ habilidades

--Punto 1

tokio = Ladron "Tokio" ["trabajo psicologico", "entrar en moto"] [pistola 9, pistola 9, ametralladora 30]
profesor = Ladron "Profesor" ["disfrazarse de linyera", "disfrazarse de payaso", "estar siempre un paso adelante"] []
pablo = Rehen "Pablo" 40 30 esconderse
arturito = Rehen "Arturito" 70 50 (atacarLadron "pablo" . esconderse)

--Punto 2

ladronInteligente :: Ladron -> Bool
ladronInteligente ladron = (>2) . length . habilidades $ ladron

-- Punto 3
conseguirArma :: Arma -> Ladron -> Ladron
conseguirArma arma ladron = ladron { armas = arma : armas ladron}

-- Punto 4 
intimidar :: PlanIntimidante -> Ladron -> Rehen -> Rehen
intimidar planIntimidante ladron rehen = planIntimidante ladron rehen

-- Punto 5 
calmarAguas ladron listaRehenes = filter calmados . (dispararTecho ladron) $ listaRehenes

dispararTecho ladron listaRehenes = map (disparos ladron) listaRehenes

calmados rehen = complot rehen > 60 
--Punto 6
puedeEscapar :: Ladron -> Bool
puedeEscapar ladron = any (== "disfrazarse de") . map (take 14) . habilidades $ ladron

-- Punto 7 
pintaMal :: [Ladron] -> [Rehen] -> Bool
pintaMal listaLadrones listaRehenes = complotPromedio listaRehenes > miedoPromedio listaRehenes * armasDeLadrones listaLadrones

miedoPromedio :: [Rehen] -> Int
miedoPromedio listaRehenes = div (sum (map miedo listaRehenes)) (length listaRehenes)

complotPromedio :: [Rehen]->Int
complotPromedio listaRehenes = div (sum (map complot listaRehenes)) (length listaRehenes)

armasDeLadrones :: [Ladron] -> Int
armasDeLadrones listaLadrones = length . concat . map armas $ listaLadrones

-- Punto 8
seRebelanContraLadron :: Rehen -> Plan
seRebelanContraLadron rehen ladron = planContraLadrones (rehenConCagaso rehen) ladron 
rehenConCagaso :: Arma
rehenConCagaso rehen = aumentaMiedo 10 rehen

-- Punto 9
--planValencia 

-- Punto 10
--el plan Valencia no se podria ejecutar si la cantidad de armas de cada ladron fuera infinita debido a que nunca se llegaria a saber la cantidad de armas totales hay y no se podria multiplicar por el monto de dinero

-- Punto 11
-- el plan Valencia si se podria ejecutar en este caso debido a que no se debe analizar las habilidades en esta funcion

-- Punto 12
--funcion :: (->) -> Int -> [] ->String -> Bool
