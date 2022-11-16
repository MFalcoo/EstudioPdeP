class usuario{
	const empresa
	var plan
	var saldo
	var property descargas
	var mesActual
		
	method consultarPrecioDescarga(producto){
		return empresa.conocerPrecio(producto,plan)
	}
	
	method descargarProducto(producto){
		empresa.registrarDescarga(self,producto)
	}
	method puedeDescargar(producto){
		const precioProducto = self.consultarPrecioDescarga(producto)
		plan.puedeDescargar(precioProducto,saldo)
	}
	
	method descargarCopia(producto,precioProducto){
		self.registrarDescarga(producto)
		plan.cobrarDescarga(self,precioProducto)
	}
	
	method registrarDescarga(producto){
		descargas.add(producto)
	}
	
	method restarSaldo(precio){
		saldo =- precio
	}
	
	method gastoTotalEnDescargas(){
		return self.descargasDelMes().sum({producto=>self.consultarPrecioDescarga(producto)})
	}
	
	method descargasDelMes(){
		return descargas.filter({producto=>producto.fechaCompra().equals(mesActual)})
	}
	
	method esColgado(){
		return descargas.all({producto=>descargas.ocurrencesOf(producto).equals(1)})
	}
}
