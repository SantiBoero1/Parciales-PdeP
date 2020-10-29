import casas.*
import Acompaniantes.*
import Personalidades.*

class Personaje{
	
	var casa
	var conyuges = #{}
	var estaVivo
	var acompaniantes = []
	var aliados = #{}
	var personalidad
	
	method puedeCasarseCon(unaPersona){
		return casa.puedeCasarse(self,unaPersona) && unaPersona.casa().puedeCasarse(self)
	}
	
	method casarseCon(unaPersona){
		if(self.puedeCasarseCon(unaPersona)){
			self.aniadirConyuge(unaPersona)
			unaPersona.aniadirConyuge(self)
		}
		else throw new Exception (message = "No se pudieron casar")
	}
	
	method aniadirConyuge(unaPersona){
		conyuges.add(unaPersona)
	}
	
	method casa(){
		return casa
	}
	
	method cantidadDeConyuges(){
		return conyuges.size()
	}
	
	method patrimonio(){
		return casa.patrimonio() / casa.cantidadDeMiembros()
	}
	
	method estaSolo(){
		return acompaniantes.isEmpty() 
	}
	
	method aliados(){
		aliados = conyuges + acompaniantes + casa.miembros()
		return aliados
	}
	
	method suCasaEsRica(){
		return casa.esRica()
	}
	
	method esPeligroso(){
		return estaVivo && 
			   aliados.map({aliado => aliado.patrimonio()}).sum() > 10000 || 
			   conyuges.all({conyuge => conyuge.suCasaEsRica()}) && 
			   self.esAliadoDeAlguienPeligroso()
	}
	
	method esAliadoDeAlguienPeligroso(){
		return aliados.any({aliado => aliado.esPeligroso()})
	}
	
	method personalidad(){
		return personalidad
	}
	
	method crearConspiracion(unPersonaje,complotados){
		if(unPersonaje.esPeligroso()){
			const conspiracion = new Conspiracion(objetivo = unPersonaje, participantes = complotados)
		}
		else throw new Exception (message = "No se pudo crear la conspiracion")
	}
	
	method cuantosTraidoresHay(unaConspiracion){
		
		unaConspiracion.participantes().filter({participante => participante.esAliadoDe(unaConspiracion.objetivo())})
	}
	
	method ejecutarConspiracion(unaConspiracion){
		unaConspiracion.llevarACabo()
	}
	
	method esAsesinado(){
		estaVivo = false
	}
	
	method derrocharFortuna(unPorcentaje){
		casa.perderPatrimonio(unPorcentaje)
	}
	
	method esAliadoDe(unaPersona){
		return aliados.contains(unaPersona)
	}
	
	method seCumplioLaConspiracion(unaConspiracion){
		return unaConspiracion.elObjetivoYaNoEsPeligroso()
	}
	
}

class Conspiracion{
	var property objetivo
	var property participantes
	
	method llevarACabo(){
		participantes.forEach({participante => participante.personalidad().realizarAccionPorLaCausa(objetivo)})
	}
	
	method elObjetivoYaNoEsPeligroso(){
		return not objetivo.esPeligroso()
	}
}