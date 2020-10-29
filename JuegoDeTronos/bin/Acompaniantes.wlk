import casas.*
import Personajes.*
import Personalidades.*

object dragon {
	
	method esPeligroso(){
		return true
	}
	
	method patrimonio(){
		return 0
	}
}

class Lobo{
	var esHuargo
	
	method esPeligroso(){
		return esHuargo
	}
	
	method patrimonio(){
		return 0
	}
}
