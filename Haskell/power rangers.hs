data Persona = Persona {
    habilidades :: [Habilidad],
    esBuena :: Bool
} deriving Show

type Habilidad = String

data PowerRanger = PowerRanger {
    color :: String,
    habilidadesPR :: [Habilidad],
    nivelDePelea :: Int
} deriving Show

mapHabilidades :: ([Habilidad] -> [Habilidad]) -> Persona -> Persona
mapHabilidades unaFuncion unPowerRanger = unPowerRanger { habilidades = unaFuncion (habilidades unPowerRanger)}


convertirEnPowerRanger :: String -> Persona -> PowerRanger
convertirEnPowerRanger unColor unaPersona = PowerRanger { color = unColor, habilidadesPR = potenciar (habilidades unaPersona) , nivelDePelea = cantidadDeLetrasDeSusHabilidades (habilidades unaPersona)}

potenciar :: [Habilidad] -> [Habilidad]
potenciar unasHabilidades = map ("super" ++) unasHabilidades

cantidadDeLetrasDeSusHabilidades :: [Habilidad] -> Int
cantidadDeLetrasDeSusHabilidades unasHabilidades = (sum . map length . map (concat . words)) unasHabilidades