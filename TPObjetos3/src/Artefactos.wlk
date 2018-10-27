import Universo.*
import Refuerzos.*
import Personajes.*
import Hechizos.ninguno

class Artefacto
{
	var property portador = nadie
	
	method unidadesDeLucha()
	
	method precio()
	
	method puedeSerCompradoPor(personaje)
	{
		return self.precio() <= personaje.oro()
	}
	
	method precioPara(personaje)
	{
		return self.precio()
	}
}

class Arma inherits Artefacto
{	
	override method unidadesDeLucha()
	{
		return 3
	}
	
	override method precio()
	{
		return 5 * self.unidadesDeLucha()
	}
}

object collarDivino inherits Artefacto
{
	var property perlas = 5
	
	override method unidadesDeLucha()
	{
		return perlas
	}
	
	override method precio()
	{
		return 2 * perlas
	}
}

class Mascara inherits Artefacto
{
	var indiceDeOscuridad
	var poderMinimo
	
	constructor(indice)
	{
		indiceDeOscuridad = indice
		poderMinimo = 4
	}
	
	method poderMinimo(minimo)
	{
		poderMinimo = minimo
	}
	
	override method unidadesDeLucha()
	{
		return poderMinimo.max(universo.fuerzaOscura() / 2 * indiceDeOscuridad)
	}
	
	override method precio()
	{
		return self.unidadesDeLucha()	//No especificado
	}
}

class Armadura inherits Artefacto
{
	var valorBase
	var refuerzo
	
	constructor(valor)
	{
		valorBase = valor
		refuerzo = ninguno
	}
	
	method valorBase()
	{
		return valorBase
	}
	
	override method unidadesDeLucha()
	{
		return valorBase + refuerzo.poder()
	}
	
	method nivelDeHechiceriaDelPortador()
	{
		return portador.nivelDeHechiceria()
	}
	
	method agregarRefuerzo(unRefuerzo)
	{
		refuerzo = unRefuerzo
		refuerzo.armadura(self)
	}
	
	override method precio()
	{
		return refuerzo.precioArmadura(self)
	}
}

class Espejo inherits Artefacto
{
	
	override method unidadesDeLucha()
	{
		if(portador.soloTiene(self))
		{
			return 0
		}
		else
		{
			return portador.unidadesDeLuchaDelMejorArtefactoRestante(self)
		}
	}
	
	override method precio()
	{
		return 90
	}
}