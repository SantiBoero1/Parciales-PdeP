import Piratas.*
import Misiones.*
import Items.*

class BarcoPirata{
	var mision
	const tripulantes = #{}
	var capacidad
	
	method esTemible(){
		return mision.puedeSerCompletada(self)
	}
	
	method reclutarTripulante(unPirata){
		if(self.puedeFormarParte(unPirata)){
			tripulantes.add(unPirata)
		}
	}
	
	method puedeFormarParte(unPirata){
		return unPirata.esUtilParaLaMision(mision) && self.hayLugarEnElBarco()
	}
	
	method hayLugarEnElBarco(){
		return tripulantes.size() < capacidad
	}
	
	method esVulnerableA(unBarco){
		return self.cantidadDeTripulantes() < unBarco.cantidadDeTripulantes() / 2
	}
	
	method cantidadDeTripulantes(){
		return tripulantes.size()
	}
	
	method puedeSerSaqueadaPor(unPirata){
		return unPirata.estaPasadoDeGrog()
	}
	
	method todosEstanPasadosDeGrog(){
		return tripulantes.all({tripulante => tripulante.estaPasadoDeGrog()})
	}
	
	method cambiarDeMision(otraMision){
		mision = otraMision
		tripulantes.removeAllSuchThat({tripulante => !tripulante.esUtilParaLaMision(mision)})
	}
	
	method quienEsElMasEbrio(){
		return tripulantes.max({tripulante => tripulante.nivelDeEbriedad()})
	}
	
	method anclarEnCiudadCostera(unaCiudad){
		tripulantes.forEach({tripulante => tripulante.tomarTragoDeGrogYGastarMoneda()})
		tripulantes.remove(self.quienEsElMasEbrio())
		unaCiudad.aumentarHabitantesEn(1)
	}
	
	method cuantosEstanPasadosDeGrog(){
		return self.tripulantesPasadosDeGrog().size()
	}
	
	method tripulantesPasadosDeGrog(){
		return tripulantes.filter({tripulante => tripulante.estaPasadoDeGrog()})
	}
	
	method itemsDistintosDeLosPasadosDeGrog(){
		const itemsDeLosPasadosDeGrog = #{}
		itemsDeLosPasadosDeGrog.add(self.itemsDeLosPasados())
		return itemsDeLosPasadosDeGrog.size()
	}
	
	method itemsDeLosPasados(){
		return self.tripulantesPasadosDeGrog().filter({tripulante => tripulante.items()})
	}
	
	method elMasEbrioYRico(){
		return self.tripulantesPasadosDeGrog().max({tripulante => tripulante.dinero()})
	}
}