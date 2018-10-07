import Artefactos.*

object cotaDeMalla {	
	method poder() {
		return 1
	}
}

object bendicion {
	method poder() {
		return armadura.portador().nivelDeHechiceria()
	}
}

object ninguno{
	method poder()
	{
		return 0
	}
}