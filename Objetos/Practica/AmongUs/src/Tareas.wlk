import Nave.*

class Tarea {
	const items = []
	
	method puedeSerRealizadaPor(jugador){
		return items.all({unItem=>jugador.tieneItem(unItem)})
	}
	method serRealizada(jugador){
		jugador.sacarItems()
	}
}

object arreglarTablero inherits Tarea (items= ["llaveInglesa"]){
	
	override method serRealizada(jugador){
		jugador.aumentarSospecha(10)
		super(jugador)
	}

}

object sacarBasura inherits Tarea (items= ["Escoba","bolsaDeConsorcio") {
	override method serRealizada(jugador){
		jugador.disminuirSospecha(4)
		super(jugador)
	}
	
}


object ventilarNave inherits Tarea(items=[]){
	
	override method serRealizada(jugador){
		nave.aumentarOxigeno(5)
		super(jugador)
	}	 
}

