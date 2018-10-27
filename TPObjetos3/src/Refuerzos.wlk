import Artefactos.*

class CotaDeMalla
{	
	var poder
	
	constructor(unPoder)
	{
		poder = unPoder
	}
	
	method poder()
	{
		return poder
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