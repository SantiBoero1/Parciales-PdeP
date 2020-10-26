object vegetariano {
	
	method decideComer(unaComida){
		return !unaComida.esCarne()
	}
}

object dietetico {
	var caloriasRecomendadasPorLaOMS = 500
	
	method decideComer(unaComida){
		return unaComida.calorias() < caloriasRecomendadasPorLaOMS
	}
	
	method caloriasRecomendadasPorLaOMS(nuevasCaloriasRecomendadas){
		caloriasRecomendadasPorLaOMS = nuevasCaloriasRecomendadas
	}
}

object alternado {
	
}

object combinado{
	
}