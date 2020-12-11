class Conspiracion {
	
	var victima
	var participantes = #{}
	
	method actuarPorLaCausa(){
		participantes.forEach({participante => participante.conspirarContra(victima)})
	}
	
	method cuantosTraidoresHay(){
		return participantes.filter({participante => participante.esAliadoDe(victima)}).size()
	}
	
	method seCumplioElObjetivo(){
		return !victima.esPeligroso()
	}	
}
