import Text.Show.Functions
import Data.List

data Jugador = Jugador {
    nombre :: String,
    edad :: Int,
    promedioDeGol :: Float,
    habilidad :: Int,
    cansancio :: Float
} deriving (Show,Eq)

mapCansancio :: (Float->Float) -> Jugador -> Jugador
mapCansancio unaFuncion unJugador = unJugador { cansancio = unaFuncion (cansancio unJugador)}



type Equipo = (String, Char, [Jugador])

nombreEquipo :: Equipo -> String
nombreEquipo (nombre,_,_) = nombre

grupoEquipo :: Equipo -> Char
grupoEquipo (_,grupo,_) = grupo

jugadoresDelEquipo :: Equipo -> [Jugador]
jugadoresDelEquipo (_,_,jugadores) = jugadores

martin = Jugador "Martin" 26 0.0 50 35.0
juan = Jugador "Juancho" 30 0.2 50 40.0
maxi = Jugador "Maxi Lopez" 27 0.4 68 30.0

jonathan = Jugador "Chueco" 20 1.5 80 99.0
lean = Jugador "Hacha" 23 0.01 50 35.0
brian = Jugador "Panadero" 21 5 80 15.0

garcia = Jugador "Sargento" 30 1 80 13.0
messi = Jugador "Pulga" 26 10 99 43.0
aguero = Jugador "Aguero" 24 5 90 5.0

equipo1papa = ("Lo Que Vale Es El Intento", 'F', [martin, juan, maxi])
losDeSiempre = ( "Los De Siempre", 'F', [jonathan, lean, brian])
restoDelMundo = ("Resto del Mundo", 'A', [garcia, messi, aguero])


quickSort _ [] = [] 
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs 


--------------------------------------------------------------

quienesSonFiguras :: Equipo -> [Jugador]
quienesSonFiguras unEquipo = (filter esFigura . jugadoresDelEquipo) unEquipo

esFigura :: Jugador -> Bool
esFigura unJugador = habilidad unJugador > 75 && promedioDeGol unJugador > 0.0

---------------------------------------------------------------
jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

tieneFarandulero :: Equipo -> Bool
tieneFarandulero unEquipo =  (any esFarandulero . jugadoresDelEquipo) unEquipo

esFarandulero :: Jugador -> Bool
esFarandulero unJugador = elem (nombre unJugador) jugadoresFaranduleros

---------------------------------------------------------------

figuritasDificiles :: [Equipo] -> Char -> [String]
figuritasDificiles unosEquipos unGrupo = (map nombre . filter esFiguritaDificil . obtenerJugadores . filter (perteneceAlGrupo unGrupo)) unosEquipos

perteneceAlGrupo :: Char -> Equipo -> Bool
perteneceAlGrupo unGrupo unEquipo = grupoEquipo unEquipo == unGrupo

obtenerJugadores :: [Equipo] -> [Jugador]
obtenerJugadores unosEquipos = (concat . map jugadoresDelEquipo) unosEquipos

esFiguritaDificil :: Jugador -> Bool
esFiguritaDificil unJugador = esFigura unJugador && esJoven unJugador && (not . esFarandulero) unJugador 

esJoven :: Jugador -> Bool
esJoven unJugador = edad unJugador < 27

----------------------------------------------------------------

jugarPartido :: Equipo -> Equipo
jugarPartido unEquipo = (nombreEquipo unEquipo , grupoEquipo unEquipo , map modificarJugadores (jugadoresDelEquipo unEquipo))

modificarJugadores :: Jugador -> Jugador
modificarJugadores unJugador 
    | esFiguritaDificil unJugador = mapCansancio (const 50) unJugador
    | esJoven unJugador = mapCansancio (+ (diezPorcientoDelCansancio unJugador)) unJugador
    | (not.esJoven) unJugador && esFigura unJugador = mapCansancio (+20) unJugador
    | otherwise = mapCansancio (*2) unJugador

diezPorcientoDelCansancio :: Jugador -> Float
diezPorcientoDelCansancio unJugador =  10 * (cansancio unJugador) / 100 

----------------------------------------------------------------

ganadorDelPartido :: Equipo -> Equipo -> Equipo
ganadorDelPartido equipo1 equipo2 
    |  promedioTotal (jugadoresDelEquipo equipo1) > promedioTotal (jugadoresDelEquipo equipo2) = jugarPartido equipo1
    |  otherwise = jugarPartido equipo2

promedioTotal :: [Jugador] -> Float
promedioTotal unosJugadores = (sum . map promedioDeGol . take 11 . quickSort (menosCansado) ) unosJugadores

menosCansado :: Jugador -> Jugador -> Bool
menosCansado jugador1 jugador2 = cansancio jugador1 < cansancio jugador2

----------------------------------------------------------------

campeonDelTorneo :: [Equipo] -> Equipo
campeonDelTorneo unosEquipos = foldl1 ganadorDelPartido unosEquipos

{-campeonDelTorneo :: [Equipo] -> Equipo
campeonDelTorneo (unEquipo:[]) = unEquipo
campeonDelTorneo (equipo1 : equipo2 : equipos)
    | ganadorDelPartido equipo1 equipo2 == equipo1 = campeonDelTorneo (equipo1:equipos)
    | otherwise = campeonDelTorneo (equipo2:equipos)-}

----------------------------------------------------------------

elGroso :: [Equipo] -> String
elGroso unosEquipos = (nombre . head . filter esFigura . jugadoresDelEquipo . campeonDelTorneo) unosEquipos




    

