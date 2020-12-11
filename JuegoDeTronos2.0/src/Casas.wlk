import Personajes.*

class Casa{
	
	var patrimonio
	var ciudad
	const miembros = #{}
	
	method puedeCasarseCon(unMiembro,otraPersona)
	
	// - Punto 4 - //
	
	method esRica(){
		return patrimonio > 1000
	}
	
	// - Punto 5 - //
	
	method patrimonioIndividual(){
		return patrimonio / miembros.size()
	}
	
}

object lannister inherits Casa{
	
	override method puedeCasarseCon(unMiembro,otraPersona){
		return unMiembro.noEstaCasado()
	}
	
}

object stark inherits Casa{
	
	override method puedeCasarseCon(unMiembro,otraPersona){
		return otraPersona.noEsStark()
	}
}

object guardia inherits Casa{
	
	override method puedeCasarseCon(unMiembro,otraPersona){
		return false
	}
}
