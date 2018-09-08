import Universo.*
import Refuerzos.*
import Personajes.*

object espadaDelDestino {
	var portador = rolando
	
	method unidadesDeLucha() {
		return 3
	}
	
	method portador() {
		return portador
	}
	
	method portador(unPortador) {
		portador = unPortador
	}
}

object collarDivino {
	var perlas = 5
	var portador = rolando
	
	method unidadesDeLucha() {
		return perlas
	}
	
	method perlas(cantidad) {
		perlas = cantidad
	}
	
	method portador() {
		return portador
	}
	
	method portador(unPortador) {
		portador = unPortador
	}
}

object mascaraOscura {
	var portador = rolando
	
	method unidadesDeLucha() {
		if(universo.fuerzaOscura() < 8) {
			return 4
		} else {
			return universo.fuerzaOscura() / 2
		}
	}
	
	method portador() {
		return portador
	}
	
	method portador(unPortador) {
		portador = unPortador
	}
}

object armadura {
	var refuerzo = ninguno
	//var portador	//Punto 2
	var portador = rolando	//Punto 3
	
	method unidadesDeLucha() {
		return 2 + refuerzo.poder()
	}
	
	method refuerzo(unRefuerzo) {
		refuerzo.armadura(null)
		refuerzo = unRefuerzo
		unRefuerzo.armadura(self)
	}
	
	method portador() {
		return portador
	}
	
	method portador(unPortador) {
		portador = unPortador
	}
}

object espejo {
	//var portador	//Punto 2
	var portador = rolando	//Punto 3
	
	method unidadesDeLucha() {
		if(portador.cantidadDeArtefactos() == 1) {
			return 0
		} else {
			return portador.mejorArtefacto().unidadesDeLucha()
		}
	}
	
	method portador() {
		return portador
	}
	
	method portador(unPortador) {
		portador = unPortador
	}
}