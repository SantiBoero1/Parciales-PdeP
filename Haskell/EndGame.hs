import Text.Show.Functions

data Heroe = Heroe {
    nombreHeroe :: String,
    vida :: Int,
    planetaHeroe :: String,
    artefacto :: Artefacto,
    villano :: Villano
} deriving Show

data Villano = Villano {
    nombreVillano :: String,
    planetaVillano :: String,
    arma :: Arma
} deriving Show

data Artefacto = Artefacto {
    nombreArtefacto :: String,
    daño :: Int
} deriving (Show,Eq)

type Arma = Heroe -> Heroe

---------- auxiliares ------------------
mapNombreHeroe :: (String -> String) -> Heroe -> Heroe
mapNombreHeroe unaFuncion unHeroe = unHeroe { nombreHeroe = unaFuncion (nombreHeroe unHeroe)}

mapVida :: (Int -> Int) -> Heroe -> Heroe
mapVida unaFuncion unHeroe = unHeroe { vida = unaFuncion (vida unHeroe)}

mapPlanetaHeroe :: (String -> String) -> Heroe -> Heroe
mapPlanetaHeroe unaFuncion unHeroe = unHeroe { planetaHeroe = unaFuncion (planetaHeroe unHeroe)}

mapVillano :: (Villano -> Villano) -> Heroe -> Heroe
mapVillano unaFuncion unHeroe = unHeroe { villano = unaFuncion (villano unHeroe)}

mapArtefacto :: (Artefacto -> Artefacto) -> Heroe -> Heroe
mapArtefacto unaFuncion unHeroe = unHeroe { artefacto = unaFuncion (artefacto unHeroe)}

mapNombreVillano :: (String -> String) -> Villano -> Villano
mapNombreVillano unaFuncion unVillano = unVillano { nombreVillano = unaFuncion (nombreVillano unVillano)}

mapPlanetaVillano :: (String -> String) -> Villano -> Villano
mapPlanetaVillano unaFuncion unVillano = unVillano { planetaVillano = unaFuncion (planetaVillano unVillano)}

mapArma :: (Arma -> Arma) -> Villano -> Villano
mapArma unaFuncion unVillano = unVillano { arma = unaFuncion (arma unVillano)}

mapNombreArtefacto :: (String -> String) -> Artefacto -> Artefacto
mapNombreArtefacto unaFuncion unArtefacto = unArtefacto { nombreArtefacto = unaFuncion (nombreArtefacto unArtefacto)}

mapDaño :: (Int -> Int) -> Artefacto -> Artefacto
mapDaño unaFuncion unArtefacto = unArtefacto {daño = unaFuncion (daño unArtefacto)}


------------------ 1 -------------------

ironMan = Heroe "Tony Stark" 100 "Tierra" traje thanos

thor = Heroe "Thor Odinson" 300 "Asgard" stormbreaker thanos

thanos = Villano "Thanos" "Titan" guanteleteDelInfinito

loki = Villano "Loki Laufeyson" "Jotunheim" (cetro 20)

------------------ 2 -------------------
traje :: Artefacto
traje = Artefacto "Traje IronMan" 12

stormbreaker :: Artefacto
stormbreaker = Artefacto "StormBreaker" 0

guanteleteDelInfinito :: Arma
guanteleteDelInfinito unHeroe = mapVida (reducirEnPorcentaje 80) unHeroe

reducirEnPorcentaje porcentaje vidaDelHeroe  = vidaDelHeroe - div (vidaDelHeroe * porcentaje) 100 


cetro :: Int -> Arma
cetro porcentajeEfectividad unHeroe 
    | heroeViveEn "Tierra" unHeroe = (mapVida (reducirEnPorcentaje porcentajeEfectividad) . romperArtefacto) unHeroe
    | otherwise = mapVida (reducirEnPorcentaje porcentajeEfectividad) unHeroe

heroeViveEn :: String -> Heroe -> Bool
heroeViveEn planeta unHeroe = planetaHeroe unHeroe == planeta

