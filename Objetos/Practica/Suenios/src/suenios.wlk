class Suenios {
	const property felicidonios
	
	method esAmbicioso(){
		return felicidonios>100
	}
	
	method cumplir(persona){
		self.validarSuenio(persona)
		self.realizar(persona)
		persona.sumarFelicidonios(felicidonios)
	}
	
	method validarSuenio(persona){
		throw new Exception (message="No se puede cumplir")
	}
	
	method realizar(persona){
		return felicidonios
	}
}



class Recibirse inherits Suenios {
	const carrera
	
	override method validarSuenio(persona){
		if (!persona.carrerasQueQuiereEstudiar().contains(carrera))
			super(persona)
		if(persona.yaCompletoLaCarrera(carrera))
			super(persona)
	}
	
	override method realizar(persona){
		persona.completarCarrera(carrera)
		return super(persona)
	}
	
}

class ConseguirTrabajo inherits Suenios{
	const plataQueGana
	
	override method validarSuenio(persona){
		if(persona.plataQueQuierenGanar()<plataQueGana)
			super(persona)
	}
	override method realizar(persona){
		persona.cambiarTrabajo(self)
		return super(persona)
	}
	
}

class AdoptarHijos inherits Suenios{
	const cantidadDeHijos
	
	override method validarSuenio(persona){
		if(persona.tieneHijos())
			super(persona)
	}
	
	override method realizar(persona){
		cantidadDeHijos.forEach({hijo=>persona.nuevoHijo(hijo)})
		return super(persona)
	}
}

class TenerUnHijo inherits Suenios{

	override method validarSuenio(persona){}
	
	override method realizar(persona){
		persona.nuevoHijo(self)
		return super(persona)
	}
}


class Viajar inherits Suenios{
	
	override method validarSuenio(persona){}
	
	
}

class SuenioMultiple inherits Suenios{
	const tresSuenios
	
	
	override method cumplir(persona){
		self.validarLosTresSuenios(persona)
		self.realizarLosTresSuenios(persona)
		persona.sumarFelicidinios(self.sumaFelicidinios())
	}
	
	method sumaFelicidinios(){
		return tresSuenios.sum({suenio=>suenio.felicidinios()})
	}
	
	method validarLosTresSuenios(persona){
		tresSuenios.forEach({unSuenio=>unSuenio.validarSuenio(persona)})
	}
	
	method realizarLosTresSuenios(persona){
		tresSuenios.forEach({unSuenio=>unSuenio.realizar(persona)})
	}
}

