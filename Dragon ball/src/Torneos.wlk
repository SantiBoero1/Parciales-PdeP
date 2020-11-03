object powerIsBest {
	const postulantes = #{}
	
	method elegirParticipantes(){
		const participantes = postulantes.sortBy({postulante1, postulante2 => postulante1.potencial() > postulante2.potencial()})
		return participantes.take(16)
	}
}

object funny{
	const postulantes = #{}
	
	method elegirParticipantes(){
		const participantes = postulantes.sortBy({postulante1, postulante2 => postulante1.cantidadDeElementosDeSuTraje() > postulante2.cantidadDeElementosDeSuTraje()})
		return participantes.take(16)
	}
}

object surprise{
	const postulantes = #{}
	const participantes = #{}
	
	method elegirParticipantes(){
		16.times({n => participantes.add(postulantes.anyOne())})
		return participantes
	}
}
