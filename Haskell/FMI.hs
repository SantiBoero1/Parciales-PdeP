data Pais = Pais {
    ingresoPerCapita :: Int,
    poblacionActivaPublico :: Int,
    poblacionActivaPrivado :: Int,
    recursos :: [String],
    deuda :: Int
} deriving Show

cambiarIngresoPerCapita :: (Int -> Int) -> Pais -> Pais
cambiarIngresoPerCapita unaFuncion unPais = unPais {ingresoPerCapita = unaFuncion (ingresoPerCapita unPais)}

cambiarPoblacionActivaPublico :: (Int -> Int) -> Pais -> Pais
cambiarPoblacionActivaPublico unaFuncion unPais = unPais { poblacionActivaPublico = unaFuncion (poblacionActivaPublico unPais)}

cambiarPoblacionActivaPrivado :: (Int -> Int) -> Pais -> Pais
cambiarPoblacionActivaPrivado unaFuncion unPais = unPais { poblacionActivaPrivado = unaFuncion (poblacionActivaPrivado unPais)}

cambiarRecursos :: ([String] -> [String]) -> Pais -> Pais
cambiarRecursos unaFuncion unPais = unPais { recursos = unaFuncion (recursos unPais)}

cambiarDeuda :: (Int -> Int) -> Pais -> Pais
cambiarDeuda unaFuncion unPais = unPais { deuda = unaFuncion (deuda unPais)}

argentina = Pais 1000 150 1000 ["Tierra", "Mar", "Soja"] 10000000
namibia = Pais 4140 400000 650000 ["Mineria" , "Ecoturismo"] 50000000
españa = Pais 1000 150 1000 ["Petroleo", "Tierra" ,"Carne"] 10000000
francia = Pais 1000 150 1000 ["Pan", "Petroleo", "Mar"] 10000000
--------------------------------------------------------------------------------------------------------

prestar :: Int -> Pais -> Pais
prestar millones unPais = cambiarDeuda (const porcentajeDePrestamo millones) unPais

porcentajeDePrestamo :: Int -> Int
porcentajeDePrestamo millones = div (150 * millones * 1000000) 100

reducirPuestoDeTrabajo :: Int -> Pais -> Pais
reducirPuestoDeTrabajo puestos unPais = (reduccionDeActivos puestos . cambiarPoblacionActivaPublico (subtract puestos)) unPais

reduccionDeActivos :: Int -> Pais -> Pais
reduccionDeActivos puestos unPais 
    | puestos > 100 = cambiarIngresoPerCapita (subtract ( porcentajeDeActivos 20 unPais)) unPais
    | otherwise = cambiarIngresoPerCapita (subtract (porcentajeDeActivos 15 unPais)) unPais

porcentajeDeActivos :: Int -> Pais -> Int
porcentajeDeActivos porcentual unPais = div (ingresoPerCapita unPais * porcentual) 100

sacarRecurso :: String -> Pais -> Pais
sacarRecurso recurso unPais = (cambiarRecursos (quitarRecursoDeLista recurso) . cambiarDeuda (subtract 2000000)) unPais

quitarRecursoDeLista :: String -> [String] -> [String]
quitarRecursoDeLista recurso listaDeRecursos = filter (/= recurso) listaDeRecursos

blindaje :: Pais -> Pais
blindaje unPais = (cambiarPoblacionActivaPublico (subtract 500) . cambiarDeuda (+ productoBrutoInterno unPais)) unPais

productoBrutoInterno :: Pais -> Int
productoBrutoInterno unPais = ingresoPerCapita unPais * (poblacionActivaPublico unPais + poblacionActivaPrivado unPais)

----------------------------------------------------------

prestamoConInteres :: Pais -> Pais
prestamoConInteres unPais = (sacarRecurso "Mineria" . prestar 200) unPais

-----------------------------------------------------------

zafan :: [Pais] -> [Pais]
zafan listaDePaises = filter (\x -> elem "Petroleo" (recursos x) ) listaDePaises

aFavorDelFMI :: [Pais] -> Int
aFavorDelFMI listaDePaises = sum (map deuda listaDePaises)

----------------------------------------------------------

ordenadasDePeorAMejor :: Pais -> [(Pais -> Pais)] -> Bool
ordenadasDePeorAMejor unPais [] = False
ordenadasDePeorAMejor unPais (x:[]) = True
ordenadasDePeorAMejor unPais (x:y:xs) = productoBrutoInterno (x unPais) < productoBrutoInterno (y unPais) && ordenadasDePeorAMejor unPais (y:xs)

------------------------------------------------------------



