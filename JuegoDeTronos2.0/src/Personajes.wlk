import Casas.*

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
	
	// - Punto 2 - //
	
	method puedenCasarse(unaPersona){
		return self.lePermitenCasarseCon(unaPersona) && unaPersona.lePermitenCasarseCon(self)
	}
	
	method lePermitenCasarseCon(unaPersona){
		return casa.puedeCasarseCon(self,unaPersona)
	}
	
	// - Punto 3 - //
	
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
	
	// - Punto 5 - //
	
	method patrimonio(){
		return casa.patrimonioIndividual()
	}
}