import Personajes.*

class Casa{
	
	var patrimonio
	var ciudad
	const miembros = #{}
	
	method puedeCasarseCon(unMiembro,otraPersona)
	
	// - Punto 4A - //
	
	method esRica(){
		return patrimonio > 1000
	}
	
	// - Punto 5A - //
	
	method patrimonioIndividual(){
		return patrimonio / miembros.size()
	}
	
	// - Punto 2B - //
	
	method miembros(){
		return miembros
	}	
	
	// - Punto C - //
	
	method miembroVivoYSoltero(){
		return self.miembrosVivos().miembrosSolteros().anyOne()
	}
	
	method miembrosVivos(){
		return miembros.filter({miembro => miembro.estaVivo()})
	}
	
	method miembrosSolteros(){
		return miembros.filter({miembro => miembro.noEstaCasado()})
	}
	
	method perderPatrimonio(unPorcentaje){
		patrimonio = patrimonio - (patrimonio * 10 / 100)
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
