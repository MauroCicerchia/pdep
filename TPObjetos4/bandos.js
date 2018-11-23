function Bando()
{
  this.municionTotal = function(municion)
  {
    return municion;
  }

  this.poderDeFuegoTotal = function(poderFuego)
  {
    return poderFuego;
  }

  this.tripulacionTotal = function(tripulacion)
  {
    return tripulacion;
  }
}

var armadaInglesa = new Bando();

armadaInglesa.municionTotal = function(municion)
{
  return Math.floor(municion * 1.3);
}

var unionPirata = new Bando();

unionPirata.poderDeFuegoTotal = function(poderDeFuego)
{
  return poderDeFuego + 60;
}

var armadaDelHE = new Bando();

armadaDelHE.tripulacionTotal = function(tripulacion)
{
  return tripulacion.concat(tripulacion);
}

var ninguno = new Bando();

exports.armadaInglesa = armadaInglesa;
exports.unionPirata = unionPirata;
exports.armadaDelHE = armadaDelHE;
exports.ninguno = ninguno;