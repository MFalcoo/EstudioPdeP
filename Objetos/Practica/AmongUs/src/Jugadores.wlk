import Nave.*

class Jugador {
	var ProximoVotoEnBlanco=false
	var mochila = []
	var property nivelDeSospecha = 40	
	var tareas 
	var sigueEnNave = true
	const personalidad
	var property votos
	
	method esSospechoso() {
		return nivelDeSospecha > 50
	}
	
	method buscarItem(unItem){
		mochila.add(unItem)
	}
	
	method realizarTarea()
	
	method mochilaContiene(unItem){
		return mochila.contains(unItem)
	}
	
	method aumentarSospecha(nivel){
		nivelDeSospecha =+ nivel
	}
	method disminuirSospecha(nivel){
		nivelDeSospecha =- nivel
	}
	

	method completoTodasSusTareas()
	
	method tieneItem(unItem){
		return mochila.contains(unItem)
	}
	
	method sacarItems(items){
		mochila.remove(items)
	}
	
	method realizarTarea()
	
	method llamarReunionDeEmergencia(){
		nave.convocarVotacion()
		nave.ExpulsarJugadorConMasVotos()
	}
	
	method jugadorVotado(){
		if (ProximoVotoEnBlanco){
			ProximoVotoEnBlanco = false 
			return votoEnBlanco
		}
		return personalidad.votar()
	}
	
	method estaEnPie(){
		return sigueEnNave
	}
	
	method mochilaVacia(){
		return mochila.isEmpty()
	}
	method votarEnBlanco(){
		ProximoVotoEnBlanco= true
	}		

	method expulsado(){
		sigueEnNave = false
	}
	method jugadorPosibleVotado(){
		return nave.jugadorVivoCualquiera()
		}
}

class Tripulante inherits Jugador {
	
	override method realizarTarea(){
		const tarea = self.tareaRealizable()
		tarea.serRealizada(self)
		tareas.remove(tarea)
		nave.chequearTodasLasTareas()
	}
	
	method tareaRealizable(){
		return tareas.find({unaTarea=>unaTarea.puedeSerRealizadaPor(self)})
	}
	override method completoTodasSusTareas(){
		return tareas.isEmpty()
	}
	override method expulsado(){
		super()
		nave.tripulanteExpulsado()
	}
}

class Impostor inherits Jugador{
	
	override method realizarTarea(){
	}
	
	
	override method completoTodasSusTareas(){
		return true
	}
	
	method sabotear(unSabotaje){
		unSabotaje.realizarSabotaje()
		self.aumentarSospecha(5)
		}
	}
	override method expulsado(){
		super()
		nave.impostorExpulsado()
	}
}