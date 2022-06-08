module Lib where

---------------Resto-----------------------
-- mod dividiendo divisor
ejemplo = mod 3 2

---------------negar-----------------------
ejemplo2 numero = (-numero)

--------------------------------------------
----------------Listas----------------------
--------------------------------------------

---------------saber si lista esta vacia-----------------------
-- null :: [a] -> Bool
ejemplo3 = null [] 

---------------preceder-----------------------
-- (:) :: a -> [a] -> [a]
ejemplo4 = (:) 1 [2,3,4] 

---------------concatenacion-----------------------
--(++) :: [a] -> [a] -> [a]
ejemplo5 = (++) [1,2,3] [4,5,6]

---------------Acceso por indice-----------------------
-- (!!) :: [a] -> Int -> a -----(base  0)
ejemplo6 = (!!) [1,2,3] 0

---------------elemento Pertenence a lista-----------------------
--elem :: Eq a => a -> [a] -> Bool
ejemplo7 = elem 2 [1,2,3]

---------------Maximo y minimo de una lista-----------------------
--maximum :: Ord a => [a] -> a 
ejemplo8 = maximum [1,2,3,4,5]

--minimum:: Ord a => [a] -> a
ejemplo9 = minimum [1,2,3,4,5]

---------------Suma de elemntos de lista-----------------------
--sum :: Num a => [a] -> a
ejemplo10 = sum [1,2,3,4]

---------------concatenar listas dentro de una lista-----------------------
--concat :: [[a]] -> [a]
ejemplo11 = concat ["hola","soy","marco"]

---------------Tomar primeros n elemntos de la lista-----------------------
--take :: Int -> [a] -> [a]
ejemplo12 = take 3 [1,2,3,4,5,6]

---------------descartar primeros n elemntos de la lista-----------------------
--drop :: Int -> [a] -> [a]
ejemplo13 = drop 3 [1,2,3,4,5,6]

---------------lista sin su cola (lo contrario de tail)-----------------------
--init :: [a] -> [a]
ejemplo14 = init [1,2,3,4]

---------------apareo de listas-----------------------
--zip :: [a] -> [b] -> [(a, b)]
ejemplo15 = zip ["Boca","River"] ["River","Boca"]

---------------lista en orden reverso-----------------------
--reverse :: [a] -> [a]
ejemplo16 = reverse [1,2,3,4]

---------------Filtrar lista-----------------------
--filter :: (a->Bool) -> [a] -> [a]
ejemplo17 = filter (even) [1,2,3,4,5]