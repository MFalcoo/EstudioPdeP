object asentamiento {
	method apply(persona){	
		persona.asentarRecuerdos(persona.recuerdosDelDia())
	}
}

class AsentamientoSelectivo{
	const palabraClave
	method apply(persona){
		persona.asentamientoSelectivo(palabraClave)
	}
}
object profundizacion{
	method apply(persona){
		persona.profundizar()
	}	
}

object controlHormonal{
	method apply(persona){
		persona.controlHormonal()
	}
}

object restauracionCognitiva{
	method apply(persona){
		persona.amuentarFelicidad() 
	}
	
}

object liberacionRecuerdosDelDia{
	method apply(persona){
		persona.liberacionRecuerdosDelDia()
	}
}


	