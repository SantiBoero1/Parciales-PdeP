import Criterios.*
import Comidas.*
import Gustos.*

class Persona{
	var property posicion
	var elementosCerca = []
	var criterio
	const comidasQueIngirio = #{}
	var tipoDeGusto
	
	method elementosCerca(){
		return elementosCerca
	}
	
	method pedirUnaCosa(unaCosa,unaPersona){
		if(unaPersona.poseeCerca(unaCosa)){
		 unaPersona.pasarElemento(unaCosa,self)
		}
		else /*No hace nada */
	}
	
	method pasarElemento(elemento,unaPersona){
		criterio.realizarAccion(elemento,self,unaPersona)
	}
	
	method sacarPrimerElementoCerca(){
		elementosCerca = elementosCerca.drop(1)
	}
	
	method aniadirElementoCerca(unElemento){
		elementosCerca.add(unElemento)
	}
	
	method sacarElementoCerca(unElemento){
		elementosCerca.remove(unElemento)
	}
	
	method poseeCerca(unElemento){
		return elementosCerca.contains(unElemento)
	}
	
	method noTieneMasElementosCerca(){
		elementosCerca = []
	}
	
	method cambiarPosicionCon(otraPersona){
		var nuevaPosicion
		
		nuevaPosicion = otraPersona.posicion()
		otraPersona.cambiarPosicion(posicion)
		self.cambiarPosicion(nuevaPosicion)
	}
	
	method cambiarPosicion(nuevaPosicion){
		posicion = nuevaPosicion
	}
	
	method comer(unaComida){
		if(tipoDeGusto.decideComer(unaComida)){
			comidasQueIngirio.add(unaComida)
		}
	}
	
	method estaPipon(){
		comidasQueIngirio.any({comida => comida.esPesada()})
	}
	
	method laEstaPasandoBien(){
		return self.comioAlgo()
	}
	
	method comioAlgo(){
		return !comidasQueIngirio.isEmpty()
	}
}

object osky inherits Persona{
	
	override method laEstaPasandoBien(){
		return true
	}
}

object moni inherits Persona{
	
	override method laEstaPasandoBien(){
		return self.comioAlgo() && posicion == 11
	}
}

object facu inherits Persona{
	
	override method laEstaPasandoBien(){
		return self.comioAlgo() && comidasQueIngirio.any({comida => comida.esCarne()})
	}
}

object vero inherits Persona{
	
	override method laEstaPasandoBien(){
		return self.comioAlgo() && elementosCerca.size() <= 3
	}
}

/*
 Punto 5
 
 Utilice polimorfismo en pasar elemento, donde le derivo al criterio que realice la accion correspondiente indistintamente de quien lo haya solicitado
 Si no lo hubiese hecho de esta forma, deberia colocar varias sentencias if para corroborar cual es el criterio de la persona y realizar ciertas acciones segun
 cual sea, con lo cual pierdo muchisima declaratividad
 
 Utilice herencia en el punto 4, ya que osky, moni, facu y vero, poseen el mismo comportamiento que una persona con la excepcion
 De que se debe cumplir una condicion mas para que la pasen bien. De esta forma me evito tener que redefinir a cada objeto con el comportamiento de una persona
  
 Utilice composicion en los criterios y los gustos, ya que de esta forma pueden ser modificados con el tiempo, volviendolos mas dinamico. Si hubiese
 Utilizado herencia, no podrian cambiarse con el paso del tiempo, es decir por ejemplo, que una persona que nacio vegetariana muere vegetariana.
 
 */
