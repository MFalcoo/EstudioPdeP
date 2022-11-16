class Ninio{
	var property caramelos
	var property elementos
	var actitudDelNinioOriginal
	var estadoDeSalud = sano
	var puedeComer = true
	
	
	method capacidadDeAsustar(){
		return estadoDeSalud.actitudDelNinio(actitudDelNinioOriginal)*self.sumaDeSustosDeElementos()
	}
	
	method sumaDeSustosDeElementos(){
		return elementos.sum({elemento=>elemento.cuantoAsusta()})
	}
	
	method intentarAsustar(adulto){
		const caramelosDados = adulto.asustarse(self.capacidadDeAsustar())
		self.sumarCaramelos(caramelosDados)
	}
	
	method sumarCaramelos(unosCaramelos){
		caramelos=+ unosCaramelos
	}
	
	method tieneMasDe(cantidad){
		return caramelos > 15
	}
	
	method comerCaramelos(cantidad){
		self.validarSipuedeComerCaramelos(cantidad)
		estadoDeSalud.comerCaramelos(cantidad,self)
		self.reducirCaramelos(cantidad)
	}
	
	method validarSipuedeComerCaramelos(cantidad){
		if (caramelos < cantidad || !puedeComer)
		throw new Exception(message="No puede comer")
	}
	
	method reducirCaramelos(cantidad){
		caramelos =- cantidad
	}
	
	method cambiarSalud(estado){
		estadoDeSalud = estado
	}
}
