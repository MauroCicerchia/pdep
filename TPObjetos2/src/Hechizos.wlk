object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method nombre(unNombre) {
		nombre = unNombre
	}
	
	method precio(){
		return 15
	}
	method poder() {
		return nombre.size()
	}
	
	method esPoderoso() {
		return self.poder() > 15
	}
	
	method armadura(unaArmadura) {}
}

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

object libroDeHechizos {
	var hechizos = #{espectroMalefico,hechizoBasico}
	
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
		if(!unHechizo.equals(self))
			hechizos.add(unHechizo)
	}
	
	method removerHechizo(unHechizo) {
		hechizos.remove(unHechizo)
	}
}

class HechizoDeLogos{
	var property nombre 
	var property multiplicador 
	
	method precio(){
		return self.poder()
	}
	
	method poder(){
		return nombre.size()*multiplicador
	}
	
	method esPoderoso(){
		return self.poder() > 15
	}	
}