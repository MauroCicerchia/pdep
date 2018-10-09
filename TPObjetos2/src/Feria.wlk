object feriaDeHechiceria {
	var hechizoDisponibles = []
	
	method puedeComprar(hechizoActual,hechizoBuscado,oroDisponible){
	
		return hechizoBuscado.precio() <hechizoActual.precio() + oroDisponible
			
	}
	
}
