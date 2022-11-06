class SuperCompu {
	var equipos = []
	var totalDeComplejidadComputada=0
	
	method equiposActivos() {
		return equipos.filter({unEquipo=> unEquipo.estaActivo()})
	}
	method capacidadConsumo(){
		return self.equiposActivos().sum({unEquipo=>unEquipo.consumoDeEnergia()})
	}
	method capacidadComputo(){
		return self.equiposActivos().sum({unEquipo=>unEquipo.computoProducido()})
	}
	method malConfigurada(){
		return self.equipoQueMasConsume() != self.equipoQueMasProduce()
	}
	method equipoQueMasConsume(){
		return equipos.sortedBy({uno,otro=>uno.consumoDeEnergia()>otro.ConsumoDeEnergia()}).take(1)
		//return equipos.max({unEquipo=> unEquipo.consumoDeEnergia()})
	}
	method equipoQueMasProduce(){
		return equipos.sortedBy({uno,otro=>uno.computoProducido()>otro.computoProducido()}).take(1)
	}
	method computarProblema(problema){
		var problemaDividido = problema/self.equiposActivos().size()
		self.equiposActivos.forEach({unEquipo=>unEquipo.procesarSubProblema(problemaDividido)})
		totalDeComplejidadComputada += problema
	}
}
