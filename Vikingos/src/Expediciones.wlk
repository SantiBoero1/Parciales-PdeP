import Vikingos.*
import Castas.*

class Expedicion{
	const property integrantes = #{}
	var objetivos = []
	
	
	// Punto 1
	method subirAExpedicion(unVikingo){
		if(!unVikingo.esProductivo()){
			throw new Exception (message = "No puede subir a la expedicion")
		}
		else integrantes.add(unVikingo)
	}
	
	// Punto 2
	method valeLaPena(unaExpedicion){
		unaExpedicion.all({lugar => lugar.valeLaPena(self.cantidadIntegrantes())})
	}
	
	method realizarExpedicion(){
		objetivos.forEach({objetivo => objetivo.serInvadidoPor(self)})
	}
	
	method cantidadIntegrantes(){
		return integrantes.size()
	}
	
	method repartirBotin(unaCantidad){
		integrantes.forEach({integrante => integrante.sumarCantidad(unaCantidad  / self.cantidadIntegrantes())})
	}
	
	method aumentarVidasCobradasEn(unaCantidad){
		unaCantidad.times(n => integrantes.forEach({integrante => integrante.cobrarVida()})
	}
	
	method agregarObjetivo(unObjetivo){
		objetivos.add(unObjetivo)
	}
	
	
	// Para agregar un nuevo objetivo castillo, este debe ser polimórfico con los otros objetivos existentes. No hace falta modificar código existente, siempre y cuando se implementen los mensajes valeLaPenaPara, botin, y serInvadidoPor (y siempre y cuando no necesite más cosas del vikingo para resolver esos métodos, en cuyo caso convendría pasar el vikingo por parámetro)
	
}