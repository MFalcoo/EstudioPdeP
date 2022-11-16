class Equipo{
	const miembros
	
	
	method cumplirMision(mision){
		self.validarQueReuneHabilidadesRequeridas(mision)
		mision.cumplirse(self)
	}	
	method validarQueReuneHabilidadesRequeridas(mision){
		const habilidadesRequeridas = mision.habilidadesRequeridas()
		if(!self.algunMiembroContiene(habilidadesRequeridas))
		throw new Exception (message="No contiene habilidades necesarias")
	}
	
	method algunMiembroContiene(habilidadesRequeridas){
		return miembros.any({miembro=>miembro.contiene(habilidadesRequeridas)})
	}
	method recibirDanio(peligrosidad){
		miembros.forEach({miembro=>miembro.recibirDanio(peligrosidad/3)})
	}
	method registrarMision(mision){
		miembros.forEach({miembro=>miembro.registrarMision(mision)})
	}
	
}
