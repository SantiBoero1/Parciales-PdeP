import Text.Show.Functions

data Ladron = Ladron {
    nombreLadron :: String,
    habilidades :: [Habilidad],
    armas :: [Arma]
} deriving Show

data Rehen = Rehen {
    nombreRehen :: String,
    nivelComplot :: Int,
    nivelMiedo :: Int,
    plan :: [Plan]
} deriving Show

type Habilidad = String

type Arma = Rehen -> Rehen

type Plan = Ladron -> Ladron

mapArmas :: ([Arma] -> [Arma]) -> Ladron -> Ladron
mapArmas unaFuncion unLadron = unLadron { armas = unaFuncion (armas unLadron)}

mapComplot :: (Int -> Int) -> Rehen -> Rehen
mapComplot unaFuncion unRehen = unRehen { nivelComplot = unaFuncion (nivelComplot unRehen)}

mapMiedo :: (Int -> Int) -> Rehen -> Rehen
mapMiedo unaFuncion unRehen = unRehen { nivelMiedo = unaFuncion (nivelMiedo unRehen)}


pistola :: Int -> Arma
pistola calibre unRehen = (mapMiedo (+ length (nombreRehen unRehen)) . mapComplot (subtract (5*calibre))) unRehen

ametralladora :: Int -> Arma
ametralladora cantidadDeBalas unRehen = (mapMiedo (+ cantidadDeBalas) . mapComplot (`div` 2)) unRehen

cantidadDeLetras :: Ladron -> Int
cantidadDeLetras unLadron = (length . concat . habilidades) unLadron


atacarAlLadron :: Rehen -> Ladron -> Ladron
atacarAlLadron unRehen unLadron 
    | nivelComplot unRehen > nivelMiedo unRehen = sacarleArmasAlLadron (cantidadDeArmasQueLeSaca unRehen) unLadron 
    | otherwise = mapArmas noHaceNada unLadron

noHaceNada :: [Arma] -> [Arma]
noHaceNada unasArmas = unasArmas

cantidadDeArmasQueLeQuedaron :: Rehen -> Int
cantidadDeArmasQueLeQuedaron unRehen =  (div (length (nombreRehen unRehen)) 10)


esconderse :: Rehen -> Ladron -> Ladron
esconderse unRehen unLadron
    | nivelComplot unRehen > nivelMiedo unRehen = sacarleArmasAlLadron (cantidadDeArmasQueLeQuita unLadron) unLadron
    | otherwise = mapArmas noHaceNada unLadron

cantidadDeArmasQueLeQuita :: Ladron -> Int
cantidadDeArmasQueLeQuita unLadron =  div (cantidadDeHabilidades unLadron) 3

sacarleArmasAlLadron :: Int -> Ladron -> Ladron  
sacarleArmasAlLadron unNum unLadron = mapArmas (drop unNum) unLadron





-- Es repetir logica a pesar de que toman distintos parametros para hacer la funcion?



-----------------------------------------------------------------------------------------

-- Punto 1

tokio = Ladron "Tokio" ["Trabajo psicologico" , "Entrar en moto"] [pistola 9 , pistola 9 , ametralladora 30]

profesor = Ladron "Profesor" ["Disfrazarse de linyera", "Disfrazarse de payaso", "Estar siempre un paso adelante"] []

pablo = Rehen "Pablo" 40 30 [esconderse pablo]

arturito = Rehen "Arturo" 70 50 [esconderse arturito, atacarAlLadron pablo]

-- Punto 2

esInteligente :: Ladron -> Bool
esInteligente unLadron = cantidadDeHabilidades unLadron > 2

cantidadDeHabilidades :: Ladron -> Int
cantidadDeHabilidades unLadron = length (habilidades unLadron)

-- Punto 3

conseguirUnArma :: Arma -> Ladron -> Ladron
conseguirUnArma armaNueva unLadron = mapArmas (armaNueva :) unLadron 

-- Punto 4

disparos :: Ladron -> Rehen -> Rehen
disparos unLadron unRehen = (generaMasMiedo (armas unLadron) unRehen) unRehen

