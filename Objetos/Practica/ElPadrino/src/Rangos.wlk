class Don {
	method sabeDespachar(){
		return true
	} 
	
	method usarArma(mafioso,don){
		don.subordinados().any().usarArma(mafioso)
	}
}

class Subjefe {
	
	method sabeDespachar(subjefe){
		return subjefe.algunSubordinadoConArmaSutil()
	}
	
	method algunSubordinadoConArmaSutil(){
		return subordinados.any({miembro=>miembro.tieneArmaSutil()})
	}
	
	method usarArma(mafioso,subjefe){
		const armaAusar = subjefe.armasNoUsadas().any().usarla(mafioso)
		subjefe.armasNoUsadas().remove(armaAusar)
	}
	
	method cambiarRango(rango,mafioso){
		if(!mafioso.sabeDespachar())
		throw new Exception (message = "No sabe despachar")
		mafioso.nuevoRango(rango)
	}
}

class Soldado {
	
	method sabeDespachar(soldado){
		return soldado.tieneArmaSutil()
	}
	
	
	method usarArma(mafioso,soldado){
		soldado.armas().head().usarla(mafioso)
	}
	
	method cambiarRango(rango,mafioso){
		mafioso.nuevoRango(rango)
		mafioso.vaciarSubordinados() 
	}
	
}