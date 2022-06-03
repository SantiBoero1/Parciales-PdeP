import Text.Show.Functions

data Planeta = Planeta {
    nombrePlaneta :: String,
    posicion :: Posicion,
    relacion :: Relacion
} deriving Show

type Relacion = Int -> Int

type Posicion = (Float, Float,Float)
coordX (x,_,_) = x
coordY (_,y,_) = y
coordZ (_,_,z) = z

data Astronauta = Astronauta {
    nombreAstronauta :: String,
    edad :: Int,
    planeta :: Planeta
} deriving Show

planetaTierra = Planeta "Tierra" (1.0, 1.0, 1.0)   normal
planetaMelmak = Planeta "Melmak" (4.4, 7.89, 3.33) cada1Es7

phil = Astronauta "Phil" 45 planetaTierra

normal :: Relacion
normal num = num * 1

cada1Es7 :: Relacion
cada1Es7 num = num * 7

mapNombrePlaneta :: (String -> String) -> Planeta -> Planeta
mapNombrePlaneta unaFuncion unPlaneta = unPlaneta { nombrePlaneta = unaFuncion (nombrePlaneta unPlaneta)}

mapPosicion :: (Posicion -> Posicion) -> Planeta -> Planeta
mapPosicion unaFuncion unPlaneta = unPlaneta { posicion = unaFuncion (posicion unPlaneta)}

mapRelacion :: (Relacion -> Relacion) -> Planeta -> Planeta
mapRelacion unaFuncion unPlaneta = unPlaneta { relacion = unaFuncion (relacion unPlaneta)}

mapNombreAstronauta :: (String -> String) -> Astronauta -> Astronauta
mapNombreAstronauta unaFuncion unAstronauta = unAstronauta { nombreAstronauta = unaFuncion (nombreAstronauta unAstronauta)}

mapEdad :: (Int -> Int) -> Astronauta -> Astronauta
mapEdad unaFuncion unAstronauta = unAstronauta { edad = unaFuncion (edad unAstronauta)}

mapPlaneta :: (Planeta -> Planeta) ->Astronauta -> Astronauta
mapPlaneta unaFuncion unAstronauta = unAstronauta { planeta = unaFuncion (planeta unAstronauta)}


-----------------------------------------------------------------------------

distanciaEntrePlanetas :: Planeta -> Planeta -> Float
distanciaEntrePlanetas planeta1 planeta2 = sqrt (calculoDeCoordenada coordX planeta1 planeta2 + calculoDeCoordenada coordY planeta1 planeta2 + calculoDeCoordenada coordZ planeta1 planeta2 )

calculoDeCoordenada :: (Posicion -> Float) -> Planeta -> Planeta -> Float
calculoDeCoordenada funcion planeta1 planeta2 =  (funcion (posicion planeta1) - funcion (posicion planeta2)) ^ 2

cuantoTiempoTarda :: Planeta -> Planeta -> Float -> Float
cuantoTiempoTarda planeta1 planeta2 velocidadDelViaje = distanciaEntrePlanetas planeta1 planeta2 - velocidadDelViaje

-----------------------------------------------------------------------------

pasarTiempo :: Int -> Astronauta -> Planeta -> Astronauta
pasarTiempo cantidadDeAños unAstronauta unPlaneta = mapEdad (+ (relacion (planeta unAstronauta)) cantidadDeAños ) unAstronauta

-----------------------------------------------------------------------------

viajarA :: Nave -> Planeta -> Astronauta -> Astronauta
viajarA unaNave planetaDestino unAstronauta  =  mapPlaneta (const planetaDestino) . mapEdad (+  round (unaNave (planeta unAstronauta) planetaDestino)) $ unAstronauta

type Nave = Planeta -> Planeta -> Float

naveVieja :: Int -> Nave
naveVieja tanquesDeOxigeno planeta1 planeta2 
    | tanquesDeOxigeno < 6 = cuantoTiempoTarda planeta1 planeta2 7.0
    | otherwise = cuantoTiempoTarda planeta1 planeta2 10.0

naveFuturista :: Planeta -> Planeta -> Float
naveFuturista planeta1 planeta2 = 0

-------------------------------------------------------------------------------

rescate :: [Astronauta] -> Nave -> Astronauta -> [Astronauta]
rescate unosAstronautas unaNave astronautaPerdido = (viajarDeAMuchos unaNave (planeta . head $ unosAstronautas) . (:) astronautaPerdido . viajarDeAMuchos unaNave (planeta astronautaPerdido)) unosAstronautas

viajarDeAMuchos :: Nave -> Planeta -> [Astronauta] -> [Astronauta]
viajarDeAMuchos unaNave unPlaneta unosAstronautas = map (viajarA unaNave unPlaneta) unosAstronautas




viajeConjunto :: Nave -> Planeta -> Planeta -> [Astronauta] -> [Astronauta]
viajeConjunto unaNave planetaOrigen planetaDestino unosAstronautas = map (mapEdad (+ round (unaNave planetaOrigen planetaDestino))) unosAstronautas