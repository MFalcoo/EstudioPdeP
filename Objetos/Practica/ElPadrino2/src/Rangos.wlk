class Don {
	var subordinados
	
	method sabeDespachar(_mafioso){
		return true
	}
	
	method hacerSuTrabajo(persona,mafioso){
		subordinados.anyOne().hacerSuTrabajo(persona)
	}
	method escalar(_soldado){}
	
	method subordinadoMasLeal(){
		return subordinados.max({miembro=>miembro.lealtadFamilia()})
	}
}

class Subjefe{
	var property subordinados = []
	const armasUsadas = []
	
	method sabeDespachar(_mafioso){
		return subordinados.any({miembro=>miembro.tieneArmaSutil()})
	}
	method hacerSuTrabajo(persona,mafioso){
		const armaNoUsada = mafioso.armaNoUsada(armasUsadas)
		mafioso.usarArma(armaNoUsada,persona)
		armasUsadas.add(armaNoUsada)
		
	}
	method escalar(_soldado){}
}

class Soldado {
	
	method sabeDespachar(mafioso){
		return mafioso.tieneArmaSutil()
	}
	method hacerSuTrabajo(persona,mafioso){
		const armaMasAMano = mafioso.armaAMano()
		mafioso.usarArma(armaMasAMano,persona)
	}
	
	method escalar(soldado){
		if(soldado.estaArmado())
		soldado.promoverASubjefe()
	}
}
