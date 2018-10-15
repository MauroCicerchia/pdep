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
	
	method armadura(unaArmadura) {}
	
	method esClase(clase)	//Ver explicacion en LibroDeHechizos (linea 92)
	{
		return self.className() == "Hechizos." + clase
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
	
	override method esPoderoso()
	{
		return true
	}
	
	/*
	 * Decidimos que era conveniente (y logico) que pudieran existir más de un libro de hechizos.
	 * Sin embargo, permitir que un libro contuviera a otro libro como hechizo, además de considerarlo conceptualmente mal,
	 * resulta problemático, porque en un caso extremo en el que existieran dos libros, libro1 y libro2, y el libro1 contuviera al libro2 y viceversa
	 * al querer calcular el poder del libro se generaría un bucle infinito. Por esto decidimos agregar el metodo esClase a la clase hechizo, para
	 * evitar que se pueda agregar un libro como hechizo de otro. 
	 */
	method agregarHechizo(unHechizo)	
	{
		if(unHechizo.esClase("LibroDeHechizos"))
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