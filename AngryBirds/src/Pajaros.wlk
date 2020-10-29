import Isla.*
import Eventos.*
import Obstaculos.*

class Pajaro{
	
	var ira
	
	method fuerza(){
		return ira * 2
	}
	
	method enojarse(){
		ira = ira * 2
	}
	
	method fuerzaMayorA50(){
		return self.fuerza() > 50
	}
	
	method disminuirIraEn(unaCantidad){
		ira -= unaCantidad
	}
	
	method enojarsePorInvasion(cantidadDeVecesQueSeEnoja){
		cantidadDeVecesQueSeEnoja.times({n => self.enojarse()})
	}
	
	method puedeDerribarObstaculo(unObstaculo){
		return self.fuerza() > unObstaculo.resistencia()
	}
	
	method enfrentarObstaculo(unaIsla){
		var obstaculoMasCercano = unaIsla.obstaculos().first()
		if(self.fuerza() > obstaculoMasCercano.resistencia()){
			unaIsla.obstaculos().remove(obstaculoMasCercano)
		}
	}
}

class PajaroRencoroso inherits Pajaro{
	var cantidadDeVecesEnojado = 0
	var property multiplicador
	
	override method fuerza(){
		
		return ira * multiplicador * cantidadDeVecesEnojado
	}
	
	override method enojarse(){
		cantidadDeVecesEnojado += 1
		super()
	}
	
}

class Red inherits PajaroRencoroso{
	
	override method fuerza(){
		return ira * 10 * cantidadDeVecesEnojado
	}
	
}

class Bomb inherits Pajaro{
	
	var topeMaximoDeFuerza = 9000
	
	override method fuerza(){
		return super().min(topeMaximoDeFuerza)
	}
}

class Chuck inherits Pajaro{
	
	var velocidad
	
	override method fuerza(){
		if(velocidad <= 80){
			return 150
		}
		else{
			return 150 + 5 * (velocidad - 80)
		}
		
	}
	
	override method enojarse(){
		velocidad *= 2
		super()
	}
	
	override method disminuirIraEn5(){
	}
}

class Terence inherits PajaroRencoroso{
	
}

class Matilda inherits Pajaro{
	var huevos = []
	
	override method fuerza(){
		return ira * 2 + self.fuerzaDeTodosLosHuevos()
	}
	
	
	override method enojarse(){
		huevos.add(new Huevo(peso = 2))
		super()
		
	}
	
	method fuerzaDeTodosLosHuevos(){
		return huevos.sum({huevo => huevo.fuerza()})
	}
}

class Huevo{
	var peso
	
	method fuerza(){
		return peso
	}
}