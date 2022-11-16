class Familia {
	var miembros
	var don
	const traiciones
	
	method mafiosoMasArmadoDeLaFamilia(){
		return miembros.max({miembro=>miembro.cantidadDeArmas()})
	}
	
	method repartirArmas(){
		miembros.forEach({miembro=>miembro.recibirArma(new Revolver(balas=6))})
	}
	
	method atacar(otraFamilia){
		self.integrantesVivos().forEach({miembro=>miembro.atacarFamilia(otraFamilia)})
	}
	
	method integrantesVivos(){
		return miembros.filter({miembro=>miembro.estaVivo()})
	}
	
	method nadieVivo(){
		return miembros.all({miembro=>miembro.estaMuerto()})
	}
	
	method integranteVivoMasPeligroso(){
		return self.integrantesVivos()
		.sortedBy({uno,otro=>uno.cantidadDeArmas()>otro.cantidadDeArmas()})	
		.take(1)
	}
	
	method reorganizarse(){
		self.integrantesVivos().forEach({miembro=>miembro.escalar()})
		const posibleDon = self.buscarNuevoDon()
		posibleDon.ascenderADon()	
	}
	
	method buscarNuevoDon(){
		const candidato = don.subordinadoMasLeal()
		return self.validarSiPuedeSerDon(candidato)
	}
	
	method validarSiPuedeSerDon(candidato){
		if(!candidato.rango().sabeDespacha(candidato)){
			don.subordinados().remove(candidato)
			return self.buscarNuevoDon()
		}
		else 
		return candidato
	}
	
	method nuevoDon(nuevoDon){
		don = nuevoDon
	}
	
	method lealtadPromedio(){
		return self.integrantesVivos().sum({miembro=>miembro.lealtadFamilia()})/
					self.integrantesVivos().size()
	}
	
	method ajusticiar(traidor,traicion){
		self.irse(traidor)
		traiciones.add(traicion)
	}
	
	method irseYregistrarTraicion(traidor,traicion){
		self.irse(traidor)
		traiciones.add(traicion)
	} 
	
	method irse(miembro){
		miembros.remove(miembro)
	}
	
	method incorporarloConMaxLealtad(miembro){
		miembros.add(miembro)
		miembro.maximaLealtad()
	}
}
