import Personajes.*

class NPC inherits Personaje
{
	var property dificultad
	
	constructor(valor, habilidad, capacidad, unaDificultad) = super(valor, habilidad, capacidad)
	{
		dificultad = unaDificultad
	}
	
	override method habilidadLucha()
	{
		return super() * dificultad.multiplicador()
	}
}

object facil
{
	method multiplicador()
	{
		return 1
	}
}

object moderada
{
	method multiplicador()
	{
		return 2
	}
}

object dificil
{
	method multiplicador()
	{
		return 4
	}
}