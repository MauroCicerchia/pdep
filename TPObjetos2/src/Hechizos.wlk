class Hechizo
{	
	method precioArmadura(unaArmadura)
	{
		return unaArmadura.valorBase()
	}
	
	method puedeSerCompradoPor(personaje)
	{
		return self.precioPara(personaje) <= personaje.oro()
	}
	
	method precioPara(personaje)
	{
		return 0.max(self.precio() - personaje.precioDeHechizo())
	}
	
	method precio()
	
	method poder()
	
	method esPoderoso()
	
	method armadura() {}	
}

class HechizoDeLogos inherits Hechizo
{
	var property nombre 
	var property multiplicador 
	
	constructor(unNombre, unMultiplicador)
	{
		nombre = unNombre
		multiplicador = unMultiplicador
	}
	
	override method precio()
	{
		return self.poder()
	}
	
	override method poder()
	{
		return nombre.size() * multiplicador
	}
	
	override method esPoderoso()
	{
		return self.poder() > 15
	}	
}

object hechizoBasico inherits Hechizo
{	
	
	override method precio()
	{
		return 10
	}
	
	override method poder()
	{
		return 10
	}
	
	override method esPoderoso()
	{
		return false
	}
}

class LibroDeHechizos
{
	var hechizos
	
	constructor(unosHechizos)
	{
		hechizos = unosHechizos
	}
	
	method precio()
	{
		return hechizos.size() * 10 + self.poder()
	}
	
	method poder()
	{
		return hechizos.filter({unHechizo => unHechizo.esPoderoso()}).sum({unHechizo => unHechizo.poder()})
	}
	
	method esPoderoso()
	{
		return true
	}
	
	method agregarHechizo(unHechizo)
	{
		if(!unHechizo.equals(self))	//Explicar
			hechizos.add(unHechizo)
	}
	
	method removerHechizo(unHechizo)
	{
		hechizos.remove(unHechizo)
	}
}

object ninguno
{
	method poder()
	{
		self.error("El personaje no tiene asignado un hechizo")
	}
	
	method esPoderoso() {
		self.error("El personaje no tiene asignado un hechizo")
	}
	
	method armadura(unaArmadura) {}
	
	method precioArmadura(unaArmadura)
	{
		return 2
	}
}