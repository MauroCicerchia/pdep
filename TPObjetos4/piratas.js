function Pirata(unaEnergia)
{
  this.energia = unaEnergia;

  this.modificarEnergia = function(cantidad)
  {
      this.energia += cantidad;
  };

  this.darIngrediente = function() {}

  this.esFuerte = function()
  {
    return this.poderDeMando() > 100;
  }

  this.estaDebil = function()
  {
    return this.energia < 20;
  }
}

//Jack Sparrow
var jackSparrow = new Pirata(500);

jackSparrow.poderDePelea = 200;
jackSparrow.inteligencia = 300;
jackSparrow.ingredientes = ["Botella de ron"];

jackSparrow.poderDeMando = function()
{
  return this.energia * this.poderDePelea * this.inteligencia;
}

jackSparrow.serHerido = function()
{
  this.energia /= 2;
  this.poderDePelea /= 2;
  this.inteligencia /= 2;
}

jackSparrow.beberRonCon = function(alguien)
{
  this.modificarEnergia(100);
  alguien.modificarEnergia(-50);
  alguien.darIngrediente(this);
};

jackSparrow.agregarIngrediente = function(ingrediente)
{
  this.ingredientes.push(ingrediente);
}

//Cocinero
function Cocinero(unosIngredientes, unaMoral, unaEnergia)
{
  Pirata.call(this, unaEnergia)
  this.ingredientes = unosIngredientes;
  this.moral = unaMoral;

  this.poderDeMando = function()
  {
    return this.moral * this.ingredientes.length;
  }

  this.serHerido = function()
  {
    this.moral /= 2;
  }

  this.darIngrediente = function(alguien)
  {
    var ingrediente = this.ingredientes.randomElement();
    alguien.agregarIngrediente(ingrediente);
    this.ingredientes.remove(ingrediente);
  }
}

//Navegante
function Navegante(unaInteligencia, unaEnergia)
{
  Pirata.call(this, unaEnergia);
  this.inteligencia = unaInteligencia;

  this.poderDeMando = function()
  {
    return this.inteligencia * this.inteligencia;
  }

  this.serHerido = function()
  {
    this.inteligencia /= 2;
  }
}

//Peleador
function Peleador(unPoderDePelea, unaEnergia)
{
  Pirata.call(this, unaEnergia);
  this.poderDePelea = unPoderDePelea;

  this.poderDeMando = function()
  {
    return this.poderDePelea;
  }

  this.serHerido = function()
  {
    this.poderDePelea /= 2;
  }
}

//Guerrero
function Guerrero(unaVitalidad, unPoderDePelea, unaEnergia)
{
  Peleador.call(this, unPoderDePelea, unaEnergia);
  this.vitalidad = unaVitalidad;

  this.poderDeMando = function()
  {
    return this.poderDePelea * this.vitalidad;
  }
}

//Monstruo Humanoide
function MonstruoHumanoide(unPoderDePelea, unaEnergia)
{
  Peleador.call(this, unPoderDePelea, unaEnergia);
}

//Auxiliares para arrays
Array.prototype.randomElement = function ()
{
    return this[Math.floor(Math.random() * this.length)];
}

Array.prototype.remove = function (element)
{
    this.splice(this.indexOf(element));
}

exports.Pirata = Pirata;
exports.jackSparrow = jackSparrow;
exports.Cocinero = Cocinero;
exports.Navegante = Navegante;
exports.Peleador = Peleador;
exports.Guerrero = Guerrero;
exports.MonstruoHumanoide = MonstruoHumanoide;
