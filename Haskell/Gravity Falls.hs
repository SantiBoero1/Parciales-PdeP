import Text.Show.Functions

data Criatura = Criatura {
    peligrosidad :: Int,
    requisito :: Requisito
} deriving Show

type Requisito = Persona -> Bool

data Persona = Persona {
    edad :: Int,
    items :: [String],
    experiencia :: Int
} deriving Show

cambiarPeligrosidad :: (Int -> Int) -> Criatura -> Criatura
cambiarPeligrosidad unaFuncion unaCriatura = unaCriatura { peligrosidad = unaFuncion (peligrosidad unaCriatura)}

cambiarRequisito :: (Requisito -> Requisito) -> Criatura -> Criatura
cambiarRequisito unaFuncion unaCriatura = unaCriatura { requisito = unaFuncion (requisito unaCriatura)}

cambiarEdad :: (Int -> Int) -> Persona -> Persona
cambiarEdad unaFuncion unaPersona = unaPersona { edad = unaFuncion (edad unaPersona)}

cambiarItems :: ([String] -> [String]) -> Persona -> Persona
cambiarItems unaFuncion unaPersona = unaPersona { items = unaFuncion (items unaPersona)}

cambiarExperiencia :: (Int -> Int) -> Persona -> Persona
cambiarExperiencia unaFuncion unaPersona = unaPersona { experiencia = unaFuncion (experiencia unaPersona)}

-----------------------------------------------------------------------------------

experienciaEnfrentamiento :: Persona -> Criatura -> Int
experienciaEnfrentamiento unaPersona unaCriatura 
    | (requisito unaCriatura) unaPersona = peligrosidad unaCriatura
    | otherwise = 1

enfrentamiento :: Persona -> Criatura -> Persona
enfrentamiento unaPersona unaCriatura = cambiarExperiencia (+ experienciaEnfrentamiento unaPersona unaCriatura) unaPersona

cuantaExpGana :: Persona -> [Criatura] -> Int
cuantaExpGana unaPersona unasCriaturas = (sum . map (experienciaEnfrentamiento unaPersona)) unasCriaturas



siempreDetras :: Criatura
siempreDetras = Criatura 0 nada

nada :: Requisito
nada unaPersona = False

gnomo :: Int -> Criatura
gnomo cantidadGnomos = Criatura (2^cantidadGnomos) sopladorDeHojas

sopladorDeHojas :: Requisito
sopladorDeHojas unaPersona = elem ("Soplador de hojas") (items unaPersona)

fantasma3 :: Criatura
fantasma3 = Criatura (3*20) condicionCategoria3

condicionCategoria3 :: Requisito
condicionCategoria3 unaPersona = (edad unaPersona < 13)

fantasma1 :: Criatura
fantasma1  = Criatura (1*20) condicionCategoria1

condicionCategoria1 :: Requisito
condicionCategoria1 unaPersona = (experiencia unaPersona > 10)

santax01 = Persona 12 ["Soplador de hojas"] 0












------------------------------------------------------------------------------------------------------------

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b] 
zipWithIf funcion1 funcion2 (cabezaLista1) [] = []
zipWithIf funcion1 funcion2 (cabezaLista1:colaLista1) (cabezaLista2:colaLista2)      | funcion2 cabezaLista2 = funcion1 cabezaLista1 cabezaLista2 : zipWithIf funcion1 funcion2 colaLista1 colaLista2
                                                                                     | otherwise = cabezaLista2 : zipWithIf funcion1 funcion2 (cabezaLista1:colaLista1) colaLista2
 


-------------------------------------------------------------------------------------------------------------

--abecedarioDesde :: Char -> [Char]
--abecedarioDesde caracter =  caracter : ['a' .. caracter]

--devolverLosSiguientes :: Char -> [Char]
--devolverLosSiguientes caracter = ['caracter' ..  ]