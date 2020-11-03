class Guerrero{
	var potencial
	var experiencia
	var energiaInicial
	var energiaActual
	var estaMuerto
	var traje
	
	
	method atacarA(unGuerrero){
		unGuerrero.disminuirEnergia(potencial)
		unGuerrero.aumentarExperienciaEn(1)
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
	
}