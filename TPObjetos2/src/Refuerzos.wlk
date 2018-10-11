import Artefactos.*

class CotaDeMalla
{	
	method poder()
	{
		return 1
	}
	
	method armadura(unaArmadura) {}
	
	method precioArmadura(unaArmadura)
	{
		return self.poder() / 2
	}
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
	
	method precioArmadura(unaArmadura)
	{
		return unaArmadura.valorBase()
	}
}