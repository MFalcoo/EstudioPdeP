class Ringtone {
	const property compania
	const duracion
	const precioPorMinuto
	
	method montoDerechoAutor(){
		return duracion*precioPorMinuto
	}
	
	method montoFinal(){
		return self.montoDerechoAutor() + compania.cobroPorServicio(self.montoDerechoAutor()) + 
	}
}

class Chiste{
	const property compania
	const caracteresDelTexto
	const montoFijo
	
	method montoDerechoAutor(){
		return caracteresDelTexto*montoFijo
	}
}

class Juego{
	const property compania
	const monto
	
	method montoDerechoAutor(){
		return monto
	}
}