{-

1)
funcionMisteriosa :: Int -> String  -> Bool

funcionMisteriosa 3 :: String -> Bool

funcionMisteriosa unNumero unaPalabra = ((==unNumero).length) unaPalabra

2)
esNumeroDeLaSuerteSi :: (Ord a, Num a) => (a -> Bool) -> a -> Bool

esNumeroDeLaSuerteSi (>3) :: (Ord a, Num a) => a -> Bool 

esNumeroDeLaSuerteSi (>3) 4 :: Bool 

esNumeroDeLaSuerteSi unaCondicion unNumero = unaCondicion unNumero

3)
En cumpleLasCondiciones la funcion que se aplica parcialmente es "esMayorQue"
cumpleLasCondiciones :: (a -> Bool) -> (a -> Bool) -> a -> Bool
esMayorQue 3 :: Int -> Bool

En saludar la funcion que se aplica parcialmente es "++"
saludar :: (a -> b) -> a -> b
(++) :: String -> String

en elModuloDelPrimeroEsMayor no hay aplicacion parcial
elModuloDelPrimeroEsMayor :: (Num a, Ord a) => a -> a -> Bool

en tuplaDeFunciones hay aplicacion parcial
tuplaDeFunciones :: (a -> b) -> (a -> c) -> a -> (b , c)

4)
-}

tomarUltimosCuatroCaracteres :: String -> String
tomarUltimosCuatroCaracteres palabra = (reverse . take 4 . reverse) palabra

terminaCon :: String -> String -> Bool
terminaCon terminacion palabra = ((== terminacion) . tomarUltimosCuatroCaracteres) palabra

esPalabraBuenarda :: String -> Bool
esPalabraBuenarda  = (terminaCon "ardo")

esPalabraItaliana :: String -> Bool
esPalabraItaliana = (terminaCon "elli")

esMejorNumero :: (Num a, Ord a) => a -> a -> Bool
esMejorNumero num1 num2 = ((&& (num1 - num2) > 200 ) . (>num2)) num1