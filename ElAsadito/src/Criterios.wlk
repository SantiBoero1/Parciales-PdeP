import Asado.*

object sordo {
	
	method realizarAccion(unElemento,unaPersona,otraPersona){
		otraPersona.aniadirElementoCerca(unaPersona.elementosCerca().first())
		unaPersona.sacarPrimerElementoCerca()
	}
}

object comerTranquilo{
	
	method realizarAccion(unElemento,unaPersona,otraPersona){
		otraPersona.elementosCerca().intersection(unaPersona.elementosCerca())
		unaPersona.noTieneMasElementosCerca()
	}
}

object elHincha{
	
	method realizarAccion(unElemento,unaPersona,otraPersona){
		unaPersona.cambiarPosicionCon(otraPersona)
	}
}

object buenaPersona{
	
	method realizarAccion(unElemento,unaPersona,otraPersona){
		otraPersona.aniadirElementoCerca(unElemento)
		unaPersona.sacarElementoCerca(unElemento)
	}
}