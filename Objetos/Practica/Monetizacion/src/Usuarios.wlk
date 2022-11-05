class Usuario {
	const nombre
	const property email
	var cotizacion
	var contenidos
	var property verificado = false
	
	method subirContenido(contenido, cotizacion){
		if(consultarCambio(cotizacion,contenido)){
		contenido.cambiarCotizacion(cotizacion)
		contenidos.add(contenido)
		}else throw new Exception (message="El Contenido no soporta la forma de cotizacion")
	}
	
	method cambiarCotizacion(unaCotizacion){
		cotizacion = unaCotizacion
	}
	
	method saldoTotal(){
		return contenidos.sum({unContenido=>unContenido.recaudacion()})
	}
	method tiene10Popus(){
		return contenidos.count({unContenido=>unContenido.esPopular()} >= 10)
	}
}

object usuarios{
	const todosLosUsuarios = []
	
	method emailsDeUsuariosVerificados(){
		usuariosVerificados.sortedBy({uno,otro=>uno.saldoTotal() > otro.saldoTotal()}).take(100).map({unUsuario=>unUsuario.email()})
	}
	
	method usuariosVerificados(){
		return todosLosUsuarios.filter({unUsuario=>unUsuario.verificado()})
	}
	
	method cantidadSuperUsuarios(){
		return todosLosUsuarios.count(unUsuario=>unUsuario.tiene10Popus())
	}

}
