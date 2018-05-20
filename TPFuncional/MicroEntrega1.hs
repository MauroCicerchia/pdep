module MicroEntrega1 where
import Data.List
import Text.Show.Functions
import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

data Microprocesador = Microprocesador {programCounter :: Dato, acumuladorA :: Dato, acumuladorB :: Dato, memoria :: Memoria, programa :: Programa, mensajeError :: String} deriving Show
type Posicion = Int
type Dato = Int
type Memoria = [(Posicion, Dato)]
type Instruccion = Microprocesador -> Microprocesador
type Programa = [Instruccion]

xt8088 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [], programa = [], mensajeError = ""}
at8086 = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = memoria8086, programa = [], mensajeError = ""}
fp20 = Microprocesador {programCounter = 0, acumuladorA = 7, acumuladorB = 24, memoria = [], programa = [], mensajeError = ""}
infinityMicro = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = memoriaInfinita, programa = [], mensajeError = ""}
microDesorden = Microprocesador {programCounter = 0, acumuladorA = 0, acumuladorB = 0, memoria = [(1,2),(2,5),(3,1),(4,0),(5,6),(6,9)], programa = [], mensajeError = ""}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--FUNCIONES PRINCIPALES

operar :: Instruccion -> Instruccion
operar funcion micro
  | tieneError micro = micro
  | otherwise = (aumentarProgramCounter.funcion) micro

nop :: Instruccion
nop = operar id

lodv :: Dato -> Instruccion
lodv val = operar (cargarEnA val)

swap :: Instruccion
swap = operar intercambiarAB

add :: Instruccion
add = operar sumarAB

divide :: Instruccion
divide = operar dividirAB

str :: Posicion -> Dato -> Instruccion
str addr val = operar (ordenarMemoria.cargarNuevoEnMemoria addr val.eliminarAnteriorDeMemoria addr)

lod :: Posicion -> Instruccion
lod addr micro = operar (cargarEnA (contenidoDe addr micro)) micro

cargarPrograma :: [Instruccion] -> Instruccion
cargarPrograma instrucciones micro = micro {programa = instrucciones}

ejecutarPrograma :: Instruccion
ejecutarPrograma micro = (compilar.programa) micro $ micro

ifnz :: Instruccion -> Instruccion
--ifnz [] micro = micro
ifnz _ (Microprocesador pC 0 acumB mem prog menError) = (Microprocesador pC 0 acumB mem prog menError)
ifnz instruccion micro = instruccion micro
--ifnz lista = compilar lista
--ifnz (x:xs) micro = ifnz xs (x micro)

depurar :: Programa -> Microprocesador -> Programa
depurar [] _ = []
depurar (cabeza:cola) micro
  | esInstruccionInnecesaria cabeza micro = depurar cola micro
  | otherwise = cabeza : depurar cola micro

memoriaEstaOrdenada :: Microprocesador -> Bool
memoriaEstaOrdenada micro = ((map snd).memoria) micro == (sort.(map snd).memoria) micro
----------------------------------------------------------------------------------------------------------------------------------------------------------------

--FUNCIONES AUXILIARES

aumentarProgramCounter :: Instruccion
aumentarProgramCounter micro = micro {programCounter = ((+1).programCounter) micro}

-- Se usa en lodv
cargarEnA :: Dato -> Instruccion
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
cargarNuevoEnMemoria :: Posicion -> Dato -> Instruccion
cargarNuevoEnMemoria direccion valor micro = micro {memoria = (direccion, valor) : (memoria micro)}

-- Se usa en str y lod
eliminarAnteriorDeMemoria :: Posicion -> Instruccion
eliminarAnteriorDeMemoria direccion micro = micro {memoria = ((eliminarRepetidos direccion).memoria) micro}

--Se usa en eliminarAnterior
eliminarRepetidos :: Posicion -> Memoria -> Memoria
eliminarRepetidos direccion = filter ((/=direccion).fst)

--Se usa en str
ordenarMemoria :: Instruccion
ordenarMemoria micro = micro {memoria = sort.memoria $ micro}

--Se usa en lod
contenidoDe :: Posicion -> Microprocesador -> Dato
contenidoDe direccion  = snd.(encontrarDireccion direccion).memoria

--Se usa en contenidoDe
encontrarDireccion :: Posicion -> Memoria -> (Posicion, Dato)
encontrarDireccion direccion = head.filter ((==direccion).fst)

--Se usa en operar
tieneError :: Microprocesador -> Bool
tieneError (Microprocesador _ _ _ _ _ "") = False
tieneError _ = True

