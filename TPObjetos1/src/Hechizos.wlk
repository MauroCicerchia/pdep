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
	var hechizos = [espectroMalefico,hechizoBasico]
	
	method poder() {
		return hechizos.filter({unHechizo => unHechizo.esPoderoso()}).sum({unHechizo => unHechizo.poder()})
	}
	
	method esPoderoso() {
		return true
	}
	
	method agregarHechizo(unHechizo) {
		hechizos.add(unHechizo)
	}
	
	method removerHechizo(unHechizo) {
		hechizos.remove(unHechizo)
	}
}