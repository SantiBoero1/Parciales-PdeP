import Armas.*

class Piramide {
	
	var altura
	
	method condicionDeRobo(unMinion){
		return unMinion.nivelDeConcentracion() >= altura / 2
	}
	
	method premiarPorRobo(unosMinions){
		unosMinions.forEach({minion => minion.obtenerBananas(10)})
	}
}

object sueroMutante{
	
	method condicionDeRobo(unMinion){
		return unMinion.estaBienAlimentado() && unMinion.nivelDeConcentracion() >= 23
	}
	
	method premiarPorRobo(unosMinions){
		unosMinions.forEach({minion => minion.absorcionSueroMutante()})
	}
}

object laLuna{
	
	method condicionDeRobo(unMinion){
		return unMinion.poseeRayoEncogedor()
	}
	
	method premiarPorRobo(unosMinions){
		unosMinions.forEach({minion => minion.aniadirArma(new Arma(nombre = "Rayo Congelante",potencia = 10))})
	}
}
