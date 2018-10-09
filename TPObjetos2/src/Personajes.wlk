import Universo.*
import Hechizos.*
import Artefactos.*
import Refuerzos.*
import Feria.*

object rolando {
	var valorHechizoBase = 3
	var hechizoPreferido = espectroMalefico
	var habilidadLuchaBase = 1
	var artefactos = #{}
	var oro = 100
	
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
		unArtefacto.portador(self)
	}
	
	method removerArtefacto(unArtefacto) {
		artefactos.remove(unArtefacto)
		unArtefacto.portador(null)
	}
	
	method esMejorLuchando() {
		return self.habilidadLucha() > self.nivelDeHechiceria()
	}
	
	method estaCargado() {
		return artefactos.size() >= 5
	}
	
	method mejorArtefacto() {
		return artefactos.filter({unArtefacto => !unArtefacto.equals(espejo)}).max({unArtefacto => unArtefacto.unidadesDeLucha()})
	}
	
	method cumplirObjetivo(){
		oro += 10
	}
	
	method comprarHechizo(hechizoBuscado){
		feriaDeHechiceria.puedeComprarHechizo( hechizoPreferido , oro ,hechizoBuscado)
	}
	
	method cantidadDeArtefactos() {
		return artefactos.size()
	}
	
	//----------------------------------------- solo para tests ------------------------------------------------------------------
	method eliminarTodosLosArtefactos(){
		artefactos.forEach({unArtefacto => self.removerArtefacto(unArtefacto)})
	}
	
	method setForTest2() {
		self.agregarArtefacto(espadaDelDestino)
		self.agregarArtefacto(collarDivino)
		self.agregarArtefacto(mascaraOscura)
	}
	
	method setForTest3() {
		self.setForTest2()
		self.agregarArtefacto(armadura)
		self.agregarArtefacto(espejo)
	}
}