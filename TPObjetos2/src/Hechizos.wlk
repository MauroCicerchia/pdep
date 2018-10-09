class HechizoDeLogos {
	var property nombre 
	var property multiplicador 
	
	constructor(unNombre, unMultiplicador)
	{
		nombre = unNombre
		multiplicador = unMultiplicador
	}
	
	method precio(){
		return self.poder()
	}
	
	method poder(){
		return nombre.size() * multiplicador
	}
	
	method esPoderoso(){
		return self.poder() > 15
	}	
}

//object espectroMalefico inherits HechizoDeLogos("Espectro Malefico", 1) {}

object hechizoBasico {	
	
	method precio(){
		return 10
	}
	
	method poder() {
		return 10
	}
	
	method esPoderoso() {
		return false
	}
	
	method armadura(unaArmadura) {}
}

class LibroDeHechizos {
	var hechizos
	
	constructor(unosHechizos)
	{
		hechizos = unosHechizos
	}
	
	method precio(){
		return hechizos.size()*10 + self.poder() 	
	}
	
	method poder() {
		return hechizos.filter({unHechizo => unHechizo.esPoderoso()}).sum({unHechizo => unHechizo.poder()})
	}
	
	method esPoderoso() {
		return true
	}
	
	method agregarHechizo(unHechizo) {
		if(!unHechizo.equals(self))	//Explicar
			hechizos.add(unHechizo)
	}
	
	method removerHechizo(unHechizo) {
		hechizos.remove(unHechizo)
	}
}