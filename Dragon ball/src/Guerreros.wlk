class Guerrero{
	var potencial
	var experiencia
	var energiaInicial
	var energiaActual
	var traje
	
	
	method atacarA(unGuerrero){
		unGuerrero.disminuirEnergia(potencial)
		self.aumentarExperienciaEn(1)
		unGuerrero.seDesgastaSuTraje()
	}
	
	method aumentarExperienciaEn(unaCantidad){
		experiencia += unaCantidad * traje.multiplicadorDeExperiencia(unaCantidad)
	}
	
	method comerSemillaDelErmitanio(){
		energiaActual = energiaInicial
	}
	
	method disminuirEnergia(unPotencial){
		energiaActual = energiaInicial - (unPotencial * 0.1 - traje.disminuirDanio()) 
	}
	
	method seDesgastaSuTraje(){
		traje.desgastarse()
	}
	
	method estaGastado(){
		return traje.estaGastado()
	}
	
	method potencial(){
		return potencial
	}
	
	method cantidadDeElementosDeSuTraje(){
		return traje.cantidadDePiezas()
	}
}

class SuperSaiyan inherits Guerrero{
	const esSaiyan
	var esSuperSaiyan
	
	method convertirseEnSuperSaiyan(nivel){
		if(esSaiyan){
			self.aumentarAtaque()
			self.aumentarResistencia(nivel)
		}
	}
		
	method aumentarAtaque(){
		potencial = potencial * 0.5
	}
	
	method aumentarResistencia(unNivel){
		if(unNivel == 1){
			energiaActual = energiaActual + (energiaActual * 5 / 100)
		}
		else if (unNivel == 2){
			energiaActual = energiaActual + (energiaActual * 7 / 100)
		}
		else if(unNivel == 3){
			energiaActual = energiaActual + (energiaActual * 15 / 100)
		}
	}
	
	// Deberia sacarle las estadisticas que se aumentaron cuando vuelve a su fase original?
	
	override method comerSemillaDelErmitanio(){
		potencial = potencial * 5 / 100
	}
}