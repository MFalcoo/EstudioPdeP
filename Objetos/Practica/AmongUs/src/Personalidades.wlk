object troll {
	method votar(){
		return nave.jugadorNoSospechoso()
	}
	
	
}

object detectives{
	method votar(){
		return nave.jugadorMasSospechoso()
	}
}

object materialista{
	method votar(){
		return nave.jugadorSinItems()
	}
}