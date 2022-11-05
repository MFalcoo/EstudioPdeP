object publicidad {
	
	method recaudacionDe(contenido){
		return (0.5*contenido.visitas() + 
		if(contenido.esPopular()) 2000).min(maximoArecaudarPorPublicidad(contenido))
		
	}
	method maximoArecaudarPorPublicidad(contenido){
		return contenido.maximaRecaudacionPorPubli()
	}
	method permiteCambio(contenido){
		return contenido.esOfensivo()
	}
	
}

class Donaciones{
	var totalDonaciones
	
	method recaudacionDe(contenido){
		return totalDonaciones
	}
	
	method sumarDonacion(monto){
		totalDonaciones += monto
	}
	method permiteCambio(contenido){
		return true
	}
}

class VentadeDescarga {
	const precio
	var descargas
	
	method recaudacionDe(contenido){
		return precio*contenido.visitas()
	}
	method permiteCambio(contenido){
		return contenido.puedeVenderse()
	}
	
}

class Alquiler inherits VentadeDescarga{
	override method precio() = 1.max(super())
	override method permiteCambio(contenido){
		super(conteniod) && contenido.puedeAlquilarse()
	}
}


