class Mision {
	const property habilidadesRequeridas
	const peligrosidad
	
	method cumplirse(empleadooEquipo){
		empleadooEquipo.recibirDanio(peligrosidad)
		empleadooEquipo.registrarMision(self)
	}
	
}
