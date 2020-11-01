object masComisiones {
	
	method cumpleCriterio(unEmpleado){
		return unEmpleado.comisiones().sum()
	}
}

object cantDeOperacionesCerradas {
	
	method cumpleCriterio(unEmpleado){
		return unEmpleado.operacionesCerradas().size()
	}
}

object cantDeReservas {
	
	method cumpleCriterio(unEmpleado){
		return unEmpleado.reservas().size()
	}
}