class Legion {
	var niniosOLegiones
	
	method capacidadDeAsustar(){
		return niniosOLegiones.sum({ninio=>ninio.capacidadDeAsustar()})
	}
	
	method cantidadDeCaramelos(){
		return niniosOLegiones.sum({ninio=>ninio.caramelos()})
	}
	
	method intentarAsustar(adulto){
		const unosCaramelos = adulto.asustarse(self.capacidadDeAsustar())
		self.aumentarCaramelosDelLider(unosCaramelos)
	} 
	
	method aumentarCaramelosDelLider(unosCaramelos){
		self.lider().sumarCaramelos(unosCaramelos)
	}
	
	method lider(){
		return niniosOLegiones.max({ninio=>ninio.capacidadDeAsustar()})
	}
}

object creadorDeLegiones{
	
	method crearLegion(grupo){
		if(!self.estaFormadoPorMasDeDos(grupo))
			throw new Exception (message="No se puede crear legion")
			return new Legion (niniosOLegiones = grupo)
	}
	
	method estaFormadoPorMasDeDos(grupo){
		return grupo.size()>=2
	}
}
