module MicroEntrega1 where
import Text.Show.Functions

data Microprocesador = Microprocesador {programCounter :: Int, acumuladorA :: Int, acumuladorB :: Int, memoria :: Memoria, mensajeError :: String} deriving Show
type Posicion = Int
type Dato = Int
type Memoria = [(Posicion, Dato)]

xt8088 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], mensajeError = ""}

----------------------------------------------------------------------------------------------------------------------------------------------------------------

nop :: Microprocesador -> Microprocesador
nop = aumentarProgramCounter

lodv :: Int -> Microprocesador -> Microprocesador
lodv val = aumentarProgramCounter.(cargarEnA val)

swap :: Microprocesador -> Microprocesador
swap = aumentarProgramCounter.intercambiarAB

add :: Microprocesador -> Microprocesador
add = aumentarProgramCounter.sumarAB

divide :: Microprocesador -> Microprocesador
divide = aumentarProgramCounter.dividirAB

str :: Int -> Int -> Microprocesador -> Microprocesador
str addr val = aumentarProgramCounter.(cargarNuevo addr val).(eliminarAnterior addr)

lod :: Int -> Microprocesador -> Microprocesador
lod addr micro = (aumentarProgramCounter.(cargarEnA (contenidoDe addr micro))) micro

----------------------------------------------------------------------------------------------------------------------------------------------------------------

aumentarProgramCounter :: Microprocesador -> Microprocesador
aumentarProgramCounter micro = micro {programCounter = (programCounter micro) + 1}

-- Se usa en lodv
cargarEnA :: Int -> Microprocesador -> Microprocesador
cargarEnA valor micro = micro {acumuladorA = valor}

-- Se usa en swap
intercambiarAB :: Microprocesador -> Microprocesador
intercambiarAB micro = micro {acumuladorA = acumuladorB micro, acumuladorB = acumuladorA micro}

-- Se usa en add
sumarAB :: Microprocesador -> Microprocesador
sumarAB micro = micro {acumuladorA = (acumuladorA micro) + (acumuladorB micro), acumuladorB = 0}

-- Se usa en divide
dividirAB :: Microprocesador -> Microprocesador
dividirAB micro
	| ((/=0).acumuladorB) micro = micro {acumuladorA = div (acumuladorA micro) (acumuladorB micro), acumuladorB = 0}
  | otherwise = accionError micro

-- Se usa en dividirAB
accionError :: Microprocesador -> Microprocesador
accionError micro = micro {mensajeError = "DIVISION BY ZERO"}  --Si B==0

-- Se usa en str y lod
cargarNuevo :: Int -> Int -> Microprocesador -> Microprocesador
cargarNuevo direccion valor micro = micro {memoria = (direccion, valor) : (memoria micro)}

-- Se usa en str y lod
eliminarAnterior :: Int -> Microprocesador -> Microprocesador
eliminarAnterior direccion micro = micro {memoria = ((filtrarRepetidos direccion).memoria) micro}

--Se usa en eliminarAnterior
filtrarRepetidos :: Int -> Memoria -> Memoria
filtrarRepetidos direccion lista = filter ((/=direccion).fst) lista

--Se usa en lod
contenidoDe :: Int -> Microprocesador -> Int
contenidoDe direccion  = snd.head.(filter ((==direccion).fst)).memoria


--snd.(find ((==direccion).fst)).memoria

--Se usa en contenidoDe
--find _ [] = (0,0)
--find condicion (x:xs)
--	| condicion x = x
--  | otherwise = find condicion xs
