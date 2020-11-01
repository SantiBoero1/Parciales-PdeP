import Packs.*
import Telefonia.*

class Consumo {
	var property dia
	var property costo
	
	method estaDentroDelRango(fechaInicial,fechaFinal){
		return dia.between(fechaInicial,fechaFinal)
	}
}
