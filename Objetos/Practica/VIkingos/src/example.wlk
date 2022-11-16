class Vikingo{
	var casta
	var property armas
	var property asesinatos
	var dinero
	
	method validarSiPuedeSubirAExpedicion(){
		casta.validarSiPuedeSubirAExpedicion(self)
		if(!self.esProductivo())
		self.noPermiteSubir()
	}

	method noPermiteSubir(){
		throw new Exception (message="No puede subir")	
	}
	
	method esProductivo()
	
	method tieneArmas(){
		return armas>0
	}
	
	method asensoSocial(){
		casta.asender(self)
	}
	
	method convertirse(nuevaCasta){
		casta = nuevaCasta
	}
	
	method beneficiosKarl()
	
	method agregarArmas(cantidad){
		armas =+ cantidad
	}
	
	method repercucionesDeExpedicion(cantidadDeBotin,cantidadAsesinatos){
		dinero =+ cantidadDeBotin
		asesinatos =+ cantidadAsesinatos
	}
}

class Soldado inherits Vikingo{
	
	override method esProductivo(){
		return self.asesinatos()>20 && self.tieneArmas()
	}
	
	override method beneficiosKarl(){
		self.agregarArmas(10)
	}
}

class Granjero inherits Vikingo{
	var property hectareas
	var hijos 
	
	override method esProductivo(){
		return hectareas/hijos > 2 
	}
	
	override method beneficiosKarl(){
		self.agregarHijosyDosHectaresa()
	}
	
	method agregarHijosyDosHectaresa(){
		hijos =+ 2
		hectareas =+2
	}
}




