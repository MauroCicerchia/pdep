object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method nombre(unNombre) {
		nombre = unNombre
	}
	
	method poder() {
		return nombre.size()
	}
	
	method esPoderoso() {
		return self.poder() > 15
	}
}

object hechizoBasico {	
	var precio=10
	
	method precio(){
		return precio
	}
	
	method poder() {
		return 10
	}
	
	method esPoderoso() {
		return false
	}
}

object libroDeHechizos {
	var hechizos = #{espectroMalefico,hechizoBasico}
	
	method precio(){
			
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
	var nombre
	var multiplicador
	
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