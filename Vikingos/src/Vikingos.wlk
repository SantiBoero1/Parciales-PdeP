import Expediciones.*
import Castas.*
import Lugares.*

class Vikingo {
	var property castaSocial
	var property botin = 0
	
	method puedeIrALaExpedicion(unaExpedicion){
		return self.esProductivo() && castaSocial.puedeIrA(self,unaExpedicion)
	}
	
	method esProductivo()
	
	method ascender(){
		castaSocial.ascender(self)
	}
	
	method sumarCantidad(unaCantidad){
		botin += unaCantidad
	}
	
	method cobrarVida(){}
	
}

class Soldado inherits Vikingo {
	var cantVidasCobradas
	var armas

	override method esProductivo(){
		return cantVidasCobradas > 20 && self.tieneArmas()
}
	method tieneArmas(){
		return armas > 0
	}
	
	method bonificarAscenso(){
		armas += 10
	}
	
	override method cobrarVida(){
		cantVidasCobradas += 1
	}

}

class Granjero inherits Vikingo{
	var cantDeHijos
	var cantDeHectareas
	
	override method esProductivo(){
		return cantDeHectareas >= cantDeHijos * 2
	}
	
	method tieneArmas(){
		return false
	}
	
	method bonificarAscenso(){
		cantDeHijos += 2
		cantDeHectareas += 2
	}
}