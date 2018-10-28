class Comerciante {
	
	var tipo
	var objetos
	
	constructor(unTipo, unosObjetos)
	{
		tipo = unTipo
		objetos = unosObjetos
	}
	
	method precio(objeto)
	{
		if(!objetos.contains(objeto))
		{
			self.error("El comerciante no posee este objeto.")			
		}
		return objeto.precio() + tipo.impuesto(objeto)
	}
	
	method vender(objeto, personaje)
	{
		if(!personaje.puedePagar(self.precio(objeto)))
		{
			self.error("Oro insuficiente.")
		}
		objetos.remove(objeto)
	}
}

class Independiente
{
	var property comision
	
	constructor(unaComision)
	{
		comision = unaComision
	}
	
	method impuesto(objeto)
	{
		return comision
	}
}

object registrado
{
	method impuesto(objeto)
	{
		return 0.21 * objeto.precio()
	}
}

object conImpuestoGanancias
{
	var minimoNoImponible = 5
	
	method impuesto(objeto)
	{
		return 0.max((objeto.precio() - minimoNoImponible) * 0.35)
	}
}
