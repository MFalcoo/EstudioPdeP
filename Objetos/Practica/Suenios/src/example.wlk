class Pesrona{
	 const edad
	 const property carrerasQueQuierenEstudiar
	 const plataQueQuierenGanar
	 const lugaresQueQuierenViajar
	 var hijos 
	 var sueniosPorCumplir
	 var sueniosCumplidos
	 var carrerasCompletadas
	 var trabajoActual
	 const tipo
	 var felicidonios 
	 
	 method cumplir(unSuenio){
	 	self.validarSiPuedeCumplir(unSuenio)
	 	unSuenio.cumplir(self)
	 	sueniosPorCumplir.remove(unSuenio)
	 	sueniosCumplidos.add(unSuenio)
	 	self.sumarFelicidonios(cantidad)
	 }
	 
	 method validarSiPuedeCumplir(unSuenio){
	 	if(!sueniosPorCumplir.contains(unSuenio))
	 	throw new Exception (message="Ya esta cumplido")
	 }
	 method yaCompletoLaCarrera(carrera){
	 	carrerasCompletadas.contains(carrera)
	 }
	 
	 method completarCarrera(carrera){
	 	carrerasCompletadas.add(carrera)
	 }
	 method cambiarTrabajo(trabajo){
	 	trabajoActual = trabajo
	 }
	 
	 method tieneHijo(){
	 	return hijos.size()>0
	 }
	 
	 method nuevoHijo(hijo){
	 	hijos.add(hijo)
	 }
	 
	 method cumplirSuenioMasPreciado(){
	 	tipo.cumplirMeta(self)
	 }
	 
	 method suenioMasImportante(){
	 	return sueniosPorCumplir.sortedBy({uno,otro=> uno.felicidonios()>otro.felicidonios()}).head()
	 }
	 
	 method esFeliz(){
	 	return felicidonios> self.felicidoniosDeSueniosPendientes()
	 }
	 
	 method felicidoniosDeSueniosPendientes(){
	 	return sueniosPorCumplir.sum({unSuenio=>unSuenio.felicidonios()})
	 }
	 
	 method sumarFelicidonios(cantidad){
	 	felicidonios=+ cantidad
	 }
	 
	 method esAmbiciosa(){
	 	return self.sueniosAmbiciosos(sueniosPorCumplir) || self.sueniosAmbiciosos(sueniosCumplidos) 		
	 }
	 
	 method sueniosAmbiciosos(tipoDeSuenio){
	 	return tipoDeSuenio.filter({unSuenio=>unSuenio.esAmbicioso}).size()>3
	 }
	
	
}
