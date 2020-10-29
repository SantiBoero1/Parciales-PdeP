import Personajes.*
import Acompaniantes.*
import Personalidades.*

class Casa {
	
	var patrimonio
	var nombreDeCiudad
	var miembros = []
	
	method esRica(){
		return patrimonio > 1000
	}
	
	method miembros(){
		return miembros
	}
	
	method patrimonio(){
		return patrimonio
	}
	
	method cantidadDeMiembros(){
		return miembros.size()
	}
	
	method perderPatrimonio(unPorcentaje){
		patrimonio = patrimonio - (patrimonio * unPorcentaje / 100)
	}
}

object lannister inherits Casa{
	
	method puedeCasarse(unMiembro,otraPersona){
		return unMiembro.cantidadDeConyuges() < 1
	}
	
	
}

object stark inherits Casa{
	
	method puedeCasarse(unMiembro,otroMiembro){
		return unMiembro.casa() != otroMiembro.casa()
	}
}

object guardiaDeLaNoche inherits Casa{
	
	method puedeCasarse(unMiembro,otraPersona){
		return false
	}
	
}