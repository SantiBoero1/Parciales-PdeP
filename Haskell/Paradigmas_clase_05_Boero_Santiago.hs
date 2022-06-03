type Libro = (String, String, Int)

type Saga = [Libro]

type Biblioteca = [Libro]


elVisitante :: Libro
elVisitante = ("Stephen King" , "El Visitante", 592)

punpun1:: Libro
punpun1 = ("Asano Inio" , "Oyasumi Punpun" , 40)

punpun3 :: Libro
punpun3 = ("Asano Inio" , "Oyasumi Punpun" , 40)

punpun127 :: Libro
punpun127 = ("Asano Inio" , "Oyasumi Punpun" , 40)

fundacion :: Libro
fundacion = ("Isaac Asimov" , "Fundacion", 230)

sandman5 :: Libro
sandman5 = ("Neil Gaiman" , "Sandman", 35)

sandman10 :: Libro
sandman10 = ("Neil Gaiman" , "Sandman", 35)

sandman12 :: Libro
sandman12 = ("Neil Gaiman" , "Sandman", 35)

eragon :: Libro
eragon = ("Christopher Paolini" , "Eragon" , 544)

eldest :: Libro
eldest = ("Christopher Paolini" , "Eldest" , 704)

brisignr :: Libro
brisignr = ("Christopher Paolini" , "Brisignr" , 700)

legado :: Libro
legado = ("Christopher Paolini" , "Legado" , 811)

sagaDeEragon :: Saga
sagaDeEragon = [eragon, eldest, brisignr, legado]

unaBiblioteca :: Biblioteca
unaBiblioteca = [elVisitante, punpun1, punpun3, punpun127, fundacion, sandman5, sandman10, sandman12, eragon, eldest, brisignr, legado]


--Funciones

--Nota de la funcion promedioDeHojas
--La diseñe para que el usuario ingrese una biblioteca especifica, con los titulos ya abarcados en el programa, y devuelva el promedio de dicha biblioteca
--Declare una funcion hojas para sacar el tercer elemento de la tupla

hojas :: Libro -> Int
hojas (_,_,c) = c 

tamañoDeLista :: [a] -> Int
tamañoDeLista lista = length lista

totalDehojas :: [Libro] -> Int
totalDehojas lista = (sum.(map hojas)) lista

promedioDehojas :: Biblioteca -> Int
promedioDehojas lista = div (totalDehojas lista) (tamañoDeLista lista)

-- Nota de la funcion lecturaObligatoria
-- Es requerimiento que los nombres que se ingresan comiencen con mayuscula
-- Declare una funcion titulo que hace lo mismo que snd pero para una tupla de 3 elementos

titulo :: Libro -> String
titulo (_,b,_) = b

perteneceALaSaga :: Saga -> [String]
perteneceALaSaga saga = map titulo saga

lecturaObligatoria :: String -> String
lecturaObligatoria nombre | nombre == titulo fundacion || nombre == titulo elVisitante || elem nombre (perteneceALaSaga sagaDeEragon) = "Lectura obligatoria!"
                          | otherwise = "Lectura no obligatoria"

-- Nota de la funcion fantasiosa
-- El usuario solo ingresa los titulos de los libros entre comillas como strings, no como las tuplas ya definidas
-- Es requerimiento que los Titulos de la lista que se ingresan comiencen con mayuscula
autor :: Libro -> String
autor (a,_,_) = a

perteneceAlAutor :: String -> Bool
perteneceAlAutor "Christopher Paolini" = True
perteneceAlAutor "Neil Gaiman" = True
perteneceAlAutor _ = False

fantasiosa :: Biblioteca -> Bool
fantasiosa biblioteca = any perteneceAlAutor (map autor biblioteca)


bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera biblioteca = all (<=40) (map hojas biblioteca)



noEsVocal :: Char -> Bool
noEsVocal 'a' = False
noEsVocal 'e' = False
noEsVocal 'i' = False
noEsVocal 'o' = False
noEsVocal 'u' = False
noEsVocal  _  = True

palabrasSinVocales :: String -> String
palabrasSinVocales palabra = filter noEsVocal palabra

elNombreDeLaBiblioteca :: Biblioteca -> String
elNombreDeLaBiblioteca biblioteca = concat (map palabrasSinVocales (map titulo biblioteca))
