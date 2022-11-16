class Espia {
	
	
	method saludCritica(){
		return 15
	}
	
	method estaIncapacitado(salud){
		return salud < self.saludCritica()
	}
	
	method registrar(mision,empleado){
		empleado.aprenderHabilidadesQueNoPosee(mision.habilidadesRequeridas())
	}
	
}

class OFicinista{
	var estrellas
	
	method saludCritica(){
		return 40 - 5* estrellas
	}
	
	method estaIncapacitado(salud){
		return salud < self.saludCritica()
	}
	
	method registrar(_mision,empleado){
		self.adquirirEstrella(empleado)
	}
	
	method adquirirEstrella(empleado){
		estrellas ++
		if(estrellas.equals(3))
		empleado.convertirseEnEspia()
	}
	
	
}
