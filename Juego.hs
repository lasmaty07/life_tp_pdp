import Data.Char(intToDigit)

-- *************************** MODELO DE DATOS **************************************
-- ********** BORDES
-- Declara tipo Bordes, para saber si el mapa tiene bordes o no
data Bordes = Rectangulo(Int, Int) | SinBordes(Int, Int) deriving Show

-- ********** POINT
-- Declara tipo Point (x, y)
data Point = Point(Int, Int)
-- Hace que sea tipo show
instance Show Point where 
  show (Point(x, y)) = "(" ++ show x ++ "," ++ show y ++ ")"

-- ********** CELDA
-- Celda -> Puede ser ocupada o vacia. Programo el show
data Celda = CeldaOcupada(Point) | CeldaVacia(Point)
instance Show Celda where
  show (CeldaVacia(pt)) = "-" -- ++ show pt
  show (CeldaOcupada(pt)) = "0" -- ++ show pt
  --show (CeldaVacia(pt)) = show pt
  --show (CeldaOcupada(pt)) = show pt

crearCelda :: Bool -> Point -> Celda
crearCelda True pt = CeldaOcupada(pt)
crearCelda False pt = CeldaVacia(pt)

-- ********** MAPA
-- Toda la info del mapa
data Tablero = Tablero(Bordes, [[Celda]])
instance Show Tablero where
  show (Tablero(_, grilla)) = unlines ( map show grilla)


gr :: Tablero -> [[Celda]]
gr (Tablero(b, grilla)) = grilla

-- **************************** FUNCIONES **********************************
punto :: Celda -> Point
punto (CeldaVacia(pt)) = pt
punto (CeldaOcupada(pt)) = pt

estaActiva :: Celda -> Bool
estaActiva (CeldaOcupada(_)) = True
estaActiva (CeldaVacia(_)) = False

-- *************************** FUNCIONES **************************************

proximoPaso :: [[Celda]] -> Celda -> Celda
proximoPaso grilla (CeldaVacia(pt)) = 
  if (contarVecinos (CeldaVacia(pt)) grilla) == 3
    then CeldaOcupada(pt) -- nacimiento por reproduccion
    else CeldaVacia(pt)   -- ausencia
proximoPaso grilla (CeldaOcupada(pt)) =
  if cant > 4 || cant < 3
    then CeldaVacia(pt)
    else CeldaOcupada(pt)
  where
    cant = contarVecinos (CeldaOcupada(pt)) grilla

contarVecinos :: Celda -> [[Celda]] -> Int
contarVecinos celda grilla =
  length (filter estaActiva (vecinos (punto celda) grilla))

vecinos :: Point -> [[Celda]] -> [Celda]
vecinos (Point(x, y)) grilla =
  filter (isNeighbour x y) $ flatten grilla
  where
    flatten = foldl (++) []

isNeighbour :: Int -> Int -> Celda -> Bool
isNeighbour x y celda =
  (abs deltaX) <= 1 && (abs deltaY) <= 1 && 
  (not (deltaX == 0) || not (deltaY == 0))
  where
    deltaX = maxX - minX
    deltaY = maxY - minY
    maxX = max x x2
    maxY = max y y2
    minX = min x x2
    minY = min y y2
    (Point(x2, y2)) = punto celda

-- Matriz -> Dimension -> ConBordes -> pasos -> [[[Celda]]]
crearTablero :: [[Bool]] -> Int -> Bool -> Tablero
--Tablero(Bordes, [[Celda]])
crearTablero (bs:bss) n conBordes =
  Tablero(Rectangulo(n, n), matriz)
  where
    dim = [0..(n-1)]
    matriz = func2 (bs:bss) dim n

func2 :: [[Bool]] -> [Int] -> Int -> [[Celda]]
func2 [] _ _ = [[]]
func2 (bs:[]) (x:[]) n = (func3 bs x dim : []) where dim = [0..(n-1)]
func2 (bs:bss) (x:xs) n = (func3 bs x dim : func2 bss xs n) where dim = [0..(n-1)]

func3 :: [Bool] -> Int -> [Int] -> [Celda]
func3 (b:[]) x (y:[]) = (crearCelda b (Point(x, y)) : [])
func3 (b:bs) x (y:ys) = (crearCelda b (Point(x, y)) : func3 bs x ys)

-- Devuelve el siguiente estado de la grilla entera
proximaGeneracion :: [[Celda]] -> [[Celda]]
proximaGeneracion grilla = map playGameOfLife grilla
  where
    playGameOfLife celdas = map (proximoPaso grilla) celdas
    
--{--
main = do
  putStrLn "Press <enter> for next generation, q+<enter> to quit."
  waitForNextTick tablero 0 n
  where
    n = 6 -- CANTIDAD DE PASOS
    tablero = crearTablero [
      [True, True, False, False, True, False], 
      [True, True, True, False, True, False], 
      [False, True, False, True, True, False],
      [False, False, True, True, True, False],
      [False, False, True, True, True, False],
      [False, False, True, True, True, False]] 6 True

waitForNextTick tablero@(Tablero(borde, cellMatrix)) paso pasos = do
  putStr " "
  putStr $ "\nPaso " ++ [Data.Char.intToDigit paso] ++ ":\n" ++ (show tablero)
  if(paso < pasos) then waitForNextTick (Tablero(borde, proximaGeneracion cellMatrix)) (paso+1) pasos else putStr "Chau"
----}
{-- ASI VES LOS VECINOS DE UN PUNTO 
main = do
--
  asd ( vecinos (Point(1, 2)) (gr world))
  where
    world = crearTablero [
      [True, True, False, False, True, False], 
      [True, True, True, False, True, False], 
      [False, True, False, True, True, False],
      [False, False, True, True, True, False],
      [False, False, True, True, True, False],
      [False, False, True, True, True, False]] 6 True

asd grilla = do
  putStr $ "---\n" ++ (unlines ( map show grilla)) -- ++ (show grilla)

--}
--Tablero(border, G.proximaGeneracion cellMatrix)
