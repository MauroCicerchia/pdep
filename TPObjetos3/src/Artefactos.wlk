import Universo.*
import Refuerzos.*
import Personajes.*
import Hechizos.ninguno

class Artefacto
{
	var property portador = nadie
	var peso
	var property diasDesdeCompra
	
	constructor(unPeso)
	{
		peso = unPeso
		diasDesdeCompra = 0
	}
	
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
	
	method peso()
	{
		return peso - self.factorDeCorreccion()
	}
	
	method factorDeCorreccion()
	{
		return 1.min(diasDesdeCompra / 1000)
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
		return 5 * self.peso()
	}
}

object collarDivino inherits Artefacto(0) 
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
	
	override method peso()
	{
		return super() + 0.5 * perlas
	}
}

class Mascara inherits Artefacto
{
	var indiceDeOscuridad
	var poderMinimo
	
	constructor(peso, indice) = super(peso)
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
		return 10 * indiceDeOscuridad
	}
	
	override method peso()
	{
		return super() + 0.max(self.unidadesDeLucha() - 3)
	}
}

class Armadura inherits Artefacto
{
	var valorBase
	var refuerzo
	
	constructor(peso, valor) = super(peso)
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
	
	override method peso()
	{
		return super() + refuerzo.peso()
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