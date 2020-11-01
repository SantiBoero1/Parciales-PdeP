import Expediciones.*
import Vikingos.*
import Castas.*


class Lugar{
	method serInvadidoPor(expedicion){
		expedicion.repartirBotin(self.botin(expedicion.cantidadIntegrantes()))
		self.destruirse(expedicion.cantidadIntegrantes())
	}
	
	
	
	method destruirse(cantVikingos)
	method botin(cantVikingos)
}

class Capital inherits Lugar{
	var riqueza
	var property defensores
	
	method valeLaPena(cantVikingos){
		return self.botin(cantVikingos) >= cantVikingos * 3
	}
	
	override method botin(cantVikingos){
		return self.defensoresDerrotados(cantVikingos) * riqueza
	}
	
	override method destruirse(cantVikingos){
		defensores -= self.defensoresDerrotados(cantVikingos)
	}
	
	method defensoresDerrotados(cantVikingos){
		 return defensores.min(cantVikingos)
	}
	
	override method serInvadidoPor(expedicion){
		expedicion.aumentarVidasCobradasEn(self.defensoresDerrotados(expedicion.cantidadIntegrantes()))
		super(expedicion)
	}
	
	
}

class Aldea inherits Lugar{
	var cantidadDeCrucifijos
	
	method valeLaPena(cantVikingos){
		return self.botin(cantVikingos) >= 15 
	}
	
	override method botin(cantVikingos){
		return cantidadDeCrucifijos
	}
	
	override method destruirse(cantVikingos){
		cantidadDeCrucifijos = 0
	}
}

class AldeaMurallada inherits Aldea{
	var cantidadMinimaDeVikingos
	
	override method valeLaPena(cantVikingos){
		return super(cantVikingos) && cantVikingos > cantidadMinimaDeVikingos
	}
}
