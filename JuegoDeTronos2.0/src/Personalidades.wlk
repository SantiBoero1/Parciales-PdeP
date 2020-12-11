import Personajes.*
import Casas.*

object sutil {
	
	const casas = #{stark,lannister,guardia}
	
	method realizarAccion(unaVictima){
		const casaMasPobre = self.laCasaMasPobre()
		const unaPersona = casaMasPobre.miembroVivoYSoltero()
		unaVictima.realizarCasamiento(unaPersona)
	}
	
	method laCasaMasPobre(){
		return casas.min({casa => casa.patrimonio()})
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