object cotaDeMalla {
	var armadura
	
	method poder() {
		return 1
	}
	
	method armadura(unaArmadura) {
		armadura = unaArmadura
	}
}

object bendicion {
	var armadura
	
	method poder() {
		return armadura.portador().nivelDeHechiceria()
	}
	
	method armadura(unaArmadura) {
		armadura = unaArmadura
	}
}