module MicroEntrega1 where
import Text.Show.Functions

data Microprocesador = Microprocesador {programCounter :: Int, acumuladorA :: Int, acumuladorB :: Int, memoria :: Memoria, programa :: Instruccion, mensajeError :: String} deriving Show
type Posicion = Int
type Dato = Int
type Memoria = [(Posicion, Dato)]
type Instruccion = Microprocesador -> Microprocesador

xt8088 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], programa = (nop.nop.nop), mensajeError = ""}
at8086 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], programa = id, mensajeError = ""}
fp20 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], programa = id, mensajeError = ""}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--FUNCIONES PRINCIPALES

operar :: Instruccion -> Instruccion
operar funcion micro
  | tieneError micro = micro
  | otherwise = (aumentarProgramCounter.funcion) micro

nop :: Instruccion
nop = operar id

lodv :: Int -> Instruccion
lodv val = operar (cargarEnA val)

swap :: Instruccion
swap = operar intercambiarAB

add :: Instruccion
add = operar sumarAB

divide :: Instruccion
divide = operar dividirAB

str :: Int -> Int -> Instruccion
str addr val = operar ((cargarNuevoEnMemoria addr val).(eliminarAnteriorDeMemoria addr))
lod :: Int -> Instruccion
lod addr micro = operar (cargarEnA (contenidoDe addr micro)) micro

cargarPrograma :: Instruccion -> Instruccion
cargarPrograma instruccion micro = micro {programa = instruccion}

ejecutarPrograma :: Microprocesador -> Microprocesador
ejecutarPrograma micro = (programa micro) micro

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--FUNCIONES AUXILIARES

aumentarProgramCounter :: Instruccion
aumentarProgramCounter micro = micro {programCounter = ((+1).programCounter) micro}

-- Se usa en lodv
cargarEnA :: Int -> Instruccion
cargarEnA valor micro = micro {acumuladorA = valor}

-- Se usa en swap
intercambiarAB :: Instruccion
intercambiarAB micro = micro {acumuladorA = acumuladorB micro, acumuladorB = acumuladorA micro}

-- Se usa en add
sumarAB :: Instruccion
sumarAB micro = micro {acumuladorA = (acumuladorA micro) + (acumuladorB micro), acumuladorB = 0}

-- Se usa en divide
dividirAB :: Instruccion
dividirAB (Microprocesador pc a 0 mem prog mensaje) = errorDivisionPorCero (Microprocesador pc a 0 mem prog mensaje)
dividirAB micro = micro {acumuladorA = div (acumuladorA micro) (acumuladorB micro), acumuladorB = 0}

-- Se usa en dividirAB
errorDivisionPorCero :: Instruccion
errorDivisionPorCero micro = micro {mensajeError = "DIVISION BY ZERO"}  --Si B==0

-- Se usa en str y lod
cargarNuevoEnMemoria :: Int -> Int -> Instruccion
cargarNuevoEnMemoria direccion valor micro = micro {memoria = (direccion, valor) : (memoria micro)}

-- Se usa en str y lod
eliminarAnteriorDeMemoria :: Int -> Instruccion
eliminarAnteriorDeMemoria direccion micro = micro {memoria = ((eliminarRepetidos direccion).memoria) micro}

--Se usa en eliminarAnterior
eliminarRepetidos :: Int -> Memoria -> Memoria
eliminarRepetidos direccion = filter ((/=direccion).fst)

--Se usa en lod
contenidoDe :: Int -> Microprocesador -> Int
contenidoDe direccion  = snd.head.(encontrarDireccion direccion).memoria

--Se usa en contenidoDe
encontrarDireccion :: Int -> Memoria -> Memoria
encontrarDireccion direccion = filter ((==direccion).fst)

--Se usa en operar
tieneError :: Microprocesador -> Bool
tieneError (Microprocesador _ _ _ _ _ "") = False
tieneError _ = True

--Se usa en punto4a
inicializar8086 :: Instruccion
inicializar8086 micro = micro {memoria = inicializarMemoria8086}

--Se usa en inicializar8086
inicializarMemoria8086 :: Memoria
inicializarMemoria8086 = ((take 20).(iterate incrementarDupla)) (1,1)

--Se usa en inicializarMemoria8086
incrementarDupla :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDupla (a, b) = (a + 1, b + 1)

--Se usa en punto4b
inicializar8088 :: Instruccion
inicializar8088 micro = micro {memoria = inicializarMemoria8088}

--Se usa en inicializar8088
inicializarMemoria8088 :: Memoria
inicializarMemoria8088 = ((take 1024).(iterate incrementarDireccion)) (1,0)

--Se usa en inicializarMemoria8088
incrementarDireccion :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDireccion (a, b) = (a + 1, b)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASOS DE PRUEBA

punto2 = nop.nop.nop

punto3 = add.(lodv 22).swap.(lodv 10)

punto4a = (str 2 5).inicializar8086

punto4b = (lod 2).inicializar8088

punto4c = divide.(lod 1).swap.(lod 2).(str 2 0).(str 1 2)

punto4d = divide.(lod 1).swap.(lod 2).(str 2 4).(str 1 12)
