module TallerMecánico where
type Desgaste = Float
type Patente  = String
type Fecha = (Int,Int,Int)

anio :: Fecha -> Int
anio (_,_,year) = year

data Auto = Auto {
patente :: Patente,
desgasteLlantas :: [Desgaste],
rpm :: Int,
temperaturaAgua :: Int,
ultimoArreglo :: Fecha

}deriving (Show,Eq)


mapPatente :: ( Patente -> Patente ) -> Auto -> Auto
mapPatente funcion auto = auto { patente = funcion (patente auto) }

mapDesgasteLlantas :: ( [Desgaste] -> [Desgaste] ) -> Auto -> Auto
mapDesgasteLlantas funcion auto = auto {desgasteLlantas = funcion (desgasteLlantas auto)}

mapRpm :: ( Int -> Int ) -> Auto -> Auto 
mapRpm funcion auto = auto { rpm = funcion (rpm auto)}

mapTemperaturaAgua :: ( Int ->  Int ) -> Auto -> Auto
mapTemperaturaAgua funcion auto = auto {temperaturaAgua = funcion (temperaturaAgua auto)}


mapUltimoArreglo :: ( Fecha -> Fecha ) -> Auto -> Auto
mapUltimoArreglo funcion auto = auto {ultimoArreglo = funcion (ultimoArreglo auto)}

--objetos de prueba

auto1 = Auto {patente = "AT001LN" , desgasteLlantas = [0.50,0.1,0.6,0.4] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}
auto2 = Auto {patente = "DJV214"  , desgasteLlantas = [0.51,0.1,0.6,0.4] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2016)}
auto3 = Auto {patente = "DJV215"  , desgasteLlantas = [1,1,1,1] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,20)}
auto4 = Auto {patente = "DFH029"  , desgasteLlantas = [1,1,1,1] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,20)}



--Punto 1

calculoPatental patente | drop 5 patente == "4" = (length patente) * 3000
                        | otherwise = 20000

costoPatente :: Auto -> Int

costoPatente (Auto patente _ _ _ _) | length patente == 7 = 12500
                                                                              | take 2 patente ==  "DJ" = calculoPatental patente  
                                                                              | take 2 patente ==  "NB" = calculoPatental patente
                                                                              | otherwise = 15000

--Punto 2


esPeligroso :: Auto -> Bool

esPeligroso (Auto patente desgasteLlantas rpm temperaturaAgua ultimoArreglo) = head desgasteLlantas > 0.5


necesitaRevision :: Auto -> Bool
necesitaRevision (Auto patente desgasteLlantas rpm temperaturaAgua ultimoArreglo) = anio ultimoArreglo <= 2015



--Punto 3
type Mecanico = Auto -> Auto

alfa :: Mecanico
alfa auto | rpm auto >= 2000 = auto {rpm = 2000} 
          | otherwise   = auto

bravo :: Mecanico
bravo auto = auto {desgasteLlantas = [0,0,0,0]} 

charly :: Mecanico
charly = alfa.bravo

tango :: Mecanico
tango auto = auto  

zulu :: Mecanico
zulu auto = lima (auto {rpm = 90})

lima :: Mecanico
lima (Auto patente [primera,segunda,tercera,cuarta] rpm temperaturaAgua ultimoArreglo) = (Auto patente [0,0,tercera,cuarta] rpm temperaturaAgua ultimoArreglo)


 

-- Punto 4

-- Objetos de prueba


auto5 = Auto {patente = "AT005YW" , desgasteLlantas = [0.1, 0.4, 0.2, 0] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}
auto6 = Auto {patente = "AT015SJ" , desgasteLlantas = [0.2, 0.5, 0.6, 0.1] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}
auto7 = Auto {patente = "AT038LM" , desgasteLlantas = [0.1, 0.1, 0.1, 0] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}
auto8 = Auto {patente = "AT153LN" , desgasteLlantas = [0.3, 0.5, 0.6, 0.1] , rpm = 1200 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}
auto9 = Auto {patente = "AT005YW" , desgasteLlantas = [0.1, 0.4, 0.2, 0.1] , rpm = 2500 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}


ordenadoSegunTOC :: [Auto] -> Bool
ordenadoSegunTOC listaDeAutos = foldl1 (||) (verificacionDeCriterio listaDeAutos)

cantidadDeDesgasteImpar :: Auto -> Bool
cantidadDeDesgasteImpar = (not . even . round . (*10) . sum . desgasteLlantas)

cantidadDeDesgastePar   :: Auto -> Bool
cantidadDeDesgastePar   = (even . round . (*10) . sum . desgasteLlantas)

verificacionDeCriterio :: [Auto] -> [Bool]
verificacionDeCriterio    []     = [] 
verificacionDeCriterio  (autoImpar:[])   = [ cantidadDeDesgasteImpar autoImpar ]
verificacionDeCriterio (autoImpar : autoPar : colaDeAutos)  = [ cantidadDeDesgasteImpar autoImpar , cantidadDeDesgastePar autoPar ] ++ verificacionDeCriterio colaDeAutos 




--punto 5

ordenDeReparacion :: Fecha -> [Mecanico] -> Auto -> Auto
ordenDeReparacion fecha listaDeMecanicos auto = mapUltimoArreglo (const fecha) (repararAuto auto listaDeMecanicos) 

repararAuto :: Auto -> [Mecanico] -> Auto
repararAuto auto listaDeMecanicos = foldr ($) auto listaDeMecanicos


--punto 6, parte 1

auto10 = Auto {patente = "AT005YW" , desgasteLlantas = [0.6, 0.4, 0.2, 0.1] , rpm = 2500 , temperaturaAgua = 10 , ultimoArreglo = (1,1,2015)}


mecanicosQueTeLoDejanJoya :: Auto -> [Mecanico] -> Int 
mecanicosQueTeLoDejanJoya auto unosMecanicos = (cuantosEstanJoya.noPeligran.reparacion auto) unosMecanicos 

reparacion :: Auto -> [Mecanico] -> [Auto]  
reparacion auto listaDeMecanicos = map ($auto) listaDeMecanicos

noPeligran :: [Auto] -> [Bool]
noPeligran unosAutos = filter (==True) (map (not.esPeligroso) unosAutos)

cuantosEstanJoya :: [Bool] -> Int
cuantosEstanJoya lista = length lista

-- parte 2

costoDeReparacion :: [Auto] -> Int
costoDeReparacion unosAutos =  (sum . costoDeCadaUno . revision) unosAutos

revision :: [Auto] -> [Auto]
revision unosAutos = filter necesitaRevision unosAutos

costoDeCadaUno :: [Auto] -> [Int]
costoDeCadaUno autosSinRevision = map costoPatente autosSinRevision

--punto 7 

--parte 1

{- No, ya que a la hora de intentar analizar si algun elemento x de la lista cumple, este nunca saldra del loop ya que para analizar
la lista, esta debera estar cargada para aplicarse el map y el filter.
Si me dijese "Tomar el primer elemento y ver si cumple" si seria posible, ya que no requiere de toda la lista, pero en nuestro caso
estaria analizando a los elementos de toda la lista




}