generaMasMiedo :: [Arma] -> Rehen -> Arma
generaMasMiedo (unArma:[]) unRehen = unArma 
generaMasMiedo (arma1:arma2:listaDeArmas) unRehen 
    | nivelMiedo (arma1 unRehen) > nivelMiedo (arma2 unRehen) = generaMasMiedo (arma1:listaDeArmas) unRehen
    | otherwise = generaMasMiedo (arma2:listaDeArmas) unRehen    


hacerseElMalo :: Ladron -> Rehen -> Rehen
hacerseElMalo unLadron unRehen 
    | nombreLadron unLadron == "Berlin" = mapMiedo (+ (cantidadDeLetras unLadron)) unRehen
    | nombreLadron unLadron == "Rio"    = mapComplot (+ 20) unRehen
    | otherwise = mapMiedo (+10) unRehen


-- Punto 5
todosPierdenComplot :: Int -> [Rehen] -> [Rehen]
todosPierdenComplot cantidadQuePierden unosRehenes = map (mapComplot (subtract cantidadQuePierden)) unosRehenes

calmarLasAguas :: Ladron -> [Rehen] -> [Rehen]
calmarLasAguas unLadron unosRehenes = todosPierdenComplot 60 (filter esComplotero unosRehenes)

esComplotero :: Rehen -> Bool
esComplotero unRehen = nivelComplot unRehen > 60

-- Punto 6

puedeEscaparse :: Ladron -> Bool
puedeEscaparse unLadron = any puedeDisfrazarse (unirLasPalabrasDeLasHabilidades unLadron)

unirLasPalabrasDeLasHabilidades :: Ladron -> [Habilidad]
unirLasPalabrasDeLasHabilidades unLadron  = (map (concat.words) (habilidades unLadron))

puedeDisfrazarse :: Habilidad -> Bool
puedeDisfrazarse unaHabilidad = take 13 unaHabilidad == "Disfrazarsede" || take 13 unaHabilidad == "disfrazarsede"

-- Punto 7

laCosaPintaMal :: [Ladron] -> [Rehen] -> Bool
laCosaPintaMal unosLadrones unosRehenes = nivelDeComplotPromedio unosRehenes > nivelDeMiedoPromedio unosRehenes * cantidadDeArmas unosLadrones

nivelDeComplotPromedio :: [Rehen] -> Int
nivelDeComplotPromedio unosRehenes = (sum . map nivelComplot) unosRehenes

nivelDeMiedoPromedio :: [Rehen] -> Int
nivelDeMiedoPromedio unosRehenes = (sum . map nivelMiedo) unosRehenes

cantidadDeArmas :: [Ladron] -> Int
cantidadDeArmas unosLadrones = (sum . map (length.armas)) unosLadrones

-- Punto 8

rebelarse :: [Rehen] -> Ladron -> Ladron
rebelarse unosRehenes unLadron = (foldr ($) unLadron  . listaDePlanes . todosPierdenComplot 10) unosRehenes

listaDePlanes :: [Rehen] -> [Plan]
listaDePlanes unosRehenes = (concat . map (plan)) unosRehenes


-- Punto 9

planValencia :: [Ladron] -> [Rehen] -> Int
planValencia unosLadrones unosRehenes =  ((* 1000000) . cantidadDeArmas . map (rebelarse unosRehenes) . armarLadrones) unosLadrones

armarLadrones :: [Ladron] -> [Ladron]
armarLadrones unosLadrones = map (conseguirUnArma (ametralladora 45)) unosLadrones

-- Punto 10

{- 

No, no podria ejecutarse ya que para sacar la cantidad de armas se utiliza un length con la lista de armas, y como esa lista es infinita, la funcion length nunca dara un resultado
por lo cual no se podria llevar a cabo el plan valencia con una lista de armas infinitas 

-}


{-

Si, se podria llevar a cabo ya que la lista de habilidades de los ladrones nunca son utilizados en la funcion planValencia, por lo cual puede operar con normalidad tomando
solo lo que requiera del data de los ladrones para realizar la funcion

-}

funcion :: b -> (c -> [d]) -> (b -> c -> Bool) -> Int -> [c] -> Bool
funcion cond num lista str = (> str) . sum . map (length . num) . filter (lista cond)


