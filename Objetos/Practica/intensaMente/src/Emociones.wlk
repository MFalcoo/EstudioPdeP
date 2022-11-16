class Emocion{
	
	method asentar(persona,recuerdo){}
	
	method niega(emocionDelRecuerdo){
		return false
	}
	method esAlegre(){
		return false
	}
}

object alegria inherits Emocion{
	
	override method asentar(persona,recuerdo){
		if(persona.nivelDeFelicidad()>500)
		persona.convertirAPensamientoCentral(recuerdo)
	}
	
	override method niega(emocionDelRecuerdo){
		return emocionDelRecuerdo.esAlegre()
	}
	
	override method esAlegre(){
		return false
	}
	
}

object tristeza inherits Emocion {
	
	override method asentar(persona,recuerdo){
		persona.convertirAPensamientoCentral(recuerdo)
		persona.disminuirFelicidad(10)
	}
	override method niega(emocionDelRecuerdo){
		return emocionDelRecuerdo.esAlegre()
	}
}

class EmocionCompuesta inherits Emocion{
	const emociones
	
	override method niega(emocionDelRecuerdo){
		return emociones.all({emocion=>emocion.niega(emocionDelRecuerdo)})
	}
	
	override method asentar(persona,recuerdo){
		emociones.forEach({emocion=>emocion.asentar(persona,recuerdo)})
	}
	
	override method esAlegre(){
		return emociones.any({emocion=>emocion.esAlegre()})
	}
}

object disgusto inherits Emocion{
	
	
}


object furia inherits Emocion{
	
	
}


object temor inherits Emocion{
	
	
}
