module Backend exposing(..)
import Models exposing(Movie, Preferences)
import List exposing(filter,member,map,sortBy,all,any)
devTrue = identity

-- **************
-- Requerimiento: filtrar películas por su título a medida que se escribe en el buscador;
-- **************

filtrarPeliculasPorPalabrasClave : String -> List Movie -> List Movie
filtrarPeliculasPorPalabrasClave palabras list = filter (peliculaTienePalabrasClave palabras) list

-- esta función la dejamos casi lista, pero tiene un pequeño bug. ¡Corregilo!
--
-- Además tiene dos problemas, que también deberías corregir:
--
-- * distingue mayúsculas de minúsculas, pero debería encontrar a "Lion King" aunque escriba "kINg"
-- * busca una coincidencia exacta, pero si escribís "Avengers Ultron" debería encontrar a "Avengers: Age Of Ultron"
--
peliculaTienePalabrasClave : String->Movie->Bool
peliculaTienePalabrasClave palabras pelicula = all (buscarPalabra pelicula) (String.words palabras)

buscarPalabra : Movie->String->Bool
buscarPalabra pelicula palabra = String.contains (String.toUpper palabra) (String.toUpper pelicula.title)
-- **************
-- Requerimiento: visualizar las películas según el género elegido en un selector;
-- **************

filtrarPeliculasPorGenero : String -> List Movie -> List Movie
filtrarPeliculasPorGenero genero peliculas = filter (esDelGeneroBuscado genero) peliculas

esDelGeneroBuscado : String->Movie->Bool
esDelGeneroBuscado genero pelicula = List.member genero (pelicula.genre)
-- **************
-- Requerimiento: filtrar las películas que sean aptas para menores de edad,
--                usando un checkbox;
-- **************

filtrarPeliculasPorMenoresDeEdad : Bool -> List Movie -> List Movie
filtrarPeliculasPorMenoresDeEdad mostrarSoloMenores peliculas=
    if (mostrarSoloMenores) then
       filter esApta peliculas
    else
       peliculas
esApta : Movie->Bool
esApta pelicula = pelicula.forKids
-- **************
-- Requerimiento: ordenar las películas por su rating;
-- **************

ordenarPeliculasPorRating : List Movie -> List Movie
ordenarPeliculasPorRating = sortBy (.rating)

-- **************
-- Requerimiento: dar like a una película
-- **************

darLikeAPelicula : Int -> List Movie -> List Movie
darLikeAPelicula idr peliculas = map (likearPorID idr) peliculas

likearPorID : Int->Movie->Movie
likearPorID idr pelicula= if (pelicula.id==idr) then  {pelicula | likes = pelicula.likes + 1}
  else pelicula

-- Requerimiento: cargar preferencias a través de un popup modal,
--                calcular índice de coincidencia de cada película y
--                mostrarlo junto a la misma;
-- **************

calcularPorcentajeDeCoincidencia : Preferences -> List Movie -> List Movie
calcularPorcentajeDeCoincidencia preferencias peliculas = map (chequearPreferencias preferencias) peliculas

chequearPreferencias : Preferences -> Movie -> Movie
chequearPreferencias preferencias = tieneGeneroSimilar(preferencias.genre)<<esGeneroPredilecto (preferencias.genre)<<tieneActorPreferencia (preferencias.favoriteActor)<<tienePalabrasPreferencia (preferencias.keywords)

tieneGeneroSimilar:String->Movie->Movie
tieneGeneroSimilar generoR pelicula =
  if (poseeSimilares generoR pelicula.genre) then
    sumarPorcentaje 15 pelicula
  else
    pelicula

poseeSimilares : String->List String->Bool
poseeSimilares generoR generos = any (parecidoA generoR) generos

parecidoA : String->String->Bool
parecidoA generoR genero =
   if (generoR=="Horror" && genero=="Suspense") then
     True
  else
    if (generoR=="Animated" && genero=="Family") then
      True
    else
      if(generoR=="Disney" && genero=="Superhero") then
        True
      else
        False


esGeneroPredilecto : String->Movie->Movie
esGeneroPredilecto generoR pelicula =
  if (esDelGeneroBuscado generoR pelicula) then
      sumarPorcentaje 60 pelicula
  else
      pelicula
poseeActorBuscado : String->Movie->Bool
poseeActorBuscado actor pelicula = List.member actor (pelicula.actors)

tieneActorPreferencia : String->Movie->Movie
tieneActorPreferencia actor pelicula =
  if (poseeActorBuscado actor pelicula) then
      sumarPorcentaje 50 pelicula
  else
      pelicula

tienePalabrasPreferencia palabras pelicula = if (peliculaTienePalabrasClave palabras pelicula) then
    sumarPorcentaje 20 pelicula
 else
    pelicula

sumarPorcentaje : Int->Movie->Movie
sumarPorcentaje porcentaje pelicula = {pelicula | matchPercentage = pelicula.matchPercentage + porcentaje}
