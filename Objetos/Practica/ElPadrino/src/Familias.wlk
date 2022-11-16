class Familia {
	var property miembros
	var traidores 
	
	method mafiosoMasArmado(){
		return self.miembrosVivos().max({miembro=>miembro.cantidadDeArmas()})
	}
	
	method distribuirArmas(){
		self.miembrosVivos().forEach({miembro=>miembro.recibirArma(new Revolver (balasRestantes = 6))})
	}
	
	method miembrosVivos(){
		return miembros.filter({miembro=>!miembro.estaMuerto()})
	}
	
	method atacarA(familia){
		if(familia.algunoVivo()){
		self.miembrosVivos().forEach({miembro=>miembro.hacerSuTrabajo(familia)})
	}
	
}

	method algunoVivo(){
		return miembros.any({miembro=>!miembro.estaMuerto()})
	}
	
	method reorganizarse(){
		self.soldadosConMasDeCincoArmas().forEach({miembro=>miembro.cambiarRango(subjefe)})
		self.subordinadoMasLealDelDifunto().cambiarRango(don)
		miembros.forEach({miembro=>miembro.aumentarLealtad(10))
	}
	
	method subordinadoMasLealDelDifunto(){
		return miembros.max({miembro=>miembro.lealtadAFamilia()})
	}
	
	
	method soldadosConMasDeCincoArmas(){
		return self.soldados().filter({miembro=>miembro.tieneMasDeCincoArmas()})
	}
	
	method soldados(){
		return miembros.filter({miembro=>miembro.esRango(soldado)})
	}
	method victima(traidor){
		const victima = miembros.any()
		if (victima != traidor)
		return victima
		else 
		self.victima(traidor)
	}
	
	method agregarTraidor(traidor){
		miembros.add(traidor)
		self.establecerloComoSoldadoDeMaximaLealtad(traidor)
	}
	method establecerloComoSoldadoDeMaximaLealtad(traidor){
		traidor.nuevoRango(soldado)
		traidor.elevarLealtadAlMaximo()
	}
	
	method removerDeLaFamilia(traidor){
		miembros.remove(traidor)
		self.conservarEnMemoria(traidor)
	}
	method conservarEnMemoria(traidor){
		traidores.add(traidor)
	}

}

class Miembro{
	var property lealtadAFamilia
	var property armas
	var property armasNoUsadas
	var property subordinados
	var estaMuerto
	var property rango
	var property estaHerido
	var property familia
	var traicion
	
	
	method herir(){
		estaHerido = true
	}
	
	method durmiendoConLosPeces(){
		return estaMuerto
	}
	
	method cantidadDeArmas(){
		armas.size()
	}
	
	method recibirArma(arma){
		armas.add(arma)
	}
	
	method sabeDespachar(){
		rango.sabeDespachar(self)
	}
	
	method tieneArmaSutil(){
		return armas.any({arma=>arma.esSutil()})
	}
	
	method hacerSuTrabajo(unaFamilia){
		const mafiosoAAtacar = unaFamilia.mafiosoMasArmado()
		rango.usarArma(mafiosoAAtacar)
	}
	
	method usarArma(mafioso){
		rango.usarArma(self)
		mafioso.morir()
	}
	
	method morir(){
		estaMuerto = true
	}
	
	method algunSubordinadoConArmaSutil(){
		return subordinados.any({miembro=>miembro.tieneArmaSutil()})
	}
	method esRango(unRango){
		return rango.equals(unRango)
	}
	method tieneMasDeCincoArmas(){
		return armas.size()>5	
	}	
	
	method cambiarRango(unRango){
		rango.cambiarRango(unRango,self)
	}
	
	method nuevoRango(unRango){
		rango = unRango
	}
	
	method vaciarSubordinados(){
		subordinados = []
	}
	method aumentarLealtad(cuanto){
		lealtadAFamilia =+ lealtadAFamilia * cuanto/100
	}
	
	
	method iniciarTraicion(diasParaLaTraicion){
		traicion = new Traicion (fechaDeTraicion = diasParaLaTraicion,victima=self.seleccionDeVictima())
		
	}
	
	method seleccionDeVictima(){
		return familia.victima(self)	
	}
	
	method adelantarFechaDeTraicion(cuantosDias){
		traicion.adelantarFecha(cuantosDias)
		traicion.agregarVictima(self.seleccionDeVictima())
	}
	
	method realizarTraicion(nuevaFamilia){
		if(familia.lealtadPromedio()>lealtadAFamilia*2){
		familia.conservarEnMemoria(self)
		throw new Exception (message="Ajusticiado")
		}
		traicion.concretarse(self,nuevaFamilia)
	}
	method irseDeLaFamilia(){
		familia.removerDeLaFamilia(self)
	}
	method incorporarseA(nuevaFamilia){
		nuevaFamilia.agregarTraidor(self)
		familia = nuevaFamilia
	}
	
	method elevarLealtadAlMaximo(){
		lealtadAFamilia = 100
	}
}



object donVito inherits Don (armas=[],lealtadAFamilia=100,subordinados = [],estaMuerto=false) {
		
	override method hacerSuTrabajo(unaFamilia){
		2.times(super())
	}
}

class Subjefe inherits Miembro{
	var armasNoUsadas
	
	
	override method usarArma(mafiosoAAtacar){
		const armaAusar = armasNoUsadas.any().usarla()
		armasNoUsadas.remove(armaAusar)
		}
	}
	
	
}

class Soldado inherits Miembro (armas=[new escopeta()],subordinados=[]){
	override method sabeDespachar(){
		return self.tieneArmaSutil()
	}
	
	
	override method usarArma(mafioso){
		armas.head().usarla()
	}
	
}