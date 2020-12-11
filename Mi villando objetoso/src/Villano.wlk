import Minions.*

class Villano{
	
	const minions = []
	var ciudad
	
	// - Punto 1A - //
	method nuevoMinion(){
		minions.add(new Minion(bananas = 5, armas = [new Arma(nombre = "Rayo Congelante",potencia = 10)],color = amarillo))
	}
	
	// - Punto 1B - //
	
	method otorgarArma(unArma,unMinion){
		unMinion.aniadirArma(unArma)
	}
	
	// - Punto 1C - //
	
	method alimentar(unasBananas,unMinion){
		unMinion.obtenerBananas(unasBananas)
	}
	
	// - Punto 2 - //
	
	method planificarMaldad(unaMaldad){
		unaMaldad.seleccionarMinionsAptos(minions)
		unaMaldad.realizarseEn(ciudad)
	}
	
	// - Punto 3A - //
	
	method minionMasUtil(){
		return minions.max({minion => minion.cantMaldadesHechas()})
	}
	
	// - Punto 3B - //
	
	method minionsInutiles(){
		return minions.filter({minion => minion.noRealizoMaldades()})
	}
}

class Ciudad{
	
	var temperatura
	const cosas = []
	
	method reducirTemperatura(unaCantidad){
		temperatura -= unaCantidad
	}
	
	method perderCosa(unaCosa){
		cosas.remove(unaCosa)
	}
}