import Universo.*
import Hechizos.*
import Artefactos.*
import Refuerzos.*

class Personaje {
	var valorHechizoBase
	var property hechizoPreferido 
	var habilidadLuchaBase
	var artefactos
	var property oro
	
	constructor(valor, habilidad) {
		valorHechizoBase = valor
		hechizoPreferido = ninguno
		habilidadLuchaBase = habilidad
		artefactos = #{}
		oro = 100
	}
	
	method nivelDeHechiceria()
	{
		return valorHechizoBase * hechizoPreferido.poder() + universo.fuerzaOscura()
	}
	
	method seCreePoderoso()
	{
		return hechizoPreferido.esPoderoso()
	}
	
	method habilidadLuchaBase(cantidad)
	{
		habilidadLuchaBase = cantidad
	}
	
	method habilidadLucha()
	{
		return habilidadLuchaBase + self.poderArtefactos()
	}
	
	method poderArtefactos()
	{
		return artefactos.sum({unArtefacto => unArtefacto.unidadesDeLucha()})
	}
	
	method agregarArtefacto(unArtefacto)
	{
		artefactos.add(unArtefacto)
		unArtefacto.portador(self)
	}
	
	method removerArtefacto(unArtefacto)
	{
		artefactos.remove(unArtefacto)
		unArtefacto.portador(nadie)
	}
	
	method esMejorLuchando()
	{
		return self.habilidadLucha() > self.nivelDeHechiceria()
	}
	
	method estaCargado()
	{
		return artefactos.size() >= 5
	}
	
	/*
	 * Decidimos permitir que existan multiples espejos. Por eso, a la hora de calcular el poder de un espejo, filtramos todos los espejos
	 * que pudieran existir en la lista de artefactos del personaje.
	 */
	method mejorArtefactoRestante(unObjeto)
	{
		return artefactos.filter({unArtefacto => !unArtefacto.equals(unObjeto)}).max({unArtefacto => unArtefacto.unidadesDeLucha()})
	}
	
	method unidadesDeLuchaDelMejorArtefactoRestante(unObjeto)
	{
		return self.mejorArtefactoRestante(unObjeto).unidadesDeLucha()
	}
	
	method cumplirObjetivo(){
		oro += 10
	}
	
	method comprarHechizo(hechizo)
	{
		self.comprar(hechizo)
		self.hechizoPreferido(hechizo)
	}
	
	method comprarArtefacto(artefacto)
	{
		self.comprar(artefacto)
		self.agregarArtefacto(artefacto)
	}
	
	method comprar(objeto)
	{
		if(!self.puedePagar(objeto))
		{
			self.error("Oro insuficiente")
		}
		oro -= objeto.precioPara(self)
	}
	
	method puedePagar(objeto)
	{
		return objeto.precioPara(self) <= oro
	}
	
	method precioDeHechizo()
	{
		return hechizoPreferido.precio()
	}
	
	method cantidadDeArtefactos()
	{
		return artefactos.size()
	}
	
	method soloTiene(unObjeto)
	{
		return artefactos.contains(unObjeto) && self.cantidadDeArtefactos() == 1
	}
  
  method eliminarTodosLosArtefactos()
	{
		artefactos.forEach({unArtefacto => self.removerArtefacto(unArtefacto)})
	}
}

object nadie{
	method nivelDeHechiceria(){
		self.error("El artefacto no tiene portador")
	}
}

		