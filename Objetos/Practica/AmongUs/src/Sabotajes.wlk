object reducirOxigeno {
	method realizarSabotaje(){
		if (!nave.algunoTieneTuboOxigeno()){}
		else	nave.reducirOxigeno(10)
	}
}

object impugnarAUnJugador(){
	const impugnado
	
	method realizarSabotaje(){
		impugnado.votarEnBlanco()
	}
}
