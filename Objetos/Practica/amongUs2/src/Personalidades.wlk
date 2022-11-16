object trolls {
	
	method votar(nave){
		nave.jugadoresNoSospechosos().any()
	}
}

object detective {
	
	method votar(nave){
		nave.jugadoresMasSospechoso()
	}
}

object materialista {
	
	method votar(nave){
		nave.jugadorConMochilaVacia().
	}
}
