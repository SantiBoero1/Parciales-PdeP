class Casta{
	
	method puedeIr(){
		return true
	}
}

object jarl inherits Casta{
	
	override method puedeIr(unVikingo,unaExpedicion){
		return !unVikingo.tieneArmas()
	}
}