class Comerciante {
	
	var property tipo
	var objetos
	
	constructor(unTipo, unosObjetos)
	{
		tipo = unTipo
		objetos = unosObjetos
	}
	
	method precioPara(objeto, personaje)
	{
		return objeto.precioPara(personaje) + tipo.impuesto(objeto)
	}
	
	method vender(objeto, personaje)
	{
		if(!objetos.contains(objeto))
		{
			self.error("El comerciante no posee este objeto.")			
		}
		if(!personaje.puedePagar(self.precioPara(objeto, personaje)))
		{
			self.error("Oro insuficiente.")
		}
		objetos.remove(objeto)
	}
	
	method recategorizar()
	{
		tipo.recategorizar(self)
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
		return comision / 100 * objeto.precio()
	}
	
	method recategorizar(comerciante)
	{
		comision *= 2
		if(comision > 21)
		{
			comerciante.tipo(registrado)
		}
	}
}

object registrado inherits Independiente(21)
{
	override method recategorizar(comerciante)
	{
		comerciante.tipo(conImpuestoGanancias)
	}
}

object conImpuestoGanancias
{
	var minimoNoImponible = 5
	
	method impuesto(objeto)
	{
		return 0.max((objeto.precio() - minimoNoImponible) * 0.35)
	}
	
	method recategorizar(comerciante) {}
}
