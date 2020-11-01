import Packs.*
import Consumos.*

class Linea{
	var packsActivos = #{}
	var consumos = []
	var hoy = new Date()
	var costoPorMB
	var costoPorSeg
	const costoPrimeros30Segs
	
	method consumoDeInternet(cantidadDeMB){
		const consumo = new Consumo(dia = new Date(), costo = cantidadDeMB * costoPorMB)
		consumos.add(consumo)
		return (cantidadDeMB * costoPorMB )
	}
	
	method consumoDeLlamada(cantidadDeSegundos){
		const consumo = new Consumo(dia = new Date(), costo = costoPrimeros30Segs + (cantidadDeSegundos - 30) * costoPorSeg)
		consumos.add(consumo)
	}
	
	method costoDeConsumoDeInternet(cantidadDeMB){
		self.consumoDeInternet(cantidadDeMB)
		return (cantidadDeMB * costoPorMB ) 
	}
	
	method costoDeConsumoDeLlamada(cantidadDeSegundos){
		self.consumoDeLlamada(cantidadDeSegundos)
		return costoPrimeros30Segs + (cantidadDeSegundos - 30) * costoPorSeg
	}
	
	method agregarPack(unPack){
		packsActivos.add(unPack)
	}
	
	method elPaqueteEstaVencido(unPack){
		return unPack.fechaDeVencimiento() > hoy
		
	}
	
	method costoPromedio(fechaInicial,fechaFinal){
		return self.costosEntreFechas(fechaInicial,fechaFinal) / consumos.size()
	}
	
	method costoFinal(){
		return self.costosEntreFechas(hoy,hoy.plusDays(29))
	}
	
	method costosEntreFechas(fechaInicial,fechaFinal){
		return consumos.filter({consumo => consumo.estaDentroDelRango(fechaInicial,fechaFinal)})
				.sum({consumo => consumo.costo()})
	}
	
	method satisfaceElConsumo(unPack){
		un
	}
}

