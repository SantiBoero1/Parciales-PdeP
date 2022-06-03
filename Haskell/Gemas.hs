import Text.Show.Functions

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto situacion aspectoBuscado = aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

---------------------------------

modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto unaFuncion unAspecto = unAspecto { grado = unaFuncion (grado unAspecto)}

mejorSituacion :: Situacion -> Situacion -> Bool
mejorSituacion situacion1 situacion2 = (all (==True) . zipWith (mejorAspecto) situacion1) situacion2

modificarSituacion ::  Aspecto -> (Float -> Float) -> Situacion -> Situacion
modificarSituacion unAspecto unaFuncion unaSituacion = (reemplazarAspecto (unaSituacion) . modificarAspecto (unaFuncion) . buscarAspecto (unAspecto)) unaSituacion

----------------------------------

data Gema = Gema {
    nombre :: String, 
    fuerza :: Int,
    personalidad :: Personalidad
} deriving Show

gemaFuerte = Gema "Fuerte" 1000 vidente
gemaInteligente = Gema "Inteligente" 100 relajada

type Personalidad = Situacion -> Situacion

incertidumbre = UnAspecto "Incertidumbre" 50

tension = UnAspecto "Tension" 100

peligro = UnAspecto "Peligro" 0

vidente :: Personalidad
vidente unaSituacion = (modificarSituacion (tension) (subtract 10) . modificarSituacion  (incertidumbre) (/2))  unaSituacion 

relajada :: Personalidad
relajada unaSituacion = (modificarSituacion (peligro) (+ grado tension) . modificarSituacion (tension) (subtract 30)) unaSituacion

------------ 3 ----------------

leGana :: Gema -> Gema -> Situacion -> Bool
leGana gema1 gema2 unaSituacion = esMasOIgualDeFuerte gema1 gema2 && mejorSituacion (personalidad gema1 unaSituacion) (personalidad gema2 unaSituacion)

esMasOIgualDeFuerte :: Gema -> Gema -> Bool
esMasOIgualDeFuerte gema1 gema2 = fuerza gema1 >= fuerza gema2

------------ 4 -----------------

fusionDeGemas :: Gema -> Gema -> Situacion -> Gema
fusionDeGemas gema1 gema2 unaSituacion = Gema (fusionarNombre gema1 gema2)  (sonCompatibles gema1 gema2 unaSituacion) (personalidadFusionada gema1 gema2 unaSituacion)   

sonCompatibles :: Gema -> Gema -> Situacion -> Int
sonCompatibles gema1 gema2 unaSituacion 
    | mejorSituacion (personalidadFusionada gema1 gema2 unaSituacion) (personalidad gema1 unaSituacion) && mejorSituacion (personalidadFusionada gema1 gema2 unaSituacion) (personalidad gema2 unaSituacion) = (fuerza gema1 + fuerza gema2) * 10
    | mejorSituacion  (personalidad gema1 unaSituacion) (personalidadFusionada gema1 gema2 unaSituacion) = 7 * fuerza gema1
    | otherwise = 7 * fuerza gema2


personalidadFusionada :: Gema -> Gema -> Situacion -> Situacion
personalidadFusionada gema1 gema2 unaSituacion = personalidad gema2 (personalidad gema1 (modificarTodaLaSituacion unaSituacion))

modificarTodaLaSituacion :: Situacion -> Situacion
modificarTodaLaSituacion unaSituacion = map (modificarAspecto (subtract 10)) unaSituacion

fusionarNombre :: Gema -> Gema -> String
fusionarNombre gema1 gema2 
    | nombre gema1 == nombre gema2 = nombre gema1
    | otherwise = nombre gema1 ++ " " ++ nombre gema2 
