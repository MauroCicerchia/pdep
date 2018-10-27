class Hechizo
{	
	method precioArmadura(unaArmadura)
	{
		return unaArmadura.valorBase() + self.precio()
	}
	
	method precioPara(personaje)
	{
		return 0.max(self.precio() - personaje.precioDeHechizo() / 2)
	}
	
	method precio()
	
	method poder()
	
	method esPoderoso()
	{
		return self.poder() > 15
	}
	
	method armadura(unaArmadura) {}
	
	method esLibro() {
		return false;
	}
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
}

object hechizoComercial inherits HechizoDeLogos("el hechizo comercial", 2)
{
	var property porcentaje = 0.2
	
	override method poder()
	{
		return super() * porcentaje
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
}

class LibroDeHechizos inherits Hechizo
{
	var hechizos = #{}
	
	override method precio()
	{
		return hechizos.size() * 10 + self.poder()
	}
	
	override method poder()
	{
		return hechizos.filter{unHechizo => unHechizo.esPoderoso()}.sum{unHechizo => unHechizo.poder()}
	}
	
	override method esLibro()
	{
		return true
	}

	method agregarHechizo(unHechizo)	
	{
		if(unHechizo.esLibro())
			self.error("No se puede agregar un libro como hechizo de otro libro.")
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
		return 0
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