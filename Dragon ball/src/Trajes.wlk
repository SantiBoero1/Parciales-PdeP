class Traje{
	var nivelDeDesgaste = 0
	
	method disminuirDanio()
	method multiplicadorDeExperiencia(unaCantidad)
	
	method desgastarse(){
		nivelDeDesgaste += 5.min(100)
	}
	
	method estaGastado(){
		return nivelDeDesgaste == 100
	}
	
}

class Comun inherits Traje{
	var proteccion
	
	override method disminuirDanio(){
		if(!self.estaGastado()){
			return proteccion
		} else return 0
	}
	
	override method multiplicadorDeExperiencia(unaCantidad){
		return 1
	}
	
}

class Entrenamiento inherits Traje{
	var porcentajeDeExperiencia
	
	override method disminuirDanio(){
		return 0
	}
	
	override method multiplicadorDeExperiencia(unaCantidad){
		if(!self.estaGastado()){
			return porcentajeDeExperiencia * unaCantidad / 100
		} else return 1
	}
}

class Modular inherits Traje{
	var piezas = []
	
	override method disminuirDanio(){
		if(!self.estaGastado()){
			return piezas.filter({pieza => !pieza.estaGastada()}).sum({pieza => pieza.porcentajeDeResistencia()})
		} else return 0
	}
	
	override method multiplicadorDeExperiencia(unaCantidad){
		return (self.cantidadDePiezas() - self.cantidadDePiezasGastadas()) * self.cantidadDePiezas() / 100
	}
	
	override method estaGastado(){
		return piezas.all({pieza => pieza.estaGastada()})
	}
	
	method cantidadDePiezas(){
		return piezas.size()
	}
	
	method cantidadDePiezasGastadas(){
		return piezas.filter({pieza => pieza.estaGastada()}).size()
	}
}

class Pieza{
	var porcentajeDeResistencia
	var desgaste
	
	method estaGastada(){
		return desgaste >= 20
	}
	
	method porcentajeDeResistencia(){
		return porcentajeDeResistencia
	}
}
