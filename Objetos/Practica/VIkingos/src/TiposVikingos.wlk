object jarl {
	
	method validarSiPuedeSubirAExpedicion(vikingo){
		if(vikingo.tieneArmas())
			vikingo.noPermiteSubir()
	}
	
	method asender(vikingo){
		vikingo.convertirse(karl)
		vikingo.beneficiosKarl()
	}
	
}

object karl {
	method validarSiPuedeSubirAExpedicion(_vikingo){}
	method asender(vikingo){
		vikingo.convertirse(thrall)
	}
}

object thrall {
	method validarSiPuedeSubirAExpedicion(_vikingo){}
}

