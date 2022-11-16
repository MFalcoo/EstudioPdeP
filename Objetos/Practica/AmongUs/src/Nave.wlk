object nave {
	const jugadores = #{}
	var oxigeno
	var property tripulantesVivos
	var property impostoresVivos
	

	method aumentarOxigeno(cantidad){
		oxigeno =+ cantidad
	}	
	method reducirOxigeno(cantidad){
		oxigeno =- cantidad
		if (oxigeno<=0)
		throw new Exception(message="Ganaron los impostores")
	}	
	
	method chequearTodasLasTareas(){
		 if(self.todosCompletaronSusTareas())
		throw new Exception (message="Ganaron los Tripulantes")
	}
	
	method todosCompletaronSusTareas(){
		return jugadores.all({unJugador=>unJugador.completoTodasSusTareas()})
	}
	
	method algunoTieneTuboOxigeno(){
		return jugadores.any({unJugador=>unJugador.tieneItem("tuboDeOxigeno")})
	}
	
	method convocarVotacion(){
		const votados = self.jugadoresEnPie().map({unJugador=>unJugador.jugadorPosibleVotado()})
		const elMasVotado = votados.max({voto=>votados.ocurrencesOf(voto)})
		self.expulsarJugadorConMasVotos(elMasVotado)
	}
	
	method jugadoresEnPie(){
		return jugadores.filter({unJugador=>unJugador.estaEnPie()})
	}
	
	method expulsarJugadorConMasVotos(votado){
		if(! votado.equals("En Blanco"))
		votado.expulsado()
		self.preguntarSiHayGanador()
	}
	method preguntarSiHayGanador(){
		if(impostoresVivos == 0)
		throw new Exception(message="Ganaron Los Tripulantes")
		else if(tripulantesVivos==impostoresVivos)
		throw new Exception(message="Ganaron los Impostores")
	}
	
	method tripulanteExpulsado(){
		tripulantesVivos --
	}
	method impostorExpulsado(){
		impostoresVivos --
	}
	
	method noQuedanImpostores(){
		return self.cantidadDeImpostores() == 0
	}
	
	method ganaronLosImpostores(){
		return self.cantidadDeImpostores() == self.cantidadDeTripulantes()
	}
	
	method cantidadDeImpostores(){
		return self.jugadoresEnPie().filter({unJugador=>unJugador.esImpostor()}).size()
	}
	method cantidadDeTripulantes(){
		return self.jugadoresEnPie().filter({unJugador=>unJugador.esTripulante()}).size()
	}
	
	method jugadorNoSospechoso(){
		self.jugadoresEnPie().findOrDefault({unJugador=>!unJugador.esSospechoso()}, votoEnBlanco)
	}
	
	method jugadorMasSospechoso(){
		self.jugadoresEnPie().max({unJugador=>unJugador.nivelDeSospecha()})
	}
	
	method jugadorSinItems(){
		self.jugadoresEnPie().findOrDefault({unJugador=>unJugador.mochilaVacia()}, votoEnBlanco)
	}
	
	method jugadorVivoCualquiera(){
		return self.jugadoresEnPie().anyOne()
	} 
}

objeto votoEnBlanco{
	method exxpulsar(){
		
	}
}

