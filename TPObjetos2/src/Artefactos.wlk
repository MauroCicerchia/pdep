import Universo.*
import Refuerzos.*
import Personajes.*
import Hechizos.ninguno

class Artefacto
{
	var property portador = null
	
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
	
	method esClase(clase)
	{
		return self.className() == "Artefactos." + clase
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
	
	override method unidadesDeLucha()
	{
		return poderMinimo.max(universo.fuerzaOscura() / 2 * indiceDeOscuridad)
	}
	
	override method precio()
	{
		return 5 * self.unidadesDeLucha()	//No especificado
	}
}

class Armadura inherits Artefacto
{
	var valorBase
	var property refuerzo
	
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
	
	method NivelDeHechiceriaDelPortador()
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
		if(portador.cantidadDeArtefactos() == 1)
		{
			return 0
		}
		else
		{
			return portador.mejorArtefacto().unidadesDeLucha()
		}
	}
	
	override method precio()
	{
		return 90
	}
}