romperArtefacto :: Heroe -> Heroe
romperArtefacto unHeroe = mapArtefacto (mapDaño (+30).mapNombreArtefacto (++ " machacado")) unHeroe

--------------------- 3 ------------------------

sonAntagonistas :: Villano -> Heroe  -> Bool
sonAntagonistas unVillano unHeroe  = (tomarNombre unVillano == tomarNombre (villano unHeroe))  || (tomarPlanetaVillano unVillano == tomarPlanetaHeroe unHeroe)

tomarNombre :: Villano -> String
tomarNombre unVillano = nombreVillano unVillano

tomarPlanetaHeroe :: Heroe -> String
tomarPlanetaHeroe unHeroe = planetaHeroe unHeroe

tomarPlanetaVillano :: Villano -> String
tomarPlanetaVillano unVillano = planetaVillano unVillano

-------------------- 4 ------------------------
atacar :: Heroe -> Villano -> Heroe
atacar unHeroe unVillano  | sonAntagonistas unVillano unHeroe  = unHeroe
                          | otherwise = arma unVillano unHeroe

villanosContraUno :: [Villano] -> Heroe -> Heroe
villanosContraUno [] unHeroe = unHeroe
villanosContraUno (x:[]) unHeroe = atacar unHeroe x
villanosContraUno (x:xs) unHeroe =  villanosContraUno xs (atacar unHeroe x) 

--armasDeVillano :: [Villano] -> [Arma]

------------------ 5 -----------------------------

sobrevivenAlVillano :: [Heroe] -> Villano -> [Heroe]
sobrevivenAlVillano unosHeroes unVillano = map agregarSuper . filter (sobrevivio) . map (atacarAHeroe unVillano) $ unosHeroes

atacarAHeroe :: Villano -> Heroe -> Heroe
atacarAHeroe unVillano unHeroe = arma unVillano unHeroe

sobrevivio :: Heroe -> Bool
sobrevivio unHeroe = vida unHeroe >= 50

agregarSuper :: Heroe -> Heroe
agregarSuper unHeroe = mapNombreHeroe ("Super " ++) unHeroe

------------------ 6 ------------------------------

hogarDulceHogar :: [Heroe] -> Villano -> [Heroe]
hogarDulceHogar unosHeroes unVillano = map (descansarYRecuperar) (sobrevivenAlVillano unosHeroes unVillano)

descansarYRecuperar :: Heroe -> Heroe
descansarYRecuperar = mapArtefacto ( mapNombreArtefacto (yaNoEstaMachacado) . mapDaño (const 0) ) . mapVida (+30)

yaNoEstaMachacado :: String -> String
yaNoEstaMachacado nombreArtefacto = unwords (filter (/= "machacado") (words nombreArtefacto))

------------------ 7 ------------------------------

esDebil :: Villano -> [Heroe] -> Bool
esDebil unVillano unosHeroes = esAntagonistaDeTodos (map (sonAntagonistas unVillano) unosHeroes) && ningunoEstaMachacado unosHeroes

ningunoEstaMachacado :: [Heroe] -> Bool
ningunoEstaMachacado unosHeroes = all (==True) (map estaMachacado unosHeroes)

estaMachacado :: Heroe -> Bool
estaMachacado unHeroe = all (/= "machacado") ((words . nombreArtefacto . artefacto) unHeroe)

esAntagonistaDeTodos :: [Bool] -> Bool
esAntagonistaDeTodos listaDeBool = all (== True) listaDeBool

---------------- 8 ---------------------------------

drStrange = Heroe "Stephen Strange" 60 "Tierra" capaDeLevitacion thanos

capaDeLevitacion :: Artefacto
capaDeLevitacion = Artefacto "Capa de levitacion" 0 

infinitosClones :: [Heroe]
infinitosClones = map (funcion . show) listaInfinitaDeNumeros

funcion :: String -> Heroe
funcion literalCadena = mapNombreHeroe (++ " " ++ literalCadena) drStrange

listaInfinitaDeNumeros :: [Int]
listaInfinitaDeNumeros = iterate (+1) 1
