class Persona {
	var property nivelDeFelicidad = 100
	var emocionDominante 
	var recuerdosDelDia = []
	const pensamientosCentrales =[]
	const procesosAlDormir 
	var memoriaLargoPlazo
	var edad
	var pensamientoActual
	
	method vivirUnEvento(unaDescripcion){
		const recuerdo = new Recuerdo(descripcion= unaDescripcion, fecha = new Date(), emocionDelRecuerdo= emocionDominante)
		recuerdosDelDia.add(recuerdo)
	}
	
	method asentarRecuerdo(recuerdo){
		emocionDominante.asentar(self,recuerdo)
	}
	
	method convertirAPensamientoCentral(recuerdo){
		pensamientosCentrales.add(recuerdo)
	}
	
	method disminuirFelicidad(porcentaje){
		nivelDeFelicidad =- nivelDeFelicidad*porcentaje/100
		self.validarQueNoEntristecio()
	}
	
	method validarQueNoEntristecio(){
		if(nivelDeFelicidad < 1)
		throw new Exception(message="No puede estar tan triste")
	}
	
	method recuerdosRecientesDelDia(){
		return recuerdosDelDia.reverse().take(5)
	}
	
	method conocerPensamientosCentrales(){
		return pensamientosCentrales.withoutDuplicates() 
	}
	
	method pensamientosCentralesDificilesDeExplicar(){
		return pensamientosCentrales.filter({recuerdo=>recuerdo.esDificilDeExplicar()})
	}
	
	method niega(recuerdo){
		return emocionDominante.niega(recuerdo.emocionDelRecuerdo())
	}
	
	method dormir(){
		procesosAlDormir.forEach({proceso=>proceso.apply()})
	}
	
	method asentamientoSelectivo(palabraClave){
			const recuerdosConPalabraClave = recuerdosDelDia().filter
		({recuerdo=>recuerdo.contienePalabra(palabraClave)})
		self.asentarRecuerdos(recuerdosConPalabraClave)
	}
	
	method profundizar(){
		recuerdosDelDia.filter({recuerdo=>!pensamientosCentrales.contains(recuerdo)
		&&!self.niega(recuerdo)}).forEach({unRecuerdo=>self.agregarAMemoriaLargoPlazo(unRecuerdo)})
	}
	
	method controlHormonal(){
		if(self.detectarControl()){
		self.disminuirFelicidad(15)
		3.times({self.perderPensamientosCentralMasAntiguo()})
		}
	}
	
	method asentarRecuerdos(recuerdos){
		recuerdos.forEach({recuerdo=>self.asentarRecuerdo(recuerdo)})
	}
	

	method agregarAMemoriaLargoPlazo(unRecuerdo){
		memoriaLargoPlazo.add(unRecuerdo)
	}
	
	method perderPensamientosCentralMasAntiguo(){
		const pensamientoMasAntiguo = pensamientosCentrales.sortedBy({uno,otro=>uno.fecha()<otro.fecha()}).fisrt()
		pensamientosCentrales.remove(pensamientoMasAntiguo)
	}
	
	method detectarControl(){
		return self.unPensamientoCentralEnMemoriaLargoPlazo() ||
			 self.todosLosRecuerdosDelDiaPresentanMismaEmocion()
	}
	
	method unPensamientoCentralEnMemoriaLargoPlazo(){
		return pensamientosCentrales.any({recuerdo=>memoriaLargoPlazo.contains(recuerdo)})
	}
	
	method todosLosRecuerdosDelDiaPresentanMismaEmocion(){
		const emocionComun= recuerdosDelDia.anyOne().emocionDelRecuerdo()
		return recuerdosDelDia.all({recuerdo=>recuerdo.emocionDelRecuerdo().equals(emocionComun)})
	}
	
	method amuentarFelicidad(){
		nivelDeFelicidad=+ 100.min(self.cuantoLeFaltaParaMil())
	}
	
	method cuantoLeFaltaParaMil(){
		return 1000-nivelDeFelicidad
	}
	
	method liberacionRecuerdosDelDia(){
		recuerdosDelDia = []
	}
	
	method rememorar(){
		const recuerdo = memoriaLargoPlazo.filter({recuerdo=>recuerdo.esMuyAntiguo(edad)}).anyOne()
		self.convertirseEnPensamientoActual(recuerdo)
	}
	
	method convertirseEnPensamientoActual(recuerdo){
		pensamientoActual = recuerdo
	}
	
	method cantidadDeRepeticionesDe(unRecuerdo){
		return memoriaLargoPlazo.ocurrencesOf(unRecuerdo)
	}
	
	method tieneDejaVu(){
		return memoriaLargoPlazo.contains(pensamientoActual )
	}
	
}

object riley inherits Persona (emocionDominante= alegria, procesosAlDormir=
	[asentamiento, asentamientoSelectivo,profundizacion,controlHormonal,
		restauracionCognitiva,liberacionRecuerdosDelDia],memoriaLargoPlazo=[],edad=11,pensamientoActual = a)
