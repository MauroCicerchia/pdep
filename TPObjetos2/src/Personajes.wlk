import Universo.*
import Hechizos.*
import Artefactos.*
import Refuerzos.*

class Personaje
{
	var valorHechizoBase
	var property hechizoPreferido
	var habilidadLuchaBase
	var property artefactos = #{}
	
	constructor(valor, habilidad)
	{
		valorHechizoBase = valor
		habilidadLuchaBase = habilidad
		hechizoPreferido = ninguno
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
	
	method cantidadDeArtefactos()
	{
		return artefactos.size()
	}
	
	method eliminarTodosLosArtefactos()
	{
		artefactos.forEach({unArtefacto => self.removerArtefacto(unArtefacto)})
	}
}

object nadie
{
	method nivelDeHechiceria()
	{
		return 0
	}
}