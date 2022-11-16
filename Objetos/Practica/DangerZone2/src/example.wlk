class Empleado{
	var habilidades
	var salud

	
	var rango
	
	
	method estaIncapacitado(){
		rango.estaIncapacitado(salud)
	}
	
	method puedeUsar(habilidad){
		return !self.estaIncapacitado() && self.tieneHabilidad(habilidad)
	}
	
	method tieneHabilidad(habilidad){
		 return habilidades.contains(habilidad)
	 }
	
	method cumplirMision(mision){
		self.validarQueReuneHabilidadesRequeridas(mision)
		mision.cumplirse(self)
	}
	
	method validarQueReuneHabilidadesRequeridas(mision){
		const habilidadesRequeridas = mision.habilidadesRequeridas()
		if(!self.contiene(habilidadesRequeridas))
		throw new Exception (message="No contiene habilidades necesarias")
		
	}
	method contiene(habilidadesRequeridas){
		return habilidadesRequeridas.forEach({habilidad=>self.puedeUsar(habilidad)})
	}
	
	method recibirDanio(unDanio){
		salud =-unDanio
	}
	
	method registrarMision(mision){
		if(self.sigueVivo())
		rango.registrar(mision,self)
	}
	
	method sigueVivo(){
		return salud>0
	}
	
	method aprenderHabilidadesQueNoPosee(habilidadesDeMision){
		habilidadesDeMision.forEach({unaHabilidad=>self.aprenderUnaHabilidad(unaHabilidad)})
	}
	
	method aprenderUnaHabilidad(unaHabilidad){
		if(!self.tieneHabilidad(unaHabilidad))
		habilidades.add(unaHabilidad)
	}
	
	method convertirseEnEspia(){
		rango = espia
	}
	
}

class Jefe inherits Empleado {
	var subordinados
	
	override method puedeUsar(habilidad){
		return super(habilidad) || self.subordinadoPuedeUsar(habilidad)
	}
	
	method subordinadoPuedeUsar(habilidad){
		return subordinados.any({empleado=>empleado.puedeUsar(habilidad)})
	}
	
}

