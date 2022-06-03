absoluto :: (Num a, Ord a) => a -> a
absoluto num | num>0 = num
             | otherwise = - num


fibonacci :: Int -> Int
fibonacci num |num==0 = 0 
              |num==1 = 1  
              |otherwise = fibonacci (num-1) + fibonacci (num-2)


maximoSegun :: Ord y => (x -> y) -> x -> x -> x
maximoSegun fun parametro1 parametro2 |fun parametro1 > fun parametro2 = parametro1
                                      |otherwise = parametro2
             
discriminante :: Num a => a -> a -> a -> a
discriminante a b c = (b^2)-(4*a*c)

tipoDeRaices :: (Num a, Ord a) => a -> a -> a -> String
tipoDeRaices a b c |discriminante a b c > 0 = "Raices reales"
                   |discriminante a b c == 0 = "Raiz doble"
                   |otherwise = "Raices Imaginarias"



fibo :: Int -> Int
fibo 0 = 0
fibo 1 = 1
fibo num = fibo (num-1) + fibo (num-2)


disyuncion :: Bool -> Bool -> Bool
disyuncion False False = False
disyuncion _ _ = True

disyuncionExclusiva :: Bool -> Bool -> Bool
disyuncionExclusiva True False = True
disyuncionExclusiva False True = True
disyuncionExclusiva _ _ = False


conjuncion :: Bool -> Bool -> Bool
conjuncion True True = True
conjuncion _ _ = False 


esVacia :: [a] -> Bool
esVacia [] = True
esVacia _ = False


tieneDosElementos :: [a] -> Bool
tieneDosElementos [a,b] = True
tieneDosElementos _ = False


tieneAlMenosDosElementos :: [a] -> Bool
tieneAlMenosDosElementos (x:y:ys) = True
tieneAlMenosDosElementos _ = False


esCreciente :: Ord a => [a] -> Bool
esCreciente [] = True
esCreciente [a] = True
esCreciente (x:y:xs) = x < y && esCreciente (y:xs)


