import Inmobiliaria.*
import Inmuebles.*

class Empleado {
	var comisiones = []
	var operacionesCerradas = []
	var reservas = []
	
	method cobrarComisionDeAlquiler(unInmueble,cantidadDeMeses){
		comisiones.add(self.montoDeComisionPorAlquiler(unInmueble,cantidadDeMeses))
		return self.montoDeComisionPorAlquiler(unInmueble,cantidadDeMeses)
		
	}
	
	method montoDeComisionPorAlquiler(unInmueble,cantidadDeMeses){
		return unInmueble.valorDeInmueble() * cantidadDeMeses / 50000
	}
	
	
	method cobrarComisionDeVenta(unInmueble,porcentajeDeVenta){
		comisiones.add(self.montoDeComisionPorVenta(unInmueble,porcentajeDeVenta))
		return self.montoDeComisionPorVenta(unInmueble,porcentajeDeVenta)
		
	}
	
	method montoDeComisionPorVenta(unInmueble,porcentajeDeVenta){
		return unInmueble.valorDeInmueble() * porcentajeDeVenta / 100
	}
	
	method concretarOperacion(unCliente,unInmueble){
		if(!reservas.contains(unInmueble)){
			operacionesCerradas.add(unInmueble)
			unInmueble.clienteQueReservo(unCliente)
		} // Si nadie hizo la reserva, puede comprar el inmueble
		
		else if(unCliente == unInmueble.clienteQueReservo() && reservas.contains(unInmueble)){
			reservas.remove(unInmueble)
			operacionesCerradas.add(unInmueble)
		} // Si el que solicita concretar la venta es el mismo que la reservo previamente, la puede cerrar
		
		else throw new Exception (message = "La operacion no se pudo concretar, debido a que el inmueble esta reservado por otro cliente")
	}     // Sino, no se puede llevar a cabo
	
	
	method reservarPropiedad(unCliente,unInmueble){
		if(!reservas.contains(unInmueble)){
			unInmueble.clienteQueReservo(unCliente)
			reservas.add(unInmueble)
		}
		else throw new Exception (message = "La operacion no se pudo concretar, debido a que el inmueble esta reservado por otro cliente")
	}
	
	method comisiones(){
		return comisiones
	}
	
	method operacionesCerradas(){
		return operacionesCerradas
	}
	
	method reservas(){
		return reservas
	}
		
}
