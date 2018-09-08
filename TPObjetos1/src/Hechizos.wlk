object espectroMalefico {
	var nombre = "Espectro Malefico"
	var armadura
	
	method nombre(unNombre) {
		nombre = unNombre
	}
	
	method poder() {
		return nombre.size()
	}
	
	method esPoderoso() {
		return nombre.size() > 15
	}
	
	method armadura(unaArmadura) {
		armadura  = unaArmadura
	}
}

object hechizoBasico {
	var armadura
	
	method poder() {
		return 10
	}
	
	method esPoderoso() {
		return false
	}
	
	method armadura(unaArmadura) {
		armadura  = unaArmadura
	}
}

object libroDeHechizos {
	var hechizos = []
	
	method poder() {
		return hechizos.sum({hechizo=>hechizo.poder()})
	}
	
	method esPoderoso() {
		return true
	}
	
	method agregarHechizo(unHechizo) {
		if(unHechizo.esPoderoso())
			hechizos.add(unHechizo)
	}
	
	method removerHechizo(unHechizo) {
		hechizos.remove(unHechizo)
	}
	//solo para tests:
	method hechizos(){
		return hechizos
	}
}