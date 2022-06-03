import Text.Show.Functions ()

data Mutante = Mutante {
    nombre :: String,
    vida :: Int,
    habilidades :: [Habilidad],
    armas :: [Arma]
} deriving Show

type Habilidad = String
type Arma = Mutante -> Mutante

deadpool :: Mutante
deadpool = Mutante "Wade Wilson" 1000000 [] [pistola 9 , espada 16 , espada 16]

----- Auxiliares -------
mapNombre :: (String -> String) -> Mutante -> Mutante 
mapNombre unaFuncion unMutante = unMutante      { nombre      = unaFuncion . nombre $ unMutante }

mapVida :: (Int -> Int) -> Mutante -> Mutante 
mapVida unaFuncion unMutante = unMutante        { vida        = unaFuncion . vida $ unMutante   }

mapHabilidades :: ([Habilidad] -> [Habilidad]) -> Mutante -> Mutante
mapHabilidades unaFuncion unMutante = unMutante { habilidades = unaFuncion . habilidades $ unMutante }

mapArmas :: ([Arma]->[Arma]) -> Mutante -> Mutante 
mapArmas unaFuncion unMutante = unMutante       { armas        = unaFuncion armas $ unMutante }
----- Auxiliares -------

estaMuerto :: Mutante -> Bool
estaMuerto unMutante = vida unMutante == 0

esFrancis :: Mutante -> Bool
esFrancis unMutante = seLlama "Francis" unMutante

isMyDad :: Mutante -> Bool
isMyDad unMutante = seLlama "Coloso" unMutante || all esMetalica (habilidades unMutante)

seLlama :: String -> Mutante -> Bool
seLlama unNombre unMutante = nombre unMutante == unNombre

esMetalica :: Habilidad -> Bool
esMetalica unaHabilidad = (elem "metal" . words) unaHabilidad

----------------------------------

puño :: Arma
puño unMutante | tieneHabilidad "Esquivar Golpes" unMutante = unMutante
               | otherwise                                  = restarVida 5 unMutante

tieneHabilidad :: Habilidad -> Mutante -> Bool
tieneHabilidad unaHabilidad unMutante = elem unaHabilidad . habilidades $ unMutante

pistola :: Int -> Arma
pistola unCalibre unMutante = restarVida cuantoRestaLaPistola unMutante
    where cuantoRestaLaPistola = unCalibre * (length . habilidades) unMutante

restarVida :: Int -> Mutante -> Mutante
restarVida unaCantidad unMutante = mapVida (max 0 . subtract unaCantidad) unMutante

espada :: Int -> Arma
espada unaFuerza unMutante = restarVida (div unaFuerza 2) unMutante

-----------------------------------

abastecerse :: [Arma] -> Mutante -> Mutante
abastecerse unasArmas unMutante     
    | seLlama "Wade Wilson" = unMutante
    | otherwise             = mapArmas (++ unasArmas) unMutante

-----------------------------------

ataqueRapido :: Mutante -> Mutante -> Mutante 
ataqueRapido atacante atacado = ((head.armas) atacante) atacado


atacarConTodo :: Mutante -> Mutante -> Mutante
atacarConTodo atacante atacado = foldr ($) atacado (armas atacante)


todosAUno :: [Mutante] -> Mutante -> Mutante
todosAUno atacantes atacado = foldr atacarConTodo atacado atacantes


comoEstaSuFamilia :: [Mutante] -> Mutante -> [String]
comoEstaSuFamilia atacados atacante = (map nombre . filter (estaMuerto . ataqueRapido atacante)) atacados


rescatarASuChique :: Mutante -> [Mutante] -> [Mutante] -> _[Mutante]
rescatarASuChique atacante amigos enemigos =  (map (todosAUno amigos) . filter (not.estaMuerto) . map (ataqueRapido atacante)) enemigos

---------------------------------------------------------------------------------------
cualEsMiNombre :: (Mutante -> [b]) -> Int -> (Mutante -> a) -> ([Mutante] -> [b])
cualEsMiNombre x y z = concatMap fst . map (\n -> (x n, z n)) . filter ((y>).vida)
----------------------------------------------------------------------------------------

chuckNorris :: Mutante
chuckNorris = Mutante "Chuck" 1000000 ["Patada Giratoria"] (repeat puño)

-- Si, se puede debido a que solo toma el primer elemento de la lista de armas y lo ataca

-- No, nunca nos daria un resultado ya que atacarConTodo ataca con todas las armas de la lista, la cual es infinita ,por lo cual nunca dejaria de atacarlo.
