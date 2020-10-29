import Pajaros.*
import Isla.*

object sesionDeManejoDeLaIra {
	
	method suceder(unosPajaros){
		unosPajaros.forEach({pajaro => pajaro.disminuirIraEn(5)})
	}
}

class InvasionDeCerditos {
	var cerditosQueInvaden
	
	method suceder(unosPajaros){
		var cantidadDeVecesQueSeEnoja = cerditosQueInvaden.div(100) 
		unosPajaros.forEach({pajaro => pajaro.enojarsePorInvasion(cantidadDeVecesQueSeEnoja)})
	}
}

 class FiestaSorpresa{
	var homenajeados = []
	
	method suceder(unosPajaros){
		homenajeados.forEach({unPajaro => unPajaro.enojarse()})
	}
	
}

object serieDeEventosDesafortunados{
	/*Se me ocurrio primeramente esta solucion, pero no creo que sea la correcta, ya que no se si toma a los mismo pajaros
	 * que ya fueron modificados por un evento anterior. Por ejemplo, el primer evento modifica unos pajaros, pero no se
	 * si el segundo evento va a tomar a esos pajaros modificados, yo creo que no
	 */
	
	var eventos = []
	
	method suceder(unosPajaros){
		eventos.forEach({evento => evento.suceder(unosPajaros)})
	}
}