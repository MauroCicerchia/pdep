object feriaDeHechiceria {

	var hechizosALaVenta = []
	
	method puedeComprar(hechizoActual,hechizoBuscado,oroDisponible){
	
		return hechizoBuscado.precio() <hechizoActual.precio() + oroDisponible
			
	}
	
}
