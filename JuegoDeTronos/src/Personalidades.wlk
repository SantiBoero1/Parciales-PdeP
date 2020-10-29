import casas.*
import Acompaniantes.*
import Personajes.*

object sutil {
	
	method realizarAccionPorLaCausa(unPersonaje){
		
		unPersonaje.casarseCon()
	}
}

object asesino{
	
	method realizarAccionPorLaCausa(unPersonaje){
		
		unPersonaje.esAsesinado()
	}
}

object asesinoPrecavido{
	
	method realizarAccionPorLaCausa(unPersonaje){
		if(unPersonaje.estaSolo()){
			unPersonaje.esAsesinado()
		}
	}
}

object disipado{
	var porcentajeADerrochar
	
	method realizarAccionPorLaCausa(unPersonaje){
		unPersonaje.derrocharFortuna(porcentajeADerrochar)
	}
}

object miedoso{
	
	method realizarAccionPorLaCausa(unPersonaje){
		/*Hace apoyo moral */
	}
}
