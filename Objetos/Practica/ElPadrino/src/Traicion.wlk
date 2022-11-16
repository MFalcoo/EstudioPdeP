class Traicion {
	var fechaDeTraicion
	const victimas
	
	method agregarVictima(victima){
		victimas.add(victima)
	}
	
	method adelantarFecha(cuantosDias){
		fechaDeTraicion =- cuantosDias
	}
	
	method concretarse(traidor,nuevaFamilia){
		victimas.forEach({victima=>traidor.usarArma(victima)})
		traidor.irseDeLaFamilia()
		traidor.incorporarseA(nuevaFamilia)
	}
	
	
}
