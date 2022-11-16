object realista{
	method cumplirMeta(persona){
		persona.cumplir(persona.suenioMasImportante())
	}
}

object alocado{
	method cumplirMeta(persona){
		persona.cumplir(persona.sueniosPorCumplir().any())
	}
}

object obsesivo{
	method cumplirMeta(persona){
		persona.cumplir(persona.sueniosPorCumplir().head())
	}
}