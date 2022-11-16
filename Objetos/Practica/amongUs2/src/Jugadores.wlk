class Jugador {
	var mochila = []
	var nivelSospecha = 40
	var tareas
	const property nave
	var vaAVotarEnBlanco = false
	var property loExpulsaron = false
	const personalidad
	
	
	method esSospechoso(){
		return nivelSospecha>50
	}
	
	method buscarItem(item){
		mochila.add(item)
	}
	
	method contieneItems(itemsRequeridos){
		itemsRequeridos.all({unItem=>mochila.contains(unItem)})
	}
	
	method completoTodasLasTareas()
	
	method realizarTarea()
	
	method informarALaNave(){
		nave.recibirAviso()
	}
	method cambiarNivelSospecha(puntosSospecha){
		nivelSospecha =+ puntosSospecha
	}
	
	method votarEnBlancoEnLaProximaVotacion(){
		vaAVotarEnBlanco = true
	}
	
	method llamarReunionDeEmergencia(){
		nave.votacion()	
	}
	
	method votar(){
		if(vaAVotarEnBlanco){
		nave.sumarVoto(votoEnblanco)
		vaAVotarEnBlanco = false
		}
		nave.sumarVoto(personalidad.votar())
	}
	
	method expulsar(){
		loExpulsaron = true
	}
	method esImpostor()
	
	method mochilaVacia(){
		return mochila.isEmpty()
	}
	
}

class Tripulante inherits Jugador{
	override method completoTodasLasTareas(){
		return tareas.isEmpty()
	}
	override method realizarTarea(){
		const unaTarea = tareas.any()
		unaTarea.puedeSerCompletadaPor(self)
		tareas.remove(unaTarea)
		self.informarALaNave()
	}
	
	method validarSiPuedeRealizarTarea(unaTarea){
		const unosItems = unaTarea.itemsRequeridos()
		if(!unosItems.all({unItem=>mochila.contains(unItem)}))
			throw new Exception (message = "No tiene items necesarios")
	}
	override method esImpostor(){
		return false
	}
}

class Impostor inherits Jugador{
	override method completoTodasLasTareas(){
		return true
	}
	
	override method realizarTarea(){
		//nada
	}
	
	method sabotear(unSabotaje, jugadorAsabotear){
		unSabotaje.realizarse(jugadorAsabotear)
		self.cambiarNivelSospecha(5)
	}
	
	override method votar(){
		 nave.jugadoresNoExpulsados().any()
	}
	
	override method esImpostor(){
		return true
	}
}