import Casas.*
import Acompaniantes.*

class Personaje{
	
	var casa
	const conyuges = #{}
	var estaVivo = true
	var acompaniantes = []
	
	method noEstaCasado(){
		return conyuges.isEmpty()
	}
	
	method noEsStark(){
		return casa != stark
	}
	
	// - Punto 2A - //
	
	method puedenCasarse(unaPersona){
		return self.lePermitenCasarseCon(unaPersona) && unaPersona.lePermitenCasarseCon(self)
	}
	
	method lePermitenCasarseCon(unaPersona){
		return casa.puedeCasarseCon(self,unaPersona)
	}
	
	// - Punto 3A - //
	
	method realizarCasamiento(unaPersona){
		self.validarCasamiento(unaPersona)
		self.aniadirConyuge(unaPersona)
		unaPersona.aniadirConyuge(self)
	}
	
	method validarCasamiento(unaPersona){
		if(!self.puedenCasarse(unaPersona)){
			throw new Exception(message = "No pudieron casarse")
		}
	}
	
	method aniadirConyuge(unaPersona){
		conyuges.add(unaPersona)
	}
	
	// - Punto 5A - //
	
	method patrimonio(){
		return casa.patrimonioIndividual()
	}
	
	
	// - Punto 1B - //
	method estaSolo(){
		return acompaniantes.isEmpty()
	}
	
	// - Punto 2B - // 
	
	method aliados(){
		return acompaniantes + conyuges + casa.miembros()
	}
	
	// - Punto 3B - //
	
	method esPeligroso(){
		return estaVivo && (self.poseeAliadosAdinerados() || self.conyugesSonRicos() || self.poseeAlianzaPeligrosa())
	}
	
	method poseeAliadosAdinerados(){
		return self.aliados().sum({aliado => aliado.patrimonio()}) >= 10000
	}
	
	method conyugesSonRicos(){
		return conyuges.map({conyuge => conyuge.esDeCasaRica()})
	}
	
	method esDeCasaRica(){
		return casa.esRica()
	}
	
	method poseeAlianzaPeligrosa(){
		return self.aliados().any({aliado => aliado.esPeligroso()})
	}
}