class Maldad {
	
	const minions = #{}
	
	method seleccionarMinionsAptos(unosMinions)
	
	method realizarseEn(unaCiudad){
		self.validarMinions()
		minions.forEach({minion => minion.sumarMaldad()})
	}
	
	method validarMinions(){
		if(minions.isEmpty()){
			throw new Exception(message = "No se puede realizar la maldad porque no hay minions")
		}
	}
	
	method premiarMinionsConBananas(unaCantidad){
		minions.forEach({minion => minion.obtenerBananas(unaCantidad)})
	}
}

object congelar inherits Maldad{
	
	var nivelDeConcentracionRequerido = 500
	
	override method seleccionarMinionsAptos(unosMinions){
		minions.add(unosMinions.filter({minion => self.cumpleCondicion(minion)}))
	}
	
	method cumpleCondicion(unMinion){
		return unMinion.nivelDeConcentracion() > nivelDeConcentracionRequerido
	}
	
	method nivelDeConcentracionRequerido(nuevoNivel){
		nivelDeConcentracionRequerido = nuevoNivel
	}
	
	override method realizarseEn(unaCiudad){
		super(unaCiudad)
		unaCiudad.reducirTemperatura(30)
		self.premiarMinionsConBananas(10)
		
		
	}
}

object robar inherits Maldad{
	
	var objetivo
	
	override method seleccionarMinionsAptos(unosMinions){
		minions.add(unosMinions.filter({minion => self.cumpleCondicion(minion)}))
	}
	
	method cumpleCondicion(unMinion){
		return unMinion.esPeligroso() && objetivo.condicionDeRobo(unMinion)
	}
	
	override method realizarseEn(unaCiudad){
		super(unaCiudad)
		unaCiudad.perderCosa(objetivo)
		objetivo.premiarPorRobo(minions)
	}
}