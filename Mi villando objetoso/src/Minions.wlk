class Minion {
	
	var bananas
	const armas = []
	var color = amarillo
	var cantDeMaldadesHechas = 0
	
	// - Punto 1E - //
	method esPeligroso(){
		return armas.size() > 2
	}
	
	method absorcionSueroMutante(){
		color.absorcionSueroMutante()
	}
	
	
	// - Punto 1D - //
	method nivelDeConcentracion(){
		return color.nivelDeConcentracion()
	}
	
	// - Punto 1B - //
	method aniadirArma(unArma){
		armas.add(unArma)
	}
	
	// - Punto 1C - // 
	
	method obtenerBananas(unasBananas){
		bananas += unasBananas
	}
	
	
	// - Punto 2 - //

	method estaBienAlimentado(){
		return bananas >= 100 
	}
	
	method poseeRayoEncogedor(){
		return armas.contains(rayoEncogedor)
	}
	
	method sumarMaldad(){
		cantDeMaldadesHechas += 1
	}
	
	// - Punto 3 - // 
	method cantMaldadesHechas(){
		return cantDeMaldadesHechas
	}
	
	method noRealizoMaldades(){
		return cantDeMaldadesHechas == 0
	}
}

object violeta inherits Minion{
	
	override method absorcionSueroMutante(){
		color = amarillo
		bananas--
	}
	
	override method nivelDeConcentracion(){
		return bananas
	}
	
}

object amarillo inherits Minion{
	
	override method absorcionSueroMutante(){
		color = violeta
		armas.removeAll()
		bananas--
	}
	
	override method nivelDeConcentracion(){
		return self.armaConMayorPotencia() + bananas
	}
	
	method armaConMayorPotencia(){
		return armas.max({arma => arma.potencia()}).potencia()
	}
}