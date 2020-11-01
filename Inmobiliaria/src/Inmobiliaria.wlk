import Inmuebles.*
import Empleados.*

class Inmobiliaria{
	const operaciones = []
	const empleados = []
	var porcentajeDeVenta
	
	method alquiler(unInmueble,cantidadDeMeses,unEmpleado,unCliente){
		unEmpleado.concretarOperacion(unCliente,unInmueble)
		operaciones.add(unInmueble)
		return unEmpleado.cobrarComisionDeAlquiler(unInmueble,cantidadDeMeses)
		
	}
	
	method venta(unInmueble,unEmpleado,unCliente){
		if(!unInmueble.esLocal()){
			unEmpleado.concretarOperacion(unCliente,unInmueble)
			operaciones.add(unInmueble)
			return unEmpleado.cobrarComisionDeVenta(unInmueble,porcentajeDeVenta)
		}
		else throw new Exception (message = "Los locales no pueden venderse")
	}
	
	method reservar(unCliente,unInmueble,unEmpleado){
		unEmpleado.reservarPropiedad(unCliente,unInmueble)
	}
	
	method elMejorEmpleadoSegunCriterio(unCriterio){
		return empleados.max({empleado => unCriterio.cumpleElCriterior(empleado)})	
	}
	
	method vaATenerProblemas(unEmpleado,otroEmpleado){
		return self.cerraronOpsEnMismaZona(unEmpleado,otroEmpleado) && (unEmpleado.concretoReservaDe(otroEmpleado) || otroEmpleado.concretoReservaDe(unEmpleado))
	}
	
	method cerraronOpsEnMismaZona(unEmpleado,otroEmpleado){
		
	}
	
}


