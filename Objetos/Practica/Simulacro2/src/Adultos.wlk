class AdultoComun {
	var niniosQueIntentaronAsustarlo
	
	method asustarse(unNinio){
		self.sumarIntentoSiAplica(unNinio)
		if(self.seAsusta(unNinio.capacidadDelSusto())){
			return self.cantidadDeCaramelosADar()
			}
	}
	
	method sumarIntentoSiAplica(unNinio){
		if(unNinio.tieneMasDe(15))
		niniosQueIntentaronAsustarlo ++
	}
	
	method cantidadDeCaramelosADar(){
		return self.tolerancia()/2
	}
	
	method tolerancia(){
		return 10* niniosQueIntentaronAsustarlo
	}
	
	method seAsusta(unNinio){
		return self.tolerancia()<unNinio.capacidadDelSusto() 
	}
}

class Abuelo inherits AdultoComun{
	
	override method seAsusta(unNinio){
		return true
	}
	
	override method cantidadDeCaramelosADar(){
		return super()/2
	}
}

class Necio {
	
	method asustarse(unNinio){
		return 0
	}
}