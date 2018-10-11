import Universo.*
import Hechizos.*
import Artefactos.*
import Refuerzos.*
import Feria.*


class Personaje {
	var valorHechizoBase
	var property hechizoPreferido 
	var habilidadLuchaBase
	var artefactos
	var oro
	
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
	
	method mejorArtefacto()
	{
		return artefactos.filter({unArtefacto => !unArtefacto.esClase("Espejo")}).max({unArtefacto => unArtefacto.unidadesDeLucha()})
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
		feriaDeHechiceria.vender(objeto)
		oro -= objeto.precioPara(self)
	}
	
	method puedePagar(objeto)
	{
		return objeto.puedeSerCompradoPor(self)
	}
	
	method cantidadDeArtefactos() {
		return artefactos.size()
	}
  
  method eliminarTodosLosArtefactos()
	{
		artefactos.forEach({unArtefacto => self.removerArtefacto(unArtefacto)})
	}
}

object nadie{
	method nivelDeHechiceria(){
		return 0
	}
}

		