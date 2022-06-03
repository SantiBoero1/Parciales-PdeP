import Text.Show.Functions

data Heroe = Heroe {
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
} deriving (Show)

data Artefacto = Artefacto {
    nombreArtefacto :: String,
    rareza :: Int
} deriving (Show)

mapEpiteto :: (String -> String) -> Heroe -> Heroe
mapEpiteto unaFuncion unHeroe = unHeroe { epiteto = unaFuncion (epiteto unHeroe)}

mapArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
mapArtefactos unaFuncion unHeroe = unHeroe { artefactos = unaFuncion (artefactos unHeroe)}

mapRareza :: (Int -> Int) -> Artefacto -> Artefacto
mapRareza unaFuncion unArtefacto = unArtefacto { rareza = unaFuncion (rareza unArtefacto)}

mapTareas :: ([Tarea] -> [Tarea]) -> Heroe -> Heroe
mapTareas unaFuncion unHeroe = unHeroe { tareas = unaFuncion (tareas unHeroe)}

mapReconocimiento :: (Int -> Int) -> Heroe -> Heroe
mapReconocimiento unaFuncion unHeroe = unHeroe { reconocimiento = unaFuncion (reconocimiento unHeroe)}

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza del Olimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50

------------------------------------------------

-- Punto 2

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe
    | reconocimientoMayorA 1000 unHeroe = mapEpiteto (const "El mítico") unHeroe
    | reconocimientoMayorOIgualA 500 unHeroe = (mapArtefactos (lanzaDelOlimpo : ) . mapEpiteto (const "El magnifico")) unHeroe
    | reconocimientoEntre 500 100 unHeroe = (mapArtefactos (xiphos :) . mapEpiteto (const "Hoplita")) unHeroe
    | otherwise = unHeroe

reconocimientoMayorA :: Int -> Heroe -> Bool
reconocimientoMayorA unValor unHeroe = reconocimiento unHeroe > unValor 

reconocimientoMayorOIgualA :: Int -> Heroe -> Bool
reconocimientoMayorOIgualA unValor unHeroe = reconocimiento unHeroe >= unValor

reconocimientoEntre :: Int -> Int -> Heroe -> Bool
reconocimientoEntre unValor otroValor unHeroe = reconocimiento unHeroe < unValor && reconocimiento unHeroe > otroValor


-----------------------------------------------

-- Punto 3

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "Relampago de Zeus" 500

type Tarea = Heroe -> Heroe

data Bestia = Bestia {
    nombreBestia :: String,
    debilidad :: Debilidad
} deriving (Show)

type Debilidad = Heroe -> Bool

encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto unArtefacto = mapTareas (encontrarUnArtefacto unArtefacto:) . mapArtefactos (unArtefacto:) . mapReconocimiento (+ (rareza unArtefacto))


escalarElOlimpo :: Tarea
escalarElOlimpo =  mapTareas (escalarElOlimpo:) . mapArtefactos ((relampagoDeZeus:) . desecharArtefactosPocoRaros . triplicarRareza) . mapReconocimiento (+ 500)

triplicarRareza :: [Artefacto] -> [Artefacto]
triplicarRareza unosArtefactos = map (mapRareza (*3)) unosArtefactos

desecharArtefactosPocoRaros :: [Artefacto] -> [Artefacto]
desecharArtefactosPocoRaros unosArtefactos = filter ((>=1000) . rareza) unosArtefactos


ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle cantidadDeCuadras  = mapTareas (ayudarACruzarLaCalle cantidadDeCuadras:) . mapEpiteto (elGroso cantidadDeCuadras)

elGroso :: Int -> String -> String
elGroso cantidadDeCuadras epiteto = const ("Gros" ++ cantidadDeOs cantidadDeCuadras) epiteto

cantidadDeOs :: Int -> String
cantidadDeOs cantidadDeCuadras 
    | cantidadDeCuadras == 0 = ""
    | otherwise = "o" ++ cantidadDeOs (cantidadDeCuadras-1)


matarUnaBestia :: Bestia -> Tarea
matarUnaBestia unaBestia unHeroe
    | (debilidad unaBestia) unHeroe = (mapTareas (matarUnaBestia unaBestia:) . mapEpiteto (elAsesinoDe unaBestia)) unHeroe
    | otherwise = (mapArtefactos (drop 1) . mapEpiteto (const "El cobarde")) unHeroe

elAsesinoDe :: Bestia -> String -> String
elAsesinoDe unaBestia epiteto = const ("El asesino de " ++ nombreBestia unaBestia) epiteto

----------------------------------------------------

-- Punto 4

pistola :: Artefacto
pistola = Artefacto "Pistola" 1000

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [pistola, relampagoDeZeus] [escalarElOlimpo]

---------------------------------------------------

-- Punto 5

leonDeNemea :: Bestia
leonDeNemea = Bestia "Leon de Nemea" (\unHeroe -> length (epiteto unHeroe) >= 20)

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea unHeroe = matarUnaBestia leonDeNemea unHeroe

----------------------------------------------------

-- Punto 6

realizarTarea :: Heroe -> Tarea -> Heroe
realizarTarea unHeroe unaTarea = unaTarea unHeroe

----------------------------------------------------

presumirLogros :: Heroe -> Heroe -> (Heroe,Heroe)
presumirLogros unHeroe otroHeroe
    | tieneMasReconocimiento unHeroe otroHeroe = (unHeroe , otroHeroe)
    | tieneMasReconocimiento otroHeroe unHeroe = (otroHeroe , unHeroe)
    | tieneMasSumatoriaDeRarezas unHeroe otroHeroe = (unHeroe , otroHeroe)
    | tieneMasSumatoriaDeRarezas otroHeroe unHeroe = (otroHeroe , unHeroe)
    | otherwise = presumirLogros (realizarLabor unHeroe (tareas otroHeroe)) (realizarLabor otroHeroe (tareas unHeroe))

tieneMasReconocimiento :: Heroe -> Heroe -> Bool
tieneMasReconocimiento unHeroe otroHeroe = reconocimiento unHeroe > reconocimiento otroHeroe

tieneMasSumatoriaDeRarezas :: Heroe -> Heroe -> Bool
tieneMasSumatoriaDeRarezas unHeroe otroHeroe = sumatoriaDeRarezas unHeroe > sumatoriaDeRarezas otroHeroe

sumatoriaDeRarezas :: Heroe -> Int
sumatoriaDeRarezas unHeroe = (sum . map rareza) (artefactos unHeroe)

----------------------------------------------------

-- Punto 8

{-

El resultado de hacer que presuman dos heroes con reconocimiento 100, ningun artefacto y ninguna tarea realizada es un analisis infinito en la funcion presumirLogros,
ya que siempre entrara por el caso otherwise al cambiar el reconocimiento de ninguno de los dos heroes, ya que no poseen tareas u artefactos para modificarlo.
Dicho de otro modo, si hacemos lo planteado en la pregunta, la funcion se colgaria y realizaria un analisis infinito.

-}

type Labor = [Tarea]

------------------------------------------------------

-- Punto 9

realizarLabor :: Heroe -> Labor -> Heroe
realizarLabor unHeroe unasTareas = foldl (realizarTarea) unHeroe unasTareas

-----------------------------------------------------

-- Punto 10

{-

No, no se podra conocer el estado final del heroe si invocasemos a la funcion anterior con una labor infinita, ya que este mismo estaria 
realizando infinitas tareas debido a la funcion foldl sin llegar a un resultado.

-}