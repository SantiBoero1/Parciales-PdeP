class Disfraz {
	var caracteristicas = #{}
	var nivelDeGracia
	
	method puntaje(unaPersona){
		caracteristicas.map({caracteristica => caracteristica.calcularPuntaje(unaPersona,nivelDeGracia)})
	}
}

object gracioso{
	
	method calcularPuntaje(unaPersona,nivelDeGracia){
		if(unaPersona.edad() > 50){
			return nivelDeGracia * 3
		}
		else return nivelDeGracia
	}
}

object tobara{
	
}

object careta{
	
}

object sexi{
	
}