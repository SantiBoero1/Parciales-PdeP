import Vikingos.*
import Expediciones.*
import Castas.*

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
}
