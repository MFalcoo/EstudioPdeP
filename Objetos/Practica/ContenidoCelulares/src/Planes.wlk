object prepago {
	

	method cargoPorPlan(){
		return 10/100
	}
	
	method puedeDescargar(precio,saldo){
		return precio<=saldo
	}
	
	method cobrarDescarga(usuario,precio){
		usuario.restarSaldo(precio)
	}
	
}

object facturado{
	var montoAcumulado = 0
	
	method cargoPorPlan(){
		return 0
	}
	method puedeDescargar(precio,saldo){
		return true
	}
	method cobrarDescarga(usuario,precio){
		self.acumularMonto(precio)	
	}
	
	method acumularMonto(precio){
		montoAcumulado =+ precio
	}
}