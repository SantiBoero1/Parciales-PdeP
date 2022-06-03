import Text.Show.Functions

onomatopeya :: Grito -> String
onomatopeya (grito,_,_) = grito

intensidad :: Grito -> Int
intensidad (_,nivel,_) = nivel

mojoLaCama :: Grito -> Bool
mojoLaCama (_,_,booleano) = booleano
type Grito = (String,Int,Bool)


obtenerEnergia :: Grito -> Int
obtenerEnergia unGrito 
    | mojoLaCama unGrito = length (onomatopeya unGrito) * ((intensidad unGrito) ^ 2)
    | otherwise  = length (onomatopeya unGrito) * 3 + intensidad unGrito


--------------------------------------------------------------------

type Monstruo = Niño -> Grito

type Niño = (String,Int,Int)

sullivan :: Monstruo
sullivan unNiño =  (cuantasLetrasTieneElNombre unNiño)

cuantasLetrasTieneElNombre :: Niño -> Int
cuantasLetrasTieneElNombre (nombre,_,_) = length nombre