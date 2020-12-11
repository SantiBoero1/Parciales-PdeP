import Personajes.*
import Casas.*

object sutil {
	
	method realizarAccion(unaVictima){
		var casaMasPobre = continente.laCasaMasPobre()
		var unaPersona = casaMasPobre.miembroVivoYSoltero()
		unaVictima.realizarCasamiento(unaPersona)
	}
}

object asesino{
	
	method realizarAccion(unaVictima){
		unaVictima.morir()
	}
}

object asesinoPrecavido{
	
	method realizarAccion(unaVictima){
		if(unaVictima.estaSola()){
			unaVictima.morir()
		}
	}
}

object disipado{
	
	var porcentajeADerrochar = 10
	
	method realizarAccion(unaVictima){
		unaVictima.derrocharFortuna(porcentajeADerrochar)
	}
}

object miedoso{
	
	method realizarAccion(unaVictima){
		// No hace nada
	}
}