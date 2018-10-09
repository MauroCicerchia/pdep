import Universo.*
import Refuerzos.*
import Personajes.*

class Artefacto
{
	var property portador = null
	
	method esClase(clase)
	{
		return self.className() == "Artefactos." + clase
	}
}

class Arma inherits Artefacto
{	
	method unidadesDeLucha()
	{
		return 3
	}
}

object collarDivino inherits Artefacto
{
	var property perlas = 5
	
	method unidadesDeLucha()
	{
		return perlas
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
	
	method unidadesDeLucha()
	{
		return poderMinimo.max(universo.fuerzaOscura() / 2 * indiceDeOscuridad)
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
	
	method unidadesDeLucha()
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
}

class Espejo inherits Artefacto
{
	
	method unidadesDeLucha() {
		if(portador.cantidadDeArtefactos() == 1) {
			return 0
		} else {
			return portador.mejorArtefacto().unidadesDeLucha()
		}
	}
}