class Usuario {
	const property email
	var contenidos
	var verificado = false
	
	method saldoTotalDeUsuario(){
		return contenidos.sum({unContenido=>unContenido.totalRecaudado()})
	}
	
	method esSuperUsuario(){
		return contenidos.filter({contenido=>contenido.esPopular()}).size()>=10
	}
	
	method publicarContenido(contenido,formaDeMonetizar){
		if(!contenido.puedeAplicarse())
		throw new Exception(message  = " No se puede aplicar")
		contenido.cambiarFormaMonetizacion(formaDeMonetizar)
		self.agregarContenido(contenido)
	}
	
	method agregarContenido(contenido){
		contenidos.add(contenido)
	}
	
	
}

object plataforma{
	var usuarios
	
	method emailDe100verificadosConMayorSaldo(){
		return usuarios.filter({usuario=>usuario.verificado()})
		.sortedBy({uno,otro=>uno.saldoTotalDeUsuario()>otro.saldoTotalDeUsuario()})
		.take(100)
		.map({unUsuario=>unUsuario.email()})
	}
	
	method cantidadSuperUsuarios(){
		return usuarios.filter({usuario=>usuario.esSuperUsuario()}).size()
	}
}