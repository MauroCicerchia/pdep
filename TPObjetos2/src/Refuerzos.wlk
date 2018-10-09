import Artefactos.*

class CotaDeMalla
{	
	method poder()
	{
		return 1
	}
	
	method armadura(unaArmadura) {}
}

class Bendicion
{
	var armadura
	
	method poder()
	{
		return armadura.nivelDeHechiceriaDelPortador()
	}
	
	method armadura(unaArmadura)
	{
		armadura = unaArmadura
	}
}

object ninguno {
	method poder()
	{
		self.error("El personaje no tiene asignado un hechizo")
	}
	
	method esPoderoso() {
		self.error("El personaje no tiene asignado un hechizo")
	}
	
	method armadura(unaArmadura) {}
}