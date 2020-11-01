import Vikingos.*
import Castas.*

class Expedicion{
	const property integrantes = #{}
	
	// Punto 1
	method subirAExpedicion(unVikingo){
		if(!unVikingo.esProductivo()){
			throw new Exception (message = "No puede subir a la expedicion")
		}
		else integrantes.add(unVikingo)
	}
	
	method valeLaPena(unaExpedicion){
		unaExpedicion.all({lugar => lugar.valeLaPena(vikingos)})
	}
}