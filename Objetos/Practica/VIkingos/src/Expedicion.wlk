class Expedicion {
	var vikingos = []
	const destinoAInvadir 
	
	method subirUnVikingo(vikingo){
		vikingo.validarSiPuedeSubirAExpedicion()
		vikingos.add(vikingo)
	}
	
	method valeLaPena(){
		return destinoAInvadir.valeLaPena(vikingos.size())
	}
	
	method realizaarExpedicion(){
		destinoAInvadir.serInvadida(vikingos)
	}
	
	
	
	
}
