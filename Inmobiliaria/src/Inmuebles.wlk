import Inmobiliaria.*
import Empleados.*

class Inmueble{
	var tamanioEnM2
	var cantDeAmbientes
	var tipoOperacion
	var zonaDeUbicacion
	var property clienteQueReservo
	
	method valorDeInmueble()
	
}



class Casa inherits Inmueble{
	var valorDeLaPropiedad
	
	override method valorDeInmueble(){
		return valorDeLaPropiedad + zonaDeUbicacion.plusPorZona()
	}
	
	method esLocal(){
		return false
	}
}



class Ph inherits Inmueble{
	
	override method valorDeInmueble(){
		return (tamanioEnM2 * 14000).max(500000) + zonaDeUbicacion.plusPorZona()
	}
	
	method esLocal(){
		return false
	}
}



class Departamento inherits Inmueble{
	
	override method valorDeInmueble(){
		return cantDeAmbientes * 350000 + zonaDeUbicacion.plusPorZona()
	}
	
	method esLocal(){
		return false
	}
	
}

class Zona{
	var property plusPorZona
	
}

class Local inherits Casa{
	var tipoDeLocal
	
	override method valorDeInmueble(){
		return tipoDeLocal.valorDelLugar()
	}
	
	method esLocal(){
		return true
	}
}

class Galpon inherits Local{
	
	method valorDelLugar(){
		return valorDeLaPropiedad / 2
	}
	
}

class ALaCalle inherits Local{
	var montoFijo
	
	method valorDelLugar(){
		return valorDeLaPropiedad + montoFijo
	}
}