compilar :: [Instruccion] -> Instruccion
compilar [] = id
compilar instrucciones = foldl1 (.) instrucciones

esInstruccionInnecesaria :: Instruccion -> Microprocesador -> Bool
esInstruccionInnecesaria instruccion micro = sonCeroAcumuladores instruccion micro && esCeroMemoria instruccion micro

sonCeroAcumuladores :: Instruccion -> Microprocesador -> Bool
sonCeroAcumuladores instruccion micro = ((==0).acumuladorA.instruccion) micro && ((==0).acumuladorB.instruccion) micro

esCeroMemoria :: Instruccion -> Microprocesador -> Bool
esCeroMemoria instruccion = (all ((==0).snd)).memoria.instruccion

memoria8086 :: Memoria
memoria8086 = ((take 20).(iterate incrementarDupla)) (1,1)

--Se usa en inicializarMemoria8086
incrementarDupla :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDupla (a, b) = (a + 1, b + 1)

--Se usa en punto4b
inicializar8088 :: Instruccion
inicializar8088 micro = micro {memoria = memoria8088}

--Se usa en inicializar8088
memoria8088 :: Memoria
memoria8088 = take 1024 memoriaInfinita

memoriaInfinita :: Memoria
memoriaInfinita = iterate incrementarDireccion (1,0)

--Se usa en inicializarMemoria8088
incrementarDireccion :: (Posicion, Dato) -> (Posicion, Dato)
incrementarDireccion (a, b) = (a + 1, b)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASOS DE PRUEBA

punto2 = nop.nop.nop

punto3 = add.(lodv 22).swap.(lodv 10)

punto4a = (str 2 5)

punto4b = (lod 2).inicializar8088

punto4c = divide.(lod 1).swap.(lod 2).(str 2 0).(str 1 2)

punto4d = divide.(lod 1).swap.(lod 2).(str 2 4).(str 1 12)

main :: IO ()
main = hspec $ do
  describe "Prelude.head" $ do
    it "4.2 programCounter == 4" $ do
      (programCounter.punto3 $ xt8088) `shouldBe` (4 :: Dato)

    it "4.2 acumuladorA == 32" $ do
      (acumuladorA.punto3 $ xt8088) `shouldBe` (32 :: Dato)

    it "4.2 acumuladorB == 0" $ do
      (acumuladorB.punto3 $ xt8088) `shouldBe` (0 :: Dato)

    it "4.2 programCounter == 6" $ do
      (programCounter.punto4c $ xt8088) `shouldBe` (6 :: Dato)

    it "4.2 acumuladorA == 2" $ do
      (acumuladorA.punto4c $ xt8088) `shouldBe` (2 :: Dato)

    it "4.2 acumuladorB == 0" $ do
      (acumuladorB.punto4c $ xt8088) `shouldBe` (0 :: Dato)

    it "4.2 mensajeError == 'DIVISION BY ZERO'" $ do
      (mensajeError.punto4c $ xt8088) `shouldBe` ("DIVISION BY ZERO" :: String)

    it "4.2 memoria == [(1,2),(2,0)]" $ do
      (take 2.memoria.punto4c $ xt8088) `shouldBe` ([(1,2),(2,0)] :: Memoria)

    it "4.3 acumuladorA == 24" $ do
      (acumuladorA.ifnz (swap.(lodv 3)) $ fp20) `shouldBe` (24 :: Dato)

    it "4.3 acumuladorB == 3" $ do
      (acumuladorB.ifnz (swap.(lodv 3)) $ fp20) `shouldBe` (3 :: Dato)

    it "4.3 acumuladorA == 0" $ do
      (acumuladorA.ifnz (swap.(lodv 3)) $ xt8088) `shouldBe` (0 :: Dato)

    it "4.3 acumuladorB == 0" $ do
      (acumuladorB.ifnz (swap.(lodv 3)) $ xt8088) `shouldBe` (0 :: Dato)

    it "4.4 length programaDepurado == 2" $ do
      (length.(depurar [(str 2 0),(str 1 3),(lodv 0),(lodv 133),nop,swap]) $ xt8088) `shouldBe` (2 :: Int)

    it "4.5 memoriaEstaOrdenada at8086 == True" $ do
      (memoriaEstaOrdenada at8086) `shouldBe` (True :: Bool)

    it "4.5 memoriaEstaOrdenada microDesorden == False" $ do
      (memoriaEstaOrdenada microDesorden) `shouldBe` (False :: Bool)
