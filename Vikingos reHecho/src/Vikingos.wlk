class Vikingo{
	
	var casta
	
	method esProductivo()
	
	method puedeSubirA(unaExpedicion){
		return self.esProductivo() && casta.puedeIr(self,unaExpedicion)
	}
}

class Soldado inherits Vikingo{
	var cantDeArmas
	var cantDeVidasCobradas
	
	override method esProductivo(){
		return cantDeVidasCobradas > 20 && cantDeArmas > 0
	}
	
}

class Granjero inherits Vikingo{
	var cantDeHijos
	var cantDeHectareas
	
	override method esProductivo(){
		return cantDeHectareas >= cantDeHijos * 2
	}
}