import Text.Show.Functions

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)


bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

mapVelocidad :: (Int -> Int) -> Tiro -> Tiro
mapVelocidad unaFuncion unTiro = unTiro { velocidad = unaFuncion (velocidad unTiro)}

mapPrecision :: (Int -> Int) -> Tiro -> Tiro
mapPrecision unaFuncion unTiro = unTiro { precision = unaFuncion (precision unTiro)}

mapAltura :: (Int -> Int) -> Tiro -> Tiro
mapAltura unaFuncion unTiro = unTiro { altura = unaFuncion (altura unTiro)}

type Puntos = Int

-- Funciones útiles

between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-------------------------------------------------------------------

type Palo = Habilidad -> Tiro

putter :: Palo
putter unaHabilidad = UnTiro { velocidad = 10, precision = (precisionJugador unaHabilidad) * 2, altura = 0}

madera :: Palo
madera unaHabilidad = UnTiro { velocidad = 100, precision = dividirPrecision 2 (precisionJugador unaHabilidad), altura = 5}

hierros :: Int -> Palo
hierros n unaHabilidad = UnTiro { velocidad = (fuerzaJugador unaHabilidad) * n, precision = dividirPrecision n (precisionJugador unaHabilidad), altura = max 0 (n-3)}

dividirPrecision :: Int -> Int -> Int
dividirPrecision n precisionJugador = div precisionJugador n

palos :: [Palo]
palos = [putter,madera,hierros 1,hierros 2, hierros 3, hierros 4 ,hierros 5, hierros 6, hierros 7, hierros 8, hierros 9, hierros 10]

--------------------------------------------------------------------

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo (habilidad unJugador)

------------------------------------------------------------------
data Obstaculo = Obstaculo {
  condicion :: Tiro -> Bool,
  resultado :: Tiro -> Tiro
  } deriving Show

tunelConRampita :: Obstaculo
tunelConRampita = Obstaculo condicionTunelConTrampita resultadoDelTiroATrampita

condicionTunelConTrampita :: Tiro -> Bool
condicionTunelConTrampita unTiro = precision unTiro > 90 && altura unTiro == 0

resultadoDelTiroATrampita :: Tiro -> Tiro
resultadoDelTiroATrampita unTiro = (mapPrecision (const 100) . mapVelocidad (*2)) unTiro

unaLaguna :: Int -> Obstaculo
unaLaguna largoDeLaguna = Obstaculo condicionUnaLaguna (resultadoDelTiroALaguna largoDeLaguna)

condicionUnaLaguna :: Tiro -> Bool
condicionUnaLaguna unTiro = velocidad unTiro > 80 && estaEntre (altura unTiro) 1 5

resultadoDelTiroALaguna :: Int -> Tiro -> Tiro
resultadoDelTiroALaguna largoDeLaguna unTiro = mapAltura (`div` largoDeLaguna) unTiro

unHoyo :: Obstaculo
unHoyo = Obstaculo condicionUnHoyo resultadoDelTiroAUnHoyo

condicionUnHoyo :: Tiro -> Bool
condicionUnHoyo unTiro = estaEntre (velocidad unTiro) 5 20 && altura unTiro == 0 && precision unTiro > 90

resultadoDelTiroAUnHoyo :: Tiro -> Tiro
resultadoDelTiroAUnHoyo unTiro = setearEn0 unTiro


tirarEnObstaculo :: Obstaculo -> Tiro -> Tiro
tirarEnObstaculo unObstaculo unTiro
  | condicion unObstaculo unTiro = resultado unObstaculo unTiro
  | otherwise                    = setearEn0 unTiro

estaEntre :: Int -> Int -> Int -> Bool
estaEntre altura primerNum segundoNum = altura >= primerNum && altura <= segundoNum

setearEn0 :: Tiro -> Tiro
setearEn0 = mapVelocidad (const 0) . mapPrecision (const 0) . mapAltura (const 0)

{-  | precision unTiro > 90 && altura unTiro == 0 =  (mapPrecision (const 100) . mapVelocidad (*2)) unTiro
    | otherwise = setearEn0 unTiro

unaLaguna :: Int -> Obstaculo
unaLaguna largoDeLaguna unTiro
    | velocidad unTiro > 80 && estaEntre (altura unTiro) 1 5 = mapAltura (`div` largoDeLaguna) unTiro
    | otherwise = setearEn0 unTiro

unHoyo :: Obstaculo
unHoyo unTiro
    | estaEntre (velocidad unTiro) 5 20 && altura unTiro == 0 && precision unTiro > 90 = setearEn0 unTiro
    | otherwise = setearEn0 unTiro

estaEntre :: Int -> Int -> Int -> Bool
estaEntre altura primerNum segundoNum = altura >= primerNum && altura <= segundoNum

setearEn0 :: Tiro -> Tiro
setearEn0 = mapVelocidad (const 0) . mapPrecision (const 0) . mapAltura (const 0)

 
superaElObstaculo :: Obstaculo -> Tiro -> Tiro
superaElObstaculo unObstaculo unTiro = unObstaculo unTiro
-}
-------------------------------------------------------------------

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter (pasaElObstaculo (habilidad unJugador) unObstaculo) palos

pasaElObstaculo :: Habilidad -> Obstaculo -> Palo -> Bool
pasaElObstaculo unaHabilidad unObstaculo unPalo =  condicion unObstaculo (unPalo unaHabilidad)
 

cuantosObstaculoSupera :: [Obstaculo] -> Tiro -> Int
cuantosObstaculoSupera unosObstaculos unTiro = (length . takeWhile (superaLaCondicion unTiro)) unosObstaculos 

superaLaCondicion :: Tiro -> Obstaculo -> Bool
superaLaCondicion unTiro unObstaculo = condicion unObstaculo unTiro


paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil unJugador unosObstaculos = foldl1 (mejorPaloEntre (habilidad unJugador) unosObstaculos) palos

mejorPaloEntre :: Habilidad -> [Obstaculo] -> Palo -> Palo -> Palo
mejorPaloEntre unaHabilidad unosObstaculos unPalo otroPalo 
  | cuantosObstaculoSupera unosObstaculos (unPalo unaHabilidad) > cuantosObstaculoSupera unosObstaculos (otroPalo unaHabilidad) = unPalo
  | otherwise = otroPalo


{-cualSuperaMasObstaculos :: Habilidad -> [Obstaculo] -> [Palo] -> Palo
cualSuperaMasObstaculos habilidad unosObstaculos (unPalo:[]) = unPalo
cualSuperaMasObstaculos habilidad unosObstaculos (palo1:palo2:palos)
  | cuantosObstaculoSupera unosObstaculos (palo1 habilidad) > cuantosObstaculoSupera unosObstaculos (palo2 habilidad) = cualSuperaMasObstaculos habilidad unosObstaculos (palo1:palos)
  | otherwise = cualSuperaMasObstaculos habilidad unosObstaculos (palo2:palos)-}



-------------------------------------------------------------------------

quienesPerdieron :: [(Jugador,Int)] -> [String]
quienesPerdieron listaDeJugadores = (filter (/= ganador listaDeJugadores) . map (padre . fst)) listaDeJugadores 

ganador :: [(Jugador,Int)] -> String
ganador (unJugador:[]) = (padre . fst) unJugador
ganador (jugador1 : jugador2 : jugadores) 
    | snd jugador1 > snd jugador2 = ganador (jugador1 : jugadores)
    | otherwise = ganador (jugador2 : jugadores)


