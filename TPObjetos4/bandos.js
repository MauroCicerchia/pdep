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

const armadaInglesa = new Bando();

armadaInglesa.municionTotal = function(municion)
{
  return Math.floor(municion * 1.3);
}

const unionPirata = new Bando();

unionPirata.poderDeFuegoTotal = function(poderDeFuego)
{
  return poderDeFuego + 60;
}

const armadaDelHE = new Bando();

armadaDelHE.tripulacionTotal = function(tripulacion)
{
  return tripulacion.concat(tripulacion);
}

const ninguno = new Bando();

exports.armadaInglesa = armadaInglesa;
exports.unionPirata = unionPirata;
exports.armadaDelHE = armadaDelHE;
exports.ninguno = ninguno;