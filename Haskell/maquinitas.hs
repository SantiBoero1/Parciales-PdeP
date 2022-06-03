import Text.Show.Functions
import Data.List (find)

data Persona = Persona {
    nombre :: String,
    dinero :: Float,
    suerte :: Int,
    factores :: [Factor]
} deriving (Show)

type Factor = (String,Int)

nico = Persona "Nico" 100.0 30 [("amuleto", 3), ("manos magicas",100)]
maiu = Persona "Maiu" 100.0 42 [("inteligencia",55), ("paciencia",50)]

nombreFactor :: Factor -> String
nombreFactor (nombre,_) = nombre

valorFactor :: Factor -> Int
valorFactor (_,valor) = valor

----------------------------------------------------------------------

suerteTotal :: Persona -> String -> Int
suerteTotal unaPersona nombreDelFactorBuscado
  | (not . tieneFactor "amuleto") unaPersona = suerte unaPersona
  | otherwise                       = suerte unaPersona * valorAmuleto unaPersona


tieneFactor :: String -> Persona -> Bool
tieneFactor nombreDelFactorBuscado unaPersona = any (esFactor nombreDelFactorBuscado) (factores unaPersona) 

esFactor :: String -> Factor -> Bool
esFactor nombreDelFactorBuscado unFactor  = nombreFactor unFactor == nombreDelFactorBuscado && valorFactor unFactor > 0

valorAmuleto :: Persona -> Int
valorAmuleto unaPersona = valorFactor (factorDe  unaPersona)

factorDe ::  Persona -> Factor
factorDe  unaPersona = find (esFactor "amuleto") (factores unaPersona)




---------------------------------------------------------------------

data Juego = Juego {
    nombreJuego :: String,
    premio :: (Float -> Float),
    criterios :: [Criterio]
}

type Criterio = Persona -> Bool

ruleta :: Juego
ruleta = Juego "Ruleta" (* 37) [esAfortunada 80]

maquinita ::  Float -> Juego
maquinita jackpot = Juego "Maquinita" (\unaApuesta -> unaApuesta + jackpot) [esAfortunada 95 , esPaciente]

esPaciente :: Persona -> Bool
esPaciente unaPersona = tieneFactor "paciencia" unaPersona

esAfortunada :: Int -> Persona -> Bool
esAfortunada unValor unaPersona = suerteTotal unaPersona "amuleto" > unValor



ganaElJuego :: Persona -> Juego -> Bool
ganaElJuego unaPersona unJuego = all ($ unaPersona) (criterios unJuego)


----------------------------------------------------------------------

dineroTotal :: Persona -> Float -> [Juego] -> Float
dineroTotal unaPersona unaApuesta unosJuegos =  foldl (puedeGanar unaPersona) unaApuesta unosJuegos

puedeGanar :: Persona -> Float -> Juego -> Float
puedeGanar unaPersona resultadoAnterior unJuego 
    | ganaElJuego unaPersona unJuego = premio unJuego resultadoAnterior
    | otherwise = resultadoAnterior



{-dineroTotal :: Persona -> Float -> [Juego] -> Float
dineroTotal unaPersona unaApuesta [] = unaApuesta
dineroTotal unaPersona unaApuesta (juego1 : juegos) 
    | ganaElJuego unaPersona juego1 = dineroTotal unaPersona (premio juego1 unaApuesta) (juegos)
    | otherwise = dineroTotal unaPersona unaApuesta (juegos)-}



------------------------------------------------------------------------

noGananNunca :: [Persona] -> [Juego] -> [String]
noGananNunca jugadores juegos = (map nombre . filter (noGanaNunca juegos)) jugadores

noGanaNunca ::  [Juego] -> Persona -> Bool
noGanaNunca juegos jugador = all (not . ganaElJuego jugador) juegos
