import Barco.*
import Misiones.*
import Items.*

class Pirata {
	
	const items = []
	var nivelDeEbriedad 
	var dinero
	
	method items(){
		return items
	}
	
	method dinero(){
		return dinero
	}
	
	method esUtilParaLaMision(unaMision){
		return unaMision.puedeSerUtil(self)
	}
	
	method posee(unItem){
		return items.contains(unItem)
	}
	
	method posee10ItemsOMas(){
		return items.size() >= 10
	}
	
	method tieneMenosDe(unaCantidadDeMonedas){
		return dinero <= unaCantidadDeMonedas
	}
	
	method seAnimaASaquear(unaVictima){
		return unaVictima.puedeSerSaqueadaPor(self)
	}
	
	method estaPasadoDeGrog(){
		return nivelDeEbriedad >= 90 
	}
	
	method estaEbrio(){
		return nivelDeEbriedad >= 50
	}
	
	method nivelDeEbriedad(){
		return nivelDeEbriedad
	}
	
	method tomarTragoDeGrogYGastarMoneda(){
		self.tomarTragoDeGrog()
		self.validarTieneMoneda()
		self.gastarMoneda()
	}
	
	method tomarTragoDeGrog(){
		nivelDeEbriedad += 5
	}
	
	method validarTieneMoneda(){
		if(dinero <= 0){
			throw new Exception(message = "No posee monedas para gastar")
		}
	}
	
	method gastarMoneda(){
		dinero -= 1
	}
}

class EspiaDeLaCorona inherits Pirata{
	
	override method estaPasadoDeGrog(){
		return false
	}
	
	override method seAnimaASaquear(unaVictima){
		return unaVictima.puedeSerSaqueadaPor(self) && self.posee(permisoDeLaCorona)
	}
}