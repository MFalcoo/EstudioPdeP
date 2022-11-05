class Contenido {
	const titulo
	var property visitas = 0
	const property esOfensivo = false
	var cotizacion
	const maximoPubli

	method esPopular()
	
	method recaudacion(){
		cotizacion.recaudacionDe(self)
	}
	method maximaRecaudacionPorPubli(maximoPubli){
		return maximoPubli
	}
	method hacerDonacion(monto){
		cotizacion.sumarDonacion(monto)
	}
	method cambiarCotizacion(cotizacion){
		cotizacion= cotiizacion
	}

	method consultarCambio(cotizacion,contenido){
		return cotizacion.permiteCambio(contenido)
	}
	method puedeVenderse(){
		return self.esPopular()
	}
	method puedeAlquilarse()
}

class Video inherits Contenido (maximoPubli= 10000){
	override method esPopular(){
		return visitas>10000
	}
	override method puedeAlquilarse(){
		return true
	}
}

class Imagen inherits Contenido(maximoPubli= 4000){
	var tags 
	override method esPopular(){
		return tags.all({unTag=>unTag.tipo()==moda})
	}
	 
	method agregarTag(unTag){
		tags.add(unTag)
	}
	override method puedeAlquilarse(){
		return false
	}

}
