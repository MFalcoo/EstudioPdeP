object empresa{
	const usuarios= [] 
	const productos = []
	
	method conocerPrecio(producto,plan){
		if(plan.equals(prepago)){
		return self.montoFinal(producto)* plan.cargoPorPlan()
		}
		return self.montoFinal(producto)
	}
	
	method montoFinal(producto){
		const montoFijo = producto.montoDerechoAutor()
		return montoFijo+  
		+ producto.compania().cobroPorServicio(montoFijo) 
		+ montoFijo * 0.25
	}
	
	method registrarDescarga(usuario,producto){
		if(!usuario.puedeDescargar(producto))
		throw new Exception (message="no puede descargar el producto")
		usuario.descargarCopia(producto,self.montoFinal(producto))
		
	}
	method cuantoGastoEnDescargas(usuario){
		return usuario.gastoTotalEnDescargas()
	}
	
	method productoMasDescargado(){
		const listaDeTodasLasDescargas =
			 usuarios.map({usuario=>usuario.descargas()}).flatten()
		return listaDeTodasLasDescargas.max({producto=>listaDeTodasLasDescargas.ocurrenceOf(producto)})
	}

	
}



object companiaNacional{
	
	method cobroPorServicio(cobroAutor){
		return cobroAutor*5/100
	}
	
		
}

class companiaExtranjera{
	const impuesto
	
	method cobroPorServicio(cobroAutor){
		return cobroAutor*5/100 + impuesto
	}
	
		
}
