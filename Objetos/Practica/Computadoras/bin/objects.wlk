object standar {
	
	method consumoDeEnergia(consumoBase){
		return consumoBase
	}
	method computoProducido(equipo){
		return equipo.produccionBase()
	}
	method realizoComputo(problema){}
}

class Overclock{
	var usosRestantes
	
	method consumoDeEnergia(consumoBase){
		return consumoBase*2
	}
	method computoProducido(equipo){
		return equipo.produccionBase() + equipo.computoExtraPorOverclock()
	}
	method realizoComputo(equipo){
		if(usosRestantes ==0){
		 equipo.estaQuemado(true)
		throw new Exception (message = "Equipo Quemado")}
		usosRestantes -= 1
	}
	
}

class Ahorro {
	var computosRealizados
	var periodoDeError  
	method consumoDeEnergia(consumoBase){
		return 200
	}
	method computoProducido(equipo){
		return equipo.consumoBase()/ self.consumoDeEnergia() * equipo.produccionBase()	
	}
	method realizoComputo(equipo){
		 computosRealizados =+1
		 if(computosRealizados % periodoDeError == 0) throw new Exception (message = "Corriendo Monitor") 
	}
}

object ahorroDeEnergia inherits Ahorro (computosRealizados = 0,periodoDeError = 17) {}

object aPruebaDeFallos inherits Ahorro (computosRealizados = 0,periodoDeError = 100) {
	
	override method computoProduccion(equipo) {
		return super(equipo)/2
	}	
}
