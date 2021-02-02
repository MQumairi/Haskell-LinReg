module Matrices where

-- Matrix type, holding the matrix itself (2D list of floats) and the shape of the matrix (2-tuple of ints representing the number of rows and cols)
data Matrix = Matrix [[Float]] (Int, Int)
  deriving (Show, Eq)

-- Get the value of the matrix
value :: Matrix -> [[Float]]
value (Matrix v _) = v

-- Get the shape of the matrix
shape :: Matrix -> (Int, Int)
shape (Matrix _ s) = s

-- MATRIX OPERATIONS
-- Takes a numerical operation (+, -, * or /), a Matrix, and a Float, and performs the operation using the Float on each element in the Matrix
scalarOp :: (Float -> Float -> Float) -> Matrix -> Float -> Matrix
scalarOp operation matrix scalar = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  where
    matrixVal = [[operation x scalar | x <- row] | row <- value matrix]

-- Takes a numerical operation (+, -, * or /), and two Matrices, and performs an element wise operation on them
-- If the second matrix is a vector, 'broadcast' it.
eleWiseOp :: (Float -> Float -> Float) -> Matrix -> Matrix -> Matrix
eleWiseOp operation m1 m2
  | shape m1 == shape m2 = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  | fst (shape m1) == fst (shape m2) && snd (shape m2) == 1 = Matrix matrixVal2 (length matrixVal, length $ last matrixVal)
  | otherwise = error "Input matricies may have incompatible shapes"
  where
    matrixVal = [[operation x1 x2 | (x1, x2) <- zip row1 row2] | (row1, row2) <- zip (value m1) (value m2)]
    matrixVal2 = [[x * last row2 | x <- row1] | (row1, row2) <- zip (value m1) (value m2)]

-- Take a Matrix (shape m by n) and a vector (shape n by 1), and returns the dot product
dotVector :: Matrix -> Matrix -> Matrix
dotVector m v
  | snd (shape m) == fst (shape v) && snd (shape v) == 1 = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  | snd (shape v) /= 1 = error "Second param not a vector"
  | otherwise = error "Input matricies may have incompatible shapes"
  where
    matrixVal = [[sum [x1 * last x2 | (x1, x2) <- zip row (value v)]] | row <- value m]

-- Takes a vector (shape n by 1) and sums all values
sumVector :: Matrix -> Float
sumVector v
  | snd (shape v) /= 1 = error "Input not a vector"
  | otherwise = sum [last row | row <- value v]

-- Taken from https://stackoverflow.com/questions/2578930/understanding-this-matrix-transposition-function-in-haskell
transpose :: [[a]] -> [[a]]
transpose ([] : _) = []
transpose x = map head x : transpose (map tail x)

-- Takes a Matrix (m by n), and sums all columns, returning the total as a matrix (n by 1)
sumCols :: Matrix -> Matrix
sumCols m1 = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  where
    matrixVal = [[sum row] | row <- transpose (value m1)]

-- Takes an int n, and creates an n by 1 matrix of zeros
zeros :: Int -> Matrix
zeros n = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  where
    matrixVal = replicate n [0]

-- TEST MATRICES
-- Some test matricies used to test the above operations
test1 :: Matrix
test1 = Matrix [[2.0, 7.0, 3.0], [6.0, 6.0, 0.0], [0.0, 4.0, 6.0], [8.0, 4.0, 5.0], [2.0, 8.0, 9.0], [5.0, 0.0, 3.0], [6.0, 1.0, 6.0], [3.0, 5.0, 0.0], [5.0, 2.0, 4.0], [3.0, 1.0, 5.0]] (10, 3)

test2 :: Matrix
test2 = Matrix [[14.0], [10.0], [10.0], [12.0], [19.0], [6.0], [14.0], [10.0], [11.0], [13.0]] (10, 1)

test3 :: Matrix
test3 = Matrix [[2.0, 7.0, 3.0], [6.0, 6.0, 0.0]] (2, 3)

test4 :: Matrix
test4 = Matrix [[0.0, 4.0, 6.0], [8.0, 4.0, 5.0]] (2, 3)

test5 :: Matrix
test5 = Matrix [[1.0], [2.0], [3.0]] (3, 1)

test6 :: Matrix
test6 = Matrix [[1], [2], [3], [4], [5]] (5, 1)

test7 :: Matrix
test7 = Matrix [[10, 20], [10, 20], [10, 20], [10, 20], [10, 20]] (5, 2)

test8 :: Matrix
test8 = Matrix [[10], [9], [8], [7], [6]] (5, 1)

test9 :: Matrix
test9 = Matrix [[50.0], [100.0]] (2, 1)

test10 :: Matrix
test10 = Matrix [[0.5, 5, 5000], [0.2, 2, 2000], [0.3, 3, 3000]] (3, 3)