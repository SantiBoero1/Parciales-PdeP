import Piratas.*
import Barco.*
import Items.*

class Mision{
	
	method puedeSerCompletada(unBarco){
		return unBarco.tieneSuficienteTripulacion()
	}
	

	method puedeSerUtil(unPirata)

	
}

class BusquedaDelTesoro inherits Mision{
	
	override method puedeSerCompletada(unBarco){
		return super(unBarco) && unBarco.algunoPoseeLaLlave()
	}
	
	override method puedeSerUtil(unPirata){
		return (unPirata.posee(brujula) || unPirata.posee(mapa) || unPirata.posee(botellaDeGrog)) && unPirata.tieneMenosDe(5)
	}
	
}

class ConvertirseEnLeyenda inherits Mision{
	
	var itemObligatorio
	
	override method puedeSerUtil(unPirata){
		return unPirata.posee10ItemsOMas() && unPirata.posee(itemObligatorio)
	}
}

class Saqueo inherits Mision{
	
	var victima
	var cantidadDeDinero
	
	override method puedeSerCompletada(unBarco){
		return super(unBarco) && victima.esVulnerableA(unBarco)
	}
	
	override method puedeSerUtil(unPirata){
		return unPirata.tieneMenosDe(cantidadDeDinero) && unPirata.seAnimaASaquear(victima)
	}
}


class CiudadCostera{
	
	var cantidadDeHabitantes
	
	method puedeSerSaqueadaPor(unPirata){
		return unPirata.estaEbrio()
	}
	
	method esVulnerableA(unBarco){
		return self.poseeMenosPoblacionQue(unBarco) || unBarco.todosEstanPasadosDeGrog()
	}
	
	method poseeMenosPoblacionQue(unBarco){
		return unBarco.cantidadDeTripulantes() * 40 / 100 >=  cantidadDeHabitantes
	}
	
	method aumentarHabitantesEn(unaCantidad){
		cantidadDeHabitantes += unaCantidad
	}
}