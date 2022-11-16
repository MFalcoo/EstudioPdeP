import Armas.*
import Rangos.*

class Mafioso {
	var estaMuerto = true
	var estaHerido = false
	const armas = [escopeta]
	var rango
	var property lealtadFamilia
	var property familia
	
	method estaMuerto(){
		return estaMuerto
	}
	
	method cantidadDeArmas(){
		return armas.size()
	}
	
	method recibirArma(arma){
		armas.add(arma)
	}
	
	method despachaElegantemente(){
		return rango.sabeDespachar()
	}
	
	method tieneArmaSutil(){
		return armas.any({arma=>arma.esSutil(self)})
	}
	
	method atacarFamilia(otraFamilia){
		if(!otraFamilia.nadieVivo()){
		const personaAMatar = otraFamilia.integranteVivoMasPeligroso()
		self.hacerSuTrabajo(personaAMatar)
		}
	}
	
	method hacerSuTrabajo(personaAMatar){
		rango.hacerSuTrabajo(personaAMatar)
	}
	
	method usarArma(arma,personaAMatar){
		arma.usarse(personaAMatar)
	}
	
	method morir(){
		estaMuerto = true
	}
	
	method herirse(){
		if(estaHerido)
		self.morir()
		else
		estaHerido = true
	}
	
	method armaNoUsada(armasUsadas){
		return armas.any({arma=>!armasUsadas.contains(arma)})
	}
	
	method armaMasAMano(){
		return armas.anyOne()
	}
	
	method escalar(){
		rango.escalar()
		self.aumentarLealtad()
	}
	
	method aumentarLealtad(){
		lealtadFamilia =+ lealtadFamilia * 10/100
	}
	
	method estaArmado(){
		return armas.count() > 5
	}
	
	method promoverASubjefe(nuevoRango){
		rango = new Subjefe
	}
	
	method ascenderADon(){
		rango = new Don (subordinados = self.subordinados()) 
		familia.nuevoDon(self)
	}
	
	method subordinados(){
		return rango.subordinados()
	}
	
	method planearTraicion(){
		self.primeraVictima()
	}
	
	method asesinar(miembrosAtacados){
		miembrosAtacados.forEach({miembro=>miembro.morir()})
	}
	
	method cambiarDeFamilia(nuevaFamilia,traicion){
		familia.irseYregistrarTraicion(self,traicion)
		nuevaFamilia.incorporarloConMaxLealtad(self)
		familia= nuevaFamilia
	}
	
	method maximaLealtad(){
		lealtadFamilia = 100
	}
}
