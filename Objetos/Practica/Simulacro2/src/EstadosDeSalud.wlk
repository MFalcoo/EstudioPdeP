object sano {
	
	method comerCaramelos(cantidad,ninio){
		if(cantidad>10)
		ninio.cambiarSalud(empachado)
	}
	
	method actitudDelNinio(actitud){
		return actitud
	}
	
}

object empachado {
	method comerCaramelos(cantidad,ninio){
		if(cantidad>10)
		ninio.cambiarSalud(enCama)
	}
	method actitudDelNinio(actitud){
		return actitud/2
	}
	
}

object enCama {
	method comerCaramelos(cantidad,ninio){
		//no hace nada
	}
	method actitudDelNinio(actitud){
		return 0
	}
	
}
