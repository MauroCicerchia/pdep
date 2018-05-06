module MicroEntrega1 where
import Text.Show.Functions

data Microprocesador = Microprocesador {programCounter :: Int, acumuladorA :: Int, acumuladorB :: Int, memoria :: Memoria, mensajeError :: String} deriving Show
type Posicion = Int
type Dato = Int
type Memoria = [(Posicion, Dato)]

xt8088 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], mensajeError = ""}
at8086 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], mensajeError = ""}
fp20 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], mensajeError = ""}

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--FUNCIONES PRINCIPALES

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

--FUNCIONES AUXILIARES

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
eliminarAnterior direccion micro = micro {memoria = ((eliminarRepetidos direccion).memoria) micro}

--Se usa en eliminarAnterior
eliminarRepetidos :: Int -> Memoria -> Memoria
eliminarRepetidos direccion lista = filter ((/=direccion).fst) lista

--Se usa en lod
contenidoDe :: Int -> Microprocesador -> Int
contenidoDe direccion  = snd.head.(encontrarDireccion direccion).memoria

--Se usa en contenidoDe
encontrarDireccion :: Int -> Memoria -> Memoria
encontrarDireccion direccion = filter ((==direccion).fst)

--Se usa en punto4a
inicializar8086 :: Microprocesador -> Microprocesador
inicializar8086 micro = micro {memoria = inicializarMemoria8086}

--Se usa en inicializar8086
inicializarMemoria8086 :: Memoria
inicializarMemoria8086 = ((take 20).(iterate incrementarDupla)) (1,1)

--Se usa en inicializarMemoria8086
incrementarDupla :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDupla (a, b) = (a + 1, b + 1)

--Se usa en punto4b
inicializar8088 :: Microprocesador -> Microprocesador
inicializar8088 micro = micro {memoria = inicializarMemoria8088}

--Se usa en inicializar8088
inicializarMemoria8088 :: Memoria
inicializarMemoria8088 = ((take 1024).(iterate incrementarDireccion)) (1,0)

--Se usa en inicializarMemoria8088
incrementarDireccion :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDireccion (a, b) = (a + 1, b)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASOS DE PRUEBA

punto2 = nop.nop.nop    --Para lograr este punto interviene el concepto de composición

punto3 = add.(lodv 22).swap.(lodv 10)

punto4a = (str 2 5).inicializar8086

punto4b = (lod 2).inicializar8088

punto4c = divide.(lod 1).swap.(lod 2).(str 2 0).(str 1 2)

punto4d = divide.(lod 1).swap.(lod 2).(str 2 4).(str 1 12)