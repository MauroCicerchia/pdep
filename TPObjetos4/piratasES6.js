class Pirata
{
  constructor(unaEnergia)
  {
    this.energia = unaEnergia;
  }
  
  modificarEnergia(cantidad)
  {
      this.energia += cantidad;
  };

  darIngrediente() {}

  esFuerte()
  {
    return this.poderDeMando() > 100;
  }

  estaDebil()
  {
    return this.energia < 20;
  }
}

class Navegante extends Pirata
{
  constructor(unaInteligencia, unaEnergia)
  {
    super(unaEnergia);
    this.inteligencia = unaInteligencia;
  }

  poderDeMando()
  {
    return this.inteligencia * this.inteligencia;
  }

  serHerido()
  {
    this.inteligencia /= 2;
  }
}