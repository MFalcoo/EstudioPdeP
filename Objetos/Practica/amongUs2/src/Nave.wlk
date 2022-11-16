class Nave {
	var jugadores
	var nivelDeOxigeno
	var votos
	
	method recibirAviso(){
		if(self.jugadoresCompletaronTodasSusTares())
		throw new Exception (message="Ganaron los tripulantes")
	}
	
	method jugadoresCompletaronTodasSusTares(){
		jugadores.all({jugador=>jugador.completoTodasLasTareas()})
	}
	
	method cambiarNivelDeOxigeno(cantidad){
		nivelDeOxigeno=+ cantidad
		if(self.noHayMasOxigeno())
		throw new Exception (message="Ganaron los impostores")
	}
	method noHayMasOxigeno(){
		return nivelDeOxigeno <= 0
	}
	
	method jugadoresNoExpulsados(){
		return jugadores.filter({jugador=>!jugador.loExpulsaron()})
	}
	
	method votacion(){
		self.jugadoresNoExpulsados().forEach({jugador=>jugador.votar()})
		self.expulsarMasVotado()
	}
	
	method sumarVoto(votado){
		votos.add(votado)
	}
	
	method expulsarMasVotado(){
		const masVotado = self.jugadoresNoExpulsados().max({unJugador=>votos.occurrencesOf(unJugador)})
		if(!masVotado.equals(votoEnBlanco)){
		masVotado.expulsar()
		self.preguntarSiHayGanador()
		}
	}
	method preguntarSiHayGanador(){
		if(!self.quedanImpostores())
		throw new Exception(message = "Ganaron los tripulantes")
		if(self.quedanMismaCantidadDeTripulanteseImpostores())
		throw new Exception(message = "Ganaron los impostores")	
	}
	
	method quedanImpostores(){
		return self.jugadoresNoExpulsados().any({jugador=>jugador.esImpostor()})
	}
	
	method quedanMismaCantidadDeTripulanteseImpostores(){
		return self.cantidadImpostores().equals(self.cantidadTripulantes())
	}
	
	method cantidadImpostores(){
		return self.jugadoresNoExpulsados().filter({jugador=>jugador.esImpostor}).size()
	}
	
	method cantidadTripulantes(){
		return self.jugadoresNoExpulsados().filter({jugador=>!jugador.esImpostor}).size()
	}
	
	method jugadorNoSospechosos(){
		return self.jugadoresNoExpulsados().findOrDefault({jugador=>!jugador.esSospechoso()},votoEnBlanco)
	}
	method jugadoresMasSospechoso(){
		return self.jugadoresNoExpulsados().max({jugador=>jugador.nivelSospecha()})
	}
	method jugadorConMochilaVacia(){
		return self.jugadoresNoExpulsados().findOrDefault({jugador=>jugador.mochilaVacia()},votoEnBlanco)
	}
}


object votoEnBlanco{}