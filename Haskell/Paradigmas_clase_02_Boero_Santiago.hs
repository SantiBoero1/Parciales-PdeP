doble :: Floating a => a -> a
doble unNumero = unNumero * 2

tercio :: Integral a => a -> a
tercio unNumero = div unNumero  3


cuadruple :: Integral a => a -> a
cuadruple unNumero = unNumero * 4


quintuple :: Integral a => a -> a
quintuple unNumero = unNumero * 5


siguiente :: Floating a => a -> a
siguiente unNumero = unNumero + 1


anterior :: Integral a => a -> a
anterior unNumero = unNumero - 1


raizDelDobleDelSiguiente :: Floating a => a -> a
raizDelDobleDelSiguiente = sqrt.doble.siguiente


quintupleEsPar :: Integral a => a -> Bool
quintupleEsPar = even.quintuple


cuadrupleDelAnterior :: Integral a => a -> a
cuadrupleDelAnterior = cuadruple.anterior


tieneLongitudPar :: String -> Bool
tieneLongitudPar = even.length


elTercioDeCantidadDeLetrasEsPar :: String -> Bool
elTercioDeCantidadDeLetrasEsPar = even.tercio.length



ganarLoteria :: Num a => a -> a
ganarLoteria unaBilletera = unaBilletera + 1000 


esRico :: (Num a, Ord a) => a -> Bool
esRico unaBilletera = unaBilletera > 1000


esRicoSiGanaLaLoteria :: (Num a, Ord a) => a -> Bool
esRicoSiGanaLaLoteria billetera  = (esRico.ganarLoteria) billetera


f :: Int -> String -> Int
f x y = (+x ) (length y) 


sarasa :: a -> Int
sarasa = const 24 

edit :: String -> String
edit palabra = (++ "chiquito") palabra
