class Persona
{
  constructor(nombre)
  {
    this.nombre = nombre;
  }

  saludar()
  {
    console.log("Hola, soy " + this.nombre);
  }
}

class Estudiante extends Persona
{
  constructor(nombre, carrera)
  {
    super(nombre);
    this.carrera = carrera;
  }

  saludar()
  {
    console.log("Hola, soy " + this.nombre + " y estudio " + this.carrera.nombre);
  }
}

class Carrera
{
  constructor(nombre)
  {
    this.nombre = nombre
  }
}

let ingSistemas = new Carrera("Ingenieria en Sistemas");
let mauro = new Estudiante("Mauro", ingSistemas);
mauro.beber = function() { console.log("A"); }
let pepe = new Persona("Pepe");

function Pirata(unaEnergia) {
    this.energia = unaEnergia;
}

Pirata.prototype.modificarEnergia = function(cantidad) {
    this.energia += cantidad;
};

var unePirate = new Pirata(50);

var jackSparrow = new Pirata(100);

jackSparrow.beberRonCon = function()
{
  console.log("hola");
};
