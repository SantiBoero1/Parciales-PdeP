import Text.Show.Functions

data Mascota = Mascota {
    nombre :: String,
    edad :: Int,
    dueño :: Persona,
    energia :: Int,
    trucos :: [Truco],
    distraida :: Bool
} deriving Show

data Persona = Persona {
    nombreDueño :: String,
    experiencia :: Int
} deriving Show

type Truco = Mascota -> Mascota

mapEnergia :: (Int -> Int) -> Mascota -> Mascota
mapEnergia unaFuncion unaMascota = 



