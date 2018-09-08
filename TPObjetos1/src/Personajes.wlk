import Universo.*
import Hechizos.*
import Artefactos.*

object rolando {
	var valorHechizoBase = 3
	var hechizoPreferido
	var habilidadLuchaBase = 1
	var artefactos = []
	
	method hechizoPreferido(unHechizo) {
		hechizoPreferido = unHechizo
	}
	
	method nivelDeHechiceria() {
		return valorHechizoBase * hechizoPreferido.poder() + universo.fuerzaOscura()
	}
	
	method seCreePoderoso() {
		return hechizoPreferido.esPoderoso()
	}
	
	method habilidadLuchaBase(cantidad) {
		habilidadLuchaBase = cantidad
	}
	
	method habilidadLucha() {
		return habilidadLuchaBase + self.poderArtefactos()
	}
	
	method poderArtefactos() {
		return artefactos.sum({unArtefacto => unArtefacto.unidadesDeLucha()})
	}
	
	method agregarArtefacto(unArtefacto) {
		artefactos.add(unArtefacto)
	}
	
	method removerArtefacto(unArtefacto) {
		artefactos.remove(unArtefacto)
	}
	
	method esMejorLuchando() {
		return self.habilidadLucha() > self.nivelDeHechiceria()
	}
	
	method estaCargado() {
		return artefactos.size() >= 5
	}
}