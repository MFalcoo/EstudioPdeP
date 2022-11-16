class Revolver {
	var balasRestantes
		
	method esSutil(){
		return balasRestantes.equals(1)
	} 
	
	method usarla(mafioso){
		if(balasRestantes>0){
		mafioso.morir()
		balasRestantes --
		}
		
		
	}	
	
	
}

object escopeta {
	method esSutil(){
		return false
	} 
	method usarla(mafioso){
		if(mafioso.estaHerido()){
		mafioso.morir()
		mafioso.herir()
		}
		
	}
}

class CuerdaDePiano{
	const esDeCalidad 
	
	method esSutil(){
		return true
	} 
	method usarla(mafioso){
		if(esDeCalidad){
		mafioso.morir()
		}
		
	}
}