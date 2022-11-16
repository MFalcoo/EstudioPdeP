class Tarea{
	const property itemsRequeridos
	const puntosSospecha
	method puedeSerCompletadaPor(jugador){
		if(!jugador.contieneItems(itemsRequeridos))
		 throw new Exception (message="No puede completarla")
		 self.realizarse(jugador)
	}
	
	method realizarse(jugador){
		jugador.cambiarNivelSospecha(puntosSospecha)
	}
}


object arreglarTableroElectrico inherits Tarea (itemsRequeridos = [llaveInglesa], puntosSospecha = 10){

	
	
}

object sacarBasura inherits Tarea (itemsRequeridos = [escoba, bolsaDeConsorcio], puntosSospecha =-4){


	
	
}
object ventilarNave inherits Tarea (itemsRequeridos = [], puntosSospecha = 0){
	
	override method realizarse(jugador){
		jugador.nave().cambiarNivelDeOxigeno(5)
	}
	
	
	
}
