import Text.Show.Functions

-- PRIMERA PARTE

-- Punto 1

data Guantelete = Guantelete {
    material :: String,
    gemas :: [Gema]
} deriving (Show)


data Personaje = Personaje {
    edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad],
    nombre :: String,
    planeta :: String
} deriving (Show,Eq)

type Habilidad = String
type Gema = Personaje -> Personaje

cambiarEdad :: (Int -> Int) -> Personaje -> Personaje
cambiarEdad funcion personaje = personaje {edad = funcion (edad personaje)}

cambiarEnergia :: (Int -> Int) -> Personaje -> Personaje
cambiarEnergia funcion personaje = personaje {energia = funcion (energia personaje)}

cambiarHabilidades :: ([Habilidad] -> [Habilidad]) -> Personaje -> Personaje
cambiarHabilidades funcion personaje = personaje {habilidades = funcion (habilidades personaje)}

cambiarNombre :: (String -> String) -> Personaje -> Personaje
cambiarNombre funcion personaje = personaje {nombre = funcion (nombre personaje)}

cambiarPlaneta :: (String -> String) -> Personaje -> Personaje
cambiarPlaneta funcion personaje = personaje {planeta = funcion (planeta personaje) }


type Universo = [Personaje]
---------------------------------------------------------------------------------------------------------
thor = Personaje 30 150 ["Crear rayos", "Super fuerza"] "Thor" "Odin"
capitanAmerica = Personaje 35 90 ["Super fuerza", "Resistencia", "Escudo indestructible"] "Capitan" "Tierra"
drStrange = Personaje 47 65 ["Crear portales", "Manejar realidades", "Sabiduria"] "Dr Strange" "Tierra"
ironMan = Personaje 44 45 ["Millonario", "Inteligencia", "Robots"] "Iron man" "Tierra"
hulk = Personaje 50 130 ["Super fuerza"] "Hulk" "Tierra"
guanteCompleto = Guantelete "uru" [tiempo,(mente 45),(alma "mjolnir"),(espacio "Tierra"),poder,(loca (alma "mjolnir"))]

universo1 =  [ironMan, capitanAmerica, drStrange, thor]
universo2 =  [ironMan, capitanAmerica, drStrange]
universo3 =  [drStrange,hulk]
---------------------------------------------------------------------------------------------------------

guanteleteCompleto guantelete = (material guantelete == "uru") && (length (gemas guantelete) == 6)

reducir universo = take (div (length universo) 2) universo

chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo | guanteleteCompleto guantelete = reducir universo
                              | otherwise = universo


-- Punto 2

esPendex :: Personaje -> Bool
esPendex personaje = edad personaje < 45

aptoParaPendex :: Universo -> Bool
aptoParaPendex universo = any (esPendex) universo



sumaDeEnergias :: Universo -> Int
sumaDeEnergias habilidosos = (sum . map energia) habilidosos

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad personaje = length (habilidades personaje) > 1

masHabilidosos :: Universo -> Universo
masHabilidosos universo = filter (masDeUnaHabilidad) universo

energiaUniversal :: Universo -> Int
energiaUniversal universo = (sumaDeEnergias.masHabilidosos) universo


-- SEGUNDA PARTE

-- Punto 3

mente :: Int -> Personaje  -> Personaje
mente valorDado personaje  = cambiarEnergia (const valorDado) personaje

alma :: Habilidad -> Personaje -> Personaje
alma habilidad personaje = (cambiarHabilidades (filter (/= habilidad)) . cambiarEnergia (subtract 10)) personaje

espacio :: String -> Personaje -> Personaje
espacio planeta personaje = (cambiarPlaneta (const planeta) . cambiarEnergia (subtract 20)) personaje

poder :: Personaje -> Personaje
poder personaje = (cambiarHabilidades (chequeo)  . cambiarEnergia (const 0)) personaje 

chequeo habilidades | length habilidades <= 2 = []
                    | otherwise = habilidades 

tiempo :: Personaje -> Personaje
tiempo personaje = (cambiarEdad (condicionDePelea) . cambiarEnergia (subtract 50)) personaje

condicionDePelea edad | div edad 2 < 18 = 18
                      | otherwise = div edad 2

loca :: Gema -> Personaje -> Personaje
loca gema personaje =  gema (gema personaje)

-- Punto 4

guanteleteDeGoma = Guantelete "Goma" [tiempo, (alma "mjolnir") , (loca (alma "programacion en Haskell"))]

-- Punto 5
thanos = Personaje 76 350 ["Dominar el universo", "Lider"] "Thanos" "Galactus"

utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas enemigo = foldr ($) enemigo gemas

-- Punto 6

gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa guantelete personaje = cualEsLaMasPoderosa (gemas guantelete) personaje

cualEsLaMasPoderosa :: [Gema] -> Personaje -> Gema
cualEsLaMasPoderosa [gema] _ = gema
cualEsLaMasPoderosa (gema1:gema2:gemas) personaje |(energia.gema1) personaje < (energia.gema2) personaje = cualEsLaMasPoderosa (gema1:gemas) personaje
                                                  |otherwise = cualEsLaMasPoderosa (gema2:gemas) personaje



-- Punto 7
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete


{-Si, puede ejecutarse debido al concepto de Lazy evaluation o evaluacion diferida que utiliza Haskell. Este tipo de evaluacion lo que hace es evaluar primero a las funciones y
luego a los parametros, por lo cual primero tomara a la funcion utilizar, la cual toma a una lista de gemas y un personaje. Esta funcion le va a encomendar a la funcion take
que tome la lista que hay que utilizar, y take solamente va a tomar los primeros 3 elementos de la lista infinita de gemas que posee el guantelete, ya que take controla
de tomar solo los elementos que se le solicitan, el resto no le importa evaluarlos. Una vez tomados, pasan a la funcion utilizar y se le aplican al personaje.-}