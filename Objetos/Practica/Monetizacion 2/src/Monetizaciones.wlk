object publicidad {
	
	method totalRecaudado(contenido,vistas){
		if(!contenido.esPopular()){
			const maximo = contenido.maximoArecaudar()
			return self.dineroRecaudadoConPlus(vistas,maximo,2000)
		}
		return self.dineroRecaudadoConPlus(vistas,maximo,0)
	}
	
	method dineroRecaudadoConPlus(vistas,maximo,cantidad){
		return maximo.min(vistas*0.05+cantidad)
	}
	
	method puedeAplicarse(contenido){
		return !contenido.esOfensivo()
	}
		
}

class Donacion{
	var montoAcumulado
	
	method totalRecaudado(_contenido,_vistas){
		return montoAcumulado
	}
	
	method recibirDonacion(cantidad){
		montoAcumulado =+cantidad
	}
	method puedeAplicarse(contenido){
		return true
	}
		
	
}

class VentaDescarga{
	const precioFijo
	
	method totalRecaudado(contenido,vistas){
		return  5.max(precioFijo*vistas)
	}
	method puedeAplicarse(contenido){
		return contenido.esPopular()
	}
		
	
	
}

class Alquiler inherits VentaDescarga{
	
	override method totalRecaudado(contenido,vistas){
		return 1.max(precioFijo*vistas)
	}
	override method puedeAplicarse(contenido){
		return super(contenido) && contenido.esVideo()
	}
	
}
