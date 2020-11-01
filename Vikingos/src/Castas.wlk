import Vikingos.*
import Expediciones.*

class Casta{
	method puedeIrA(unVikingo,unaExpedicion){
		return true
	}
}

class Jarl inherits Casta{
	
	override method puedeIrA(unVikingo,unaExpedicion){
		return !unVikingo.tieneArmas()
	}
}

class Karl inherits Casta{
	

}

class Thrall inherits Casta{
	
	
}
