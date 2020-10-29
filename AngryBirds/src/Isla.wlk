import Pajaros.*
import Eventos.*

object islaPajaro{
	var pajaros = []
	 
	/*method obtenerFuerza(unPajaro){
		return unPajaro.fuerza()
	}
	
	method hacerEnojar(unPajaro){
		unPajaro.enojarse()
	}*/
	
	method pajarosFuertes(){
		return pajaros.filter({pajaro => pajaro.fuerzaMayorA50()})
	}
	
	method fuerzaDeLaIsla(){
		return self.pajarosFuertes().sum({pajaro => pajaro.fuerza()})
	}
	
	method sucederEvento(evento){
		evento.suceder(pajaros)
	}
	
	method atacarA(unaIsla){
		pajaros.forEach({pajaro => pajaro.enfrentarObstaculoDe(unaIsla)})
	}
	
	method seRecuperaronLosHuevos(unaIsla){
		
		return unaIsla.obstaculos().isEmpty()
	}
}