class Traicion {
	const miembrosAtacados
	var fecha = new Date()
	const traidor
	const nuevaFamilia
	
	method seComplica(otroMiembro,unosDias){
		miembrosAtacados.add(otroMiembro)
		self.adelantarFecha(unosDias)
	}
	
	method adelantarFecha(unosDias){
		fecha =- unosDias
	}
	
	method concretarse(){
		const familiaDeAtacados = miembrosAtacados.anyOne().familia()
		if(familiaDeAtacados.lealtadPromedio()> 2* traidor.lealtadFamilia()){
			self.serAjusticiado(familiaDelAtacado)
		}else{
			self.concretarTraicion()
		}
	}
	
	method serAjusticiado(familiaDelAtacado){
		familiaDelAtacado.ajusticiar(traidor,self)
	}
	
	method concretarTraicion(){
		traidor.asesinar(miembrosAtacados)
		traidor.cambiarDeFamilia(nuevaFamilia,self)
	}
	
}
