class Acompaniante {
	
	method esPeligroso()
	
	method patrimonio(){
		return 0
	}
}

class Lobo inherits Acompaniante{
	var esHuargo
	
	override method esPeligroso(){
		return esHuargo
	}
}

class Dragon inherits Acompaniante{
	
	override method esPeligroso(){
		return true
	}
}
