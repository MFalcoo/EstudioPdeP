module Lib where

---------------Invertir parametros-----------------------
--flip :: (a->b->c) -> b -> a -> c

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

---------------Transformar lista-----------------------
--map ::  (a->b) -> [a] -> [b]
ejemplo18 = map (+1) [1,2,3]

---------------Todos en la lista cumplen-----------------------
--all :: (a->Bool) -> [a] -> Bool
ejemplo19 = all (==0) [0,0,0]

---------------alguno en la lista cumple-----------------------
--any :: (a->Bool) -> [a] -> Bool
ejemplo20 = any (==0) [0,1,2]

---------------Reducir/Plegar (Izq)-----------------------
--foldl :: (a->b->a) -> a -> [b] -> a
ejemplo21 = foldl (div) 16 [4,2]
--λ> foldl (-) 20 [2,5,3]
--10
--λ> ((20-2)-5)-3
--10
--λ> foldl (-) 20 [2,5,3,4]
--6
--λ> (((20-2)-5)-3)-4
--6

---------------Reducir/Plegar (Der)-----------------------
--foldr :: (b->a->a) -> a -> [b] -> a
ejemplo22 = foldr (div) 4 [8,16]
--λ> foldr (-) 20 [2,5,3]
--(-20)
--λ> 2-(5-(3-20))
--(-20)
--λ> foldr (-) 20 [2,5,3,4]
--16
--λ> 2-(5-(3-(4-20)))
--16

---------------Apareo con transformacion-----------------------
--zipWith :: (a->b->c) -> [a] -> [b] -> [c]
ejemplo23 = zipWith (,) ["Boca","River","Velez"] ["Godoy","Racing","Newels"]

---------------Primer Elemento que cumple-----------------------
--find :: (a->Bool) -> [a] -> a
--ejemplo24 = find even [1,2,3,4,5,3]

---------------Ordenar lista-----------------------
--sort :: Ord a => [a] -> [a]
--ejemplo25 = sort [2,3,4,51,1]


----------------------------------------------------------
----------------Generacion de Listas----------------------
----------------------------------------------------------

---------------Generar lista de 1 elemento dado infinitas veces -----------------------
--repeat  :: a -> [a]
ejemplo26 = repeat 'a'

---------------Generar lista de un elemento que pasa x una funcion infinitas veces -----------------------
--iterate :: (a->a) -> a -> [a]
ejemplo27 = iterate (++"*") "Marco"

---------------Generar lista de 1 elemento dado una cierta cantidad de veces-----------------------
--replicate :: Int -> a -> [a]
ejemplo28 = replicate 5 "hola"

---------------Generar lista de 1 lista dada infinitas veces-----------------------
--cycle  :: [a] -> [a]
ejemplo29 = cycle [1,2,3,4]