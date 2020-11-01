import Vikingos.*
import Expediciones.*
import Lugares.*

class Casta{
	method puedeIrA(unVikingo,unaExpedicion){
		return true
	}
	
	
}

object jarl inherits Casta{
	
	override method puedeIrA(unVikingo,unaExpedicion){
		return !unVikingo.tieneArmas()
	}
	
	method ascender(unVikingo){
		unVikingo.castaSocial(karl)
		unVikingo.bonificarAscenso()
	}
}

object karl inherits Casta{
	
	method ascender(unVikingo){
		unVikingo.castaSocial(thrall)
	}

}

object thrall inherits Casta{
	
	
}
