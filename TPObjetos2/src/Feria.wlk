object feriaDeHechiceria {

	var hechizosALaVenta = []
	var artefactosALaVenta = []
	
	method puedeComprarHechizo(hechizoActual, hechizoBuscado, oroDisponible){
		return self.cubreCostoHechizo(hechizoActual,hechizoBuscado,oroDisponible) && self.estaALaVentaHechizo(hechizoBuscado)		
	}

	method estaALaVentaHechizo(hechizoBuscado){
		return hechizosALaVenta.contains(hechizoBuscado)
	}	
	
	method cubreCostoHechizo(hechizoActual,hechizoBuscado,oroDisponible){
		return hechizoBuscado.precio() <= hechizoActual.precio()/2 + oroDisponible
	}

	method agregarHechizo(unHechizo){
		hechizosALaVenta.add(unHechizo)
	}
	
	method puedeComprarArtefacto(artefactoBuscado, oroDisponible){
		return self.cubreCostoArtefacto(artefactoBuscado,oroDisponible) && self.estaALaVentaArtefacto(artefactoBuscado)	
	}
	
	method cubreCostoArtefacto(artefactoBuscado, oroDisponible){
		return artefactoBuscado.precio() <= oroDisponible
	}
	
	method estaALaVentaArtefacto(artefactoBuscado){
		return artefactosALaVenta.contains(artefactoBuscado)
	}
}
