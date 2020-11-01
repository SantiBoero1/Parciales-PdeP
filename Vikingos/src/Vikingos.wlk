import Expediciones.*
import Castas.*

class Vikingo {
	var castaSocial
	
	method puedeIrALaExpedicion(unaExpedicion){
		return self.esProductivo() && castaSocial.puedeIrA(self,unaExpedicion)
	}
	
	method esProductivo()
	
}

class Soldado inherits Vikingo {
	var cantVidasCobradas
	var armas = []

	method esProductivo(){
		return cantVidasCobradas > 20 && self.tieneArmas()
}
	method tieneArmas(){
		return armas.size() > 0
	}

}

class Granjero inherits Vikingo{
	var cantDeHijos
	var cantDeHectareas
	
	method esProductivo(){
		return cantDeHectareas >= cantDeHijos * 2
	}
	
	method tieneArmas(){
		return false
	}
}