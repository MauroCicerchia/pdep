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
	
	method armadura(unaArmadura) {}
}

object hechizoBasico {	
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
	
	method armadura(unaArmadura) {}
}