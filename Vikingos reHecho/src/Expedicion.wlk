class Expedicion {
	
	var vikingos = #{}
	var objetivos = []
	
	method subirAExpedicion(unVikingo){
		if(!unVikingo.puedeSubirA(self)){
			throw new Exception (message = "No pudo subir")
		}
		vikingos.add(unVikingo)
	}
	
	method valeLaPena(){
		return objetivos.all({objetivo => objetivo.valeLaPena(vikingos)})
	}
	
}
