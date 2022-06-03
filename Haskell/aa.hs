cuantoLePuedeDar :: Auto -> Auto -> Int
cuantoLePuedeDar (Auto x y z) (Auto a b c) = min (nivelNafta (Auto x y z)) (tamanioTanque (Auto a b c) - nivelNafta (Auto a b c))


transferir :: Auto -> Auto -> (Auto, Auto)
transferir (Auto x y z) (Auto a b c) = ((Auto x (y - (cuantoLePuedeDar (Auto x y z) (Auto a b c))) z), (Auto a (b + (cuantoLePuedeDar (Auto x y z) (Auto a b c))) c))




cuantoLePuedeDar :: Auto -> Auto -> Int
cuantoLePuedeDar (Auto patente1 nafta1 tanque1) (Auto patente2 nafta2 tanque2) = min (nivelNafta (Auto patente1 nafta1 tanque1)) (tamanioTanque (Auto patente2 nafta2 tanque2) - nivelNafta (Auto patente2 nafta2 tanque2))

transferir :: Auto -> Auto -> (Auto,Auto)
transferir (Auto patente1 nafta1 tanque1) (Auto patente2 nafta2 tanque2) = ((Auto patente1 (nafta1 - (cuantoLePuedeDar (Auto patente1 nafta1 tanque1) (Auto patente2 nafta2 tanque2))) tanque1), (Auto patente2 (nafta2 + (cuantoLePuedeDar (Auto patente1 nafta1 tanque1) (Auto patente2 nafta2 tanque2))) tanque2))