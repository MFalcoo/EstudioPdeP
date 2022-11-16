class Barrio {
	var habitantes
	
	method tresNiniosConMasCaramelos(){
		return self.habitantesOrdenadosPorMasCaramelos().take(3)
	}
	
	method habitantesOrdenadosPorMasCaramelos(){
		return habitantes.sortedBy({uno,otro=>uno.caramelos()>otro.caramelos()})
	}
	
	method elementosUsadosPorNiniosCaramelosos(){
		return self.habitantesConMasDeDiezCaramelos().flatMap({ninio=>ninio.elementos()}).withOutDuplicates()
	}
	 
	method habitantesConMasDeDiezCaramelos(){
		return habitantes.filter({ninio=>ninio.tieneMasDe(10)})
	}
}
