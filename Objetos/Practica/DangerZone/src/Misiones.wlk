class Mision {
	const property habilidadesRequeridas 
	const danioProducido
	
	method serCumplidoPor(empleado){
		if (!self.reuneHabilidadesRequeridas(empleado))
		throw new Exception (message="La mision no se puede cumplir") 
		empleado.recibirDanio(danioProducido)
		empleado.completarMision(habilidadesRequeridas)
	}
	
	method reuneHabilidadesRequeridas(empleado){
		habilidadesRequeridas.all({unaHabilidad=>empleado.puedeUsarHabilidad()})
	}
}
