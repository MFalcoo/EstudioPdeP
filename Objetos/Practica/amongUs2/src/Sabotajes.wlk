object reducirOxigeno {
	
	method realizarse(jugadorAsabotear){
		if(!jugadorAsabotear.nave().algunoContieneItem(tuboDeOxigeno))
		jugadorAsabotear.nave().cambiarNivelDeOxigeno(-10)
	}
	
	
}

object reducirOxigeno {
	
	method realizarse(jugadorAsabotear){
		jugadorAsabotear.votarEnBlancoEnLaProximaVotacion()
	}
	
	
}

