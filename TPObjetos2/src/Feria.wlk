object feriaDeHechiceria {

	var objetos = []
	
	method vender(objeto)
	{
		if(!objetos.contains(objeto))
		{
			self.error("La tienda no posee el objeto deseado")
		}
		objetos.remove(objeto)
	}

	method agregarObjeto(unObjeto){
		objetos.add(unObjeto)
	}
}
