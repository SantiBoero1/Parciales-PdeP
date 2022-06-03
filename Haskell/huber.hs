import Text.Show.Functions

data Chofer = Chofer {
    nombreChofer :: String, 
    kilometraje :: Int,
    viajes :: [Viaje],
    condicion :: Condicion
} deriving Show

data Cliente = Cliente {
    nombreCliente :: String,
    localidad :: String
} deriving Show

data Viaje = Viaje {
    fecha :: Fecha,
    cliente :: Cliente,
    costo :: Int
} deriving Show

type Condicion = Viaje -> Bool

type Fecha = (Int,Int,Int)

mapViajes :: ([Viaje] -> [Viaje]) -> Chofer -> Chofer
mapViajes unaFuncion unChofer = unChofer { viajes = unaFuncion (viajes unChofer)}


tomaCualquiera :: Condicion
tomaCualquiera unViaje = True

saleMasDe200 :: Condicion
saleMasDe200 unViaje = costo unViaje > 200

nombreDeNLetras :: Int -> Condicion
nombreDeNLetras cantidadDeLetras unViaje = ((>cantidadDeLetras) . length . nombreCliente . cliente) unViaje

noViveEn :: String -> Condicion
noViveEn lugar unViaje = ((/= lugar) . localidad . cliente) unViaje

lucas = Cliente "Lucas" "Victoria"

daniel = Chofer "Daniel" 23500 [viajeDanielLucas] (noViveEn "Olivos")

alejandra = Chofer "Alejandra" 180000 [] tomaCualquiera

viajeDanielLucas = Viaje (20,4,2017) lucas 150

viajePapa = Viaje (20,4,2017) papa 150
papa = Cliente "Papa" "Olivos"

noDisponible = Chofer "No hay chofer disponible" 0 [] tomaCualquiera



puedeTomarElViaje :: Viaje -> Chofer -> Bool
puedeTomarElViaje unViaje unChofer  = (condicion unChofer) unViaje


liquidacion :: Chofer -> Int
liquidacion unChofer = (sum . map costo) (viajes unChofer)




realizarUnViaje :: Viaje -> [Chofer] -> Chofer
realizarUnViaje unViaje unosChoferes = (mapViajes (unViaje:) . cualTieneMenosViajes . filter (puedeTomarElViaje unViaje)) unosChoferes

cualTieneMenosViajes :: [Chofer] -> Chofer
cualTieneMenosViajes (chofer1:[]) = chofer1
cualTieneMenosViajes (chofer1 : chofer2 : choferes) 
    | cantidadDeViajes chofer1 < cantidadDeViajes chofer2 = cualTieneMenosViajes (chofer1:choferes)
    | otherwise = cualTieneMenosViajes (chofer2 : choferes)


cantidadDeViajes :: Chofer -> Int
cantidadDeViajes unChofer = length (viajes unChofer)


---------------------------------------
viajeInfinitoLucas = Viaje (11,3,2017) lucas 50

repetirViaje unViaje = unViaje : repetirViaje unViaje

nito infy = Chofer "Nito infy" 70000 (repetirViaje viajeInfinitoLucas) (nombreDeNLetras 3)

{-
b) No, no puede calcular la liquidacion de Nito ya que posee infinitos viajes de 50 de costo cada uno, por lo cual la lista de costos nunca finalizaria y nunca devolveria un resultado

c) Si puede ya que para saber eso solo se requiere la condicion de Nito, no involucra a la lista infinita, por lo cual no habria problema alguno en utilizar ese dato
-}

----------------------------------------
gongNeng :: Int -> (Int -> Bool) -> (a -> Int) -> [a] -> Int
gongNeng arg1 arg2 arg3 =  max arg1 . head . filter arg2 . map arg3
