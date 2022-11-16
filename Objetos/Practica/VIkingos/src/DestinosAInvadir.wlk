class Capital {
	const defensores
	const factorRiqueza
	
	method valeLaPena(cantInvasores){
		return (self.tresMonedasParaCadaVikingo(cantInvasores))
	}
	
	method tresMonedasParaCadaVikingo(cantInvasores){
		return (self.botin()/cantInvasores) >= 3
	}
	
	method botin(){
		return defensores*factorRiqueza
	}
	
	method serInvadida(vikingos){
		vikingos.forEach({vikingo=>vikingo.repercucionesDeExpedicion(self.botin()/vikingos.size(),1)})
		
	}
	
	
	
}

class Aldea {
	const crucifijos
	
	method valeLaPena(cantInvasores){
		return self.saciaSedDeSaqueo()	
	}
	
	method saciaSedDeSaqueo(){
		return self.botin() > 15
	}

	method botin(){
		return crucifijos
	}
	method serInvadida(vikingos){
		vikingos.forEach({vikingo=>vikingo.repercucionesDeExpedicion(self.botin()/vikingos.size(),0)})
		
	}
}

class AldeaAmurallada inherits Aldea{
	const vikingosMinimos
	
	override method valeLaPena(cantInvasores){
		return super(cantInvasores) && cantInvasores >= vikingosMinimos
	}
}


