function Barco(unaMunicion, unaResistencia, unPoderDeFuego, unBando, unaTripulacion)
{
  this.municion = unaMunicion;
  this.resistencia = unaResistencia;
  this.poderDeFuego = unPoderDeFuego;
  this.bando = unBando;
  this.tripulacion = unaTripulacion;

  this.municionTotal = function()
  {
    return this.bando.municionTotal(this.municion);
  }

  this.poderDeFuegoTotal = function()
  {
    return this.bando.poderDeFuegoTotal(this.poderDeFuego);
  }

  this.tripulacionTotal = function()
  {
    return this.bando.tripulacionTotal(this.tripulacion);
  }

  this.cambiarBando = function(unBando)
  {
    this.bando = unBando;
  }

  this.fuerza = function()
  {
    return this.tripulacionTotal().reduce((total, tripulante) => total + tripulante.poderDeMando(), 0);
  }

  this.capitan = function()
  {
    return this.tripulacion.reduceRight((tempMax, tripulante) => tripulante.poderDeMando() > tempMax.poderDeMando() ? tripulante : tempMax);
  }

  this.pelearCon = function(enemigo)
  {
    if(this.fuerza() > enemigo.fuerza())
    {
      enemigo.serVencidoPor(this);
    }
    else
    {
      this.serVencidoPor(enemigo);
    }
  }

  this.serVencidoPor = function(enemigo)
  {
    this.herirTripulacion();
    enemigo.agregarTripulacion(this.tripulacionFuerte());
    this.desolarse();
  }

  this.herirTripulacion = function()
  {
    this.tripulacion.forEach(tripulante => tripulante.serHerido());
  }

  this.tripulacionFuerte = function()
  {
    return this.tripulacion.filter(tripulante => tripulante.esFuerte());
  }

  this.agregarTripulacion = function(unaTripulacion)
  {
    this.tripulacion = this.tripulacion.concat(unaTripulacion);
  }

  this.desolarse = function()
  {
    this.municion = 0;
    this.resistencia = 0;
    this.poderDeFuego = 0;
    this.tripulacion = [];
  }

  this.estaDesolado = function()
  {
    return this.municion == 0 && this.resistencia == 0 && this.poderDeFuego == 0 && this.tripulacion.length == 0;
  }

  this.dispararCanionazos = function(cant, barco)
  {
    if(cant > this.municionTotal())
      throw new Error("No se dispone de municion suficiente");

    this.municion = Math.max(0, this.municion - cant);
    barco.recibirCanionazos(cant);
  }

  this.recibirCanionazos = function(cant)
  {
    this.resistencia = Math.max(0, this.resistencia - cant * 50);
    this.tripulacion = this.tripulacion.filter(tripulante => !tripulante.estaDebil());
  }

  this.tieneTripulante = function(tripulante)
  {
    return this.tripulacion.includes(tripulante);
  }
}

exports.Barco = Barco;