class Equipo {
	var property consumoBase
	var property produccionBase
	var modo 
	var property estaQuemado = false
	
	method consumoDeEnergia(){
		return modo.consumoDeEnergia(consumoBase
	}
	method computoProducido(){
		return modo.computoProducido(self)
	}	
	method cambiarModo(unModo){
		modo=unModo
	}	
	method estaActivo(){
		return !self.estaQuemado() && self.computoProducido > 0
	}
	method computoExtraPorOverclock()
	method procesarSubProblema(problema){
		if(problema > self.computoProducido){throw new Exception(message="Capacidad Excedida")}
		modo.realizoComputo(self)
	}
}

class A105 inherits Equipo (consumoBase = 300, produccionBase = 600){
	override method computoExtraPorOverclock() {
		return produccionBase* 0.3
	}
	override method procesarSubProblema(problema){
		if(problema < 5 ){throw new Exception(message="Error Minimo")}
		super(problema)
	}	
}

class B2 inherits Equipo (consumoBase = 50, produccionBase = 100){
	var cantidadDeChips = []
	
	override method consumoBase(){
		return modo.consumoDeEnergia(cantidadDeChips*consumoBase+10)
	}
	override method computoExtraPorOverclock() {
		return 20*cantidadDeChips
	}
	override method produccionBase(){
		return produccionBase * cantidadDeChips +10
	}
}
