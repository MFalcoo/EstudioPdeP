class Arma {
	
	
}

class Revolver{
	var balas
	
	method esSutil(){
		return self.leQuedaUnaBala()
	}
	
	method leQuedaUnaBala(){
		return balas.equals(1)
	}
	
	method usarse(persona){
		if(balas>0)
		persona.morir()
		balas --
	}
}

object escopeta {
	
	method usarse(persona){
		persona.herise()
	}
	
}

class cuerdaPiano {
	var esDeCalidad
	
	
	method esSutil(){
		return true
	}
	
	method usarse(persona){
		if(esDeCalidad)
		persona.morir()
	}
	
}
