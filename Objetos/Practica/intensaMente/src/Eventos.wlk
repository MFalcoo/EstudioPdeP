class Recuerdo {
	const descripcion
	const fecha 
	const property emocionDelRecuerdo
	
	method esDificilDeExplicar(){
		return descripcion.words().size() > 10
	}
	
	method contienePalabra(palabra){
		return descripcion.words().contains(palabra)
	}
	method esMuyAntiguo(edad){
		return new Date().year() - fecha.year() > edad/2
	}
	method esAlegre(){
		return emocionDelRecuerdo.esAlegre()
	}
	
}
