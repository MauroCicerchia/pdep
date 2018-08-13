module Backend exposing(..)
import Models exposing(Movie, Preferences)
import List exposing(filter,member,map,sortBy,all,any, reverse, length)
devTrue = identity

-- **************
-- Requerimiento: filtrar películas por su título a medida que se escribe en el buscador;
-- **************

filtrarPeliculasPorPalabrasClave : String -> List Movie -> List Movie
filtrarPeliculasPorPalabrasClave palabras = filter (peliculaTienePalabrasClave palabras)

-- esta función la dejamos casi lista, pero tiene un pequeño bug. ¡Corregilo!
--
-- Además tiene dos problemas, que también deberías corregir:
--
-- * distingue mayúsculas de minúsculas, pero debería encontrar a "Lion King" aunque escriba "kINg"
-- * busca una coincidencia exacta, pero si escribís "Avengers Ultron" debería encontrar a "Avengers: Age Of Ultron"
--
peliculaTienePalabrasClave : String->Movie->Bool
peliculaTienePalabrasClave palabras pelicula = all (tienePalabra pelicula) (String.words palabras)

tienePalabra : Movie->String->Bool
tienePalabra pelicula palabra = String.contains (String.toUpper palabra) (String.toUpper pelicula.title)
-- **************
-- Requerimiento: visualizar las películas según el género elegido en un selector;
-- **************

filtrarPeliculasPorGenero : String -> List Movie -> List Movie
filtrarPeliculasPorGenero genero = filter (esDelGeneroBuscado genero) << resetMovieList

esDelGeneroBuscado : String->Movie->Bool
esDelGeneroBuscado genero pelicula = List.member genero (pelicula.genre)

resetMovieList = always Models.moviesCollection

-- **************
-- Requerimiento: filtrar las películas que sean aptas para menores de edad,
--                usando un checkbox;
-- **************

filtrarPeliculasPorMenoresDeEdad : Bool -> List Movie -> List Movie
filtrarPeliculasPorMenoresDeEdad mostrarSoloMenores = filter (esNecesarioFiltrar mostrarSoloMenores)

esNecesarioFiltrar mostrarSoloMenores pelicula = not mostrarSoloMenores || pelicula.forKids

-- **************
-- Requerimiento: ordenar las películas por su rating;
-- **************

ordenarPeliculasPorRating : List Movie -> List Movie
ordenarPeliculasPorRating = reverse << sortBy (.rating)

-- **************
-- Requerimiento: dar like a una película
-- **************

darLikeAPelicula : Int -> List Movie -> List Movie
darLikeAPelicula idr = map (likearPorID idr)

likearPorID : Int->Movie->Movie
likearPorID idr pelicula=
  if (pelicula.id==idr) then
    {pelicula | likes = pelicula.likes + 1}
  else
    pelicula

-- Requerimiento: cargar preferencias a través de un popup modal,
--                calcular índice de coincidencia de cada película y
--                mostrarlo junto a la misma;
-- **************

calcularPorcentajeDeCoincidencia : Preferences -> List Movie -> List Movie
calcularPorcentajeDeCoincidencia preferencias = map (chequearPreferencias preferencias)

chequearPreferencias : Preferences -> Movie -> Movie
chequearPreferencias preferencias = tieneGeneroSimilar(preferencias.genre) << esGeneroPredilecto (preferencias.genre) << tieneActorPreferencia (preferencias.favoriteActor) << tienePalabrasPreferencia (preferencias.keywords)

tieneGeneroSimilar:String->Movie->Movie
tieneGeneroSimilar generoR pelicula =
  if (poseeSimilares generoR pelicula.genre) then
    sumarPorcentaje 15 pelicula
  else
    pelicula

poseeSimilares : String->List String->Bool
poseeSimilares generoR generos = any (parecidoA generoR) generos

parecidoA : String->String->Bool
parecidoA generoR genero = (generoR == "Horror" && genero == "Suspense") || (generoR == "Suspense" && genero == "Horror") || (generoR == "Animated" && genero == "Family") || (generoR == "Family" && generoR == "Animated") || (generoR == "Disney" && genero == "Superhero") || (generoR == "Superhero" && genero == "Disney") || (generoR == "Disney" && genero == "Animated") || (generoR == "Animated" && genero == "Disney")


esGeneroPredilecto : String->Movie->Movie
esGeneroPredilecto generoR pelicula =
  if (esDelGeneroBuscado generoR pelicula) then
      sumarPorcentaje 60 pelicula
  else
      pelicula

tieneActorPreferencia : String->Movie->Movie
tieneActorPreferencia actor pelicula =
  if (poseeActorBuscado actor pelicula) then
      sumarPorcentaje 50 pelicula
  else
      pelicula

poseeActorBuscado : String->Movie->Bool
poseeActorBuscado actor pelicula = List.member actor (pelicula.actors)

tienePalabrasPreferencia : String -> Movie -> Movie
tienePalabrasPreferencia palabras pelicula = sumarPorcentaje ((cantidadDePalabras pelicula palabras)*20) pelicula

cantidadDePalabras : Movie -> String -> Int
cantidadDePalabras pelicula = length << filter (tienePalabra pelicula) << String.words

--tienePalabrasPreferencia palabras pelicula = if (peliculaTienePalabrasClave palabras pelicula) then
--    sumarPorcentaje 20 pelicula
-- else
--    pelicula

sumarPorcentaje : Int->Movie->Movie
sumarPorcentaje porcentaje pelicula =
  if pelicula.matchPercentage + porcentaje <= 100 then
    {pelicula | matchPercentage = pelicula.matchPercentage + porcentaje}
  else
    {pelicula | matchPercentage = 100}
