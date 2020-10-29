object islaCerdito {
	var obstaculos = []
	
}

class Pared{
	var anchoDeLaPared
	var material
	
	method resistencia(){
		return material.resistenciaMaterial() * anchoDeLaPared
	}
}

object vidrio{
	
	const property resistenciaMaterial = 10
}

object madera{

	const property resistenciaMaterial = 25
}

object piedra{
	var anchoDeLaPared
	
	const property resistenciaMaterial = 50
}

class Cerdito{
	var tipo
	
	method resistencia(){
		return tipo.resistenciaDeTipo()
	}
}

object obrero{

	method resistenciaDeTipo(){
		return 50
	}
}

class CerditoConHerramienta{
	var herramienta
	
	method resistencia(){
		return 10 * herramienta.resistenciaHerramienta()
	}
}

class Herramienta{
	const property resistenciaHerramienta
}

 