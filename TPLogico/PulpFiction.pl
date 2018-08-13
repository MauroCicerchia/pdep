%Punto 1

saleCon(Quien,Cual):-
  pareja(Quien,Cual).
saleCon(Quien,Cual):-
  pareja(Cual, Quien).    %Se puede hacer recursivo con saleCon(Cual, Quien), pero al hacer una consulta arroja infinitos resultados.

%Punto 2

%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).

%Punto 3

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

trabajaPara(Alguien,bernardo):-
  trabajaPara(marsellus,Alguien),
  Alguien \= jules.
trabajaPara(Alguien,george):-
  saleCon(Alguien,bernardo).

%Punto 4

esFiel(Persona):-
  saleCon(_, Persona),
  not(saleConMasDeUnaPersona(Persona)).

saleConMasDeUnaPersona(Persona) :-
  saleCon(Alguien, Persona),
  saleCon(AlguienMas, Persona),
  Alguien \= AlguienMas.

%Punto 5

%Caso base
acataOrden(Persona, Empleado) :-
  trabajaPara(Persona, Empleado).
%Caso recursivo
acataOrden(Persona, Empleado) :-
  trabajaPara(AlguienMas, Empleado),
  acataOrden(Persona, AlguienMas).



%PARTE 2

% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea).
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%Punto 1

%Caso base
esPeligroso(Alguien) :-
  personaje(Alguien, Ocupacion),
  esActividadPeligrosa(Ocupacion).
%Caso recursivo
esPeligroso(Alguien) :-
  trabajaPara(Jefe, Alguien),
  esPeligroso(Jefe).

esActividadPeligrosa(mafioso(maton)).
esActividadPeligrosa(ladron(Lugares)) :-
  member(licorerias, Lugares).

%Punto 2

sanCayetano(Alguien) :-
  tieneCerca(Alguien, _),
  forall(tieneCerca(Alguien, Persona), encargo(Alguien, Persona, _)).

tieneCerca(Persona, Alguien):-
  amigo(Persona, Alguien).
tieneCerca(Persona, Alguien):-
  amigo(Alguien, Persona).
tieneCerca(Persona,Alguien):-
  trabajaPara(Alguien,Persona).
tieneCerca(Persona,Alguien):-
  trabajaPara(Persona, Alguien).

%Punto 3

nivelRespeto(vincent, 15).
nivelRespeto(Personaje, Respeto) :-
  personaje(Personaje, Ocupacion),
  calcularRespeto(Ocupacion, Respeto).

calcularRespeto(actriz(Peliculas), Respeto) :-
  length(Peliculas,Longitud),
  Respeto is Longitud/10.
calcularRespeto(mafioso(resuelveProblemas),10).
calcularRespeto(mafioso(capo),20).

%Punto 4
respetabilidad(Respetables,NoRespetables) :-
  cuantosRespetables(Respetables),
  cuantosNoRespetables(NoRespetables).

cuantosRespetables(Respetables) :-
  findall(Persona, esRespetable(Persona), ListaRespetables),
  length(ListaRespetables, Respetables).

cuantosNoRespetables(NoRespetables) :-
  findall(Persona, noEsRespetable(Persona), ListaNoRespetables),
  length(ListaNoRespetables, NoRespetables).

esRespetable(Personaje) :-
  nivelRespeto(Personaje, Respeto),
  Respeto > 9.

noEsRespetable(Personaje) :-
  personaje(Personaje, _),
  not(esRespetable(Personaje)).

%Punto 5
masAtareado(Personaje) :-
  cantidadEncargos(Personaje, Cantidad),
  forall(cantidadEncargos(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadEncargos(Personaje, Cantidad) :-
  personaje(Personaje, _),
  findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
  length(Encargos, Cantidad).
