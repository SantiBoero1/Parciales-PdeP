import Telefonia.*
import Consumos.*

class Credito {
	var creditoDisponible
	
	method creditoDisponible(){
		return creditoDisponible
	}	
	
	method satisfaceUnConsumo(cantidadDeCredito){
		return creditoDisponible > cantidadDeCredito
	}
}

class internetMegas{
	var cantMBLibres
	
	method cantMBLibres(){
		return cantMBLibres
	}
	
	method satisfaceUnConsumo(cantidadDeMegas){
		return cantMBLibres > cantidadDeMegas
	}
}

class llamadasGratis{
	
	method satisfaceUnConsumo(cantidadDeCredito){
		return true
	}
}
