class Empleado {
	var property habilidades =[]
	var salud = 100
	var property rol = espia

	
	method estaIncapacitado(){
		return salud < rol.saludCritica()
	}
	
	method puedeUsarHabilidad(unaHabilidad){		
		return !self.estaIncapacitado() && habilidades.contains(unaHabilidad)
	}
	
	method cumplirMision(mision){
		if(!self.puedeCumplirMision(mision)){
			throw new Exception(message="No puede realizar la mision")
		}
		else mision.serCumplidoPor(self)
	}
	
	method completarMision(habilidadesRequeridas){
		if (self.sigueVivo()){
			rol.recompenza(self,habilidadesRequeridas)
		}
	}
	
	method puedeCumplirMision(mision){
		return habilidades.contains(mision.habilidadesRequeridas())
	}
	method sigueVivo(){
		return salud > 0
	}
	
	
	method recibirDanio(unDanio){
		salud =- unDanio
	}
	
	method adquirirHabilidad(unaHabilidad){
		habilidades.add(unaHabilidad)
	}
	
	method convertirseEnEspia(){
		rol = espia
	}
}

class Jefe inherits Empleado {
	const empleados = []
	
	override method puedeUsarHabilidad(unaHabilidad){
		return super(unaHabilidad) || self.algunoDeSusEmpleadosPuedeUsarHabilidad(unaHabilidad)
	}
	
	method algunoDeSusEmpleadosPuedeUsarHabilidad(unaHabilidad){
		return empleados.any({unEmpleado=>unEmpleado.puedeUsarHabilidad(unaHabilidad)})
	}

}

class Equipo {
	const empleados = []
	
	method puedeUsarHabilidad(unaHabilidad){
		return empleados.any({unEmpleado=>unEmpleado.puedeUsarHabilidad(unaHabilidad)})
	}
	
	method recibirDanio(cantidad){
		empleados.forEach({empleado=>empleado.recibirDanio(cantidad/3)})
	}
	
	method completarMision(mision){
		empleados.forEach({empleado=>empleado.completarMision(mision)})
	}
}




object espia {
	method saludCritica(){
		return 15
	}
	method recompenza(empleado,habilidades){
		const habilidadesQueNoPosee = habilidades.filter({unaHab=>!empleado.habilidades().contains(unaHab)})
		habilidadesQueNoPosee.forEach({unaHabilidad=>empleado.adquirirHabilidad(unaHabilidad)})
	}
	
}

object oficinista {
	var estrellas = 0
	
	method saludCritica(){
		return 40 - 5*estrellas
	}
		method recompenza(empleado,_habilidades){
		estrellas += 1
		if(!self.tieneTresEstrellas())
		empleado.convertirseEnEspia()
	}
	method tieneTresEstrellas(){
		return estrellas == 3
	}

	
}