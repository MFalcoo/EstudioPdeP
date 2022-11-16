class Contenido{
	var vistas
	var property esOfensivo
	var formaMonetizacion
	
	method totalRecaudado(){
		formaMonetizacion.totalRecaudado(self,vistas)
	}
	
	method esPopular()
	
	method maximoArecaudar()
	
	method cambiarFormaMonetizacion(formaDeMonetizar){
		formaMonetizacion = formaDeMonetizar
	}
	method esVideo()
	
	method puedeAplicarse(){
		formaMonetizacion.puedeAplicarse(self)
	}
	
}

class Video inherits Contenido{
	override method esPopular(){
		return vistas>10000
	}
	override method maximoArecaudar(){
		return 10000
	}
	override method esVideo(){
		return true
	}

}

class Imagen inherits Contenido{
	var tags
	
	override method esPopular(){
		return tags.all({tag=>tag.esDeModa()})
	}
	override method maximoArecaudar(){
		return 4000
	}
	override method esVideo(){
		return false
	}

	
}