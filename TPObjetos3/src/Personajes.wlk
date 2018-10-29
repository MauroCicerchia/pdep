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
	var capacidadCarga
	
	constructor(valor, habilidad, capacidad) {
		valorHechizoBase = valor
		hechizoPreferido = ninguno
		habilidadLuchaBase = habilidad
		artefactos = #{}
		oro = 100
		capacidadCarga = capacidad
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
	
	method comprarHechizo(hechizo, comerciante)
	{
		self.comprar(hechizo, comerciante)
		self.hechizoPreferido(hechizo)
	}
	
	method comprarArtefacto(artefacto, comerciante)
	{
		if(!self.puedeCargar(artefacto))
		{
			self.error("Capacidad de carga excedida.")
		}
		self.comprar(artefacto, comerciante)
		self.agregarArtefacto(artefacto)
	}
	
	method comprar(objeto, comerciante)
	{
		comerciante.vender(objeto, self)
		oro -= comerciante.precioPara(objeto, self)
	}
	
	method puedePagar(costo)
	{
		return costo <= oro
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
	
	method puedeCargar(artefacto)
	{
		return self.carga() + artefacto.peso() <= capacidadCarga
	}
	
	method carga()
	{
		return artefactos.sum{unArtefacto => unArtefacto.peso()}
	}
}

class NPC inherits Personaje
{
	var multiplicadorDificultad = 1
	
	override method habilidadLucha()
	{
		return super() * multiplicadorDificultad
	}
}

class NPCFacil inherits NPC
{
	constructor(valor, habilidad, capacidad) = super(valor, habilidad, capacidad)
	{
		multiplicadorDificultad = 1
	}
}

class NPCModerado inherits NPC
{
	constructor(valor, habilidad, capacidad) = super(valor, habilidad, capacidad)
	{
		multiplicadorDificultad = 2
	}
}

class NPCDificil inherits NPC
{
	constructor(valor, habilidad, capacidad) = super(valor, habilidad, capacidad)
	{
		multiplicadorDificultad = 4
	}
}

object nadie{
	method nivelDeHechiceria(){
		self.error("El artefacto no tiene portador")
	}
}

		