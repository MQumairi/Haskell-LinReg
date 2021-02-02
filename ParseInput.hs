module ParseInput where

import Data.Char
import Datasets
import Input
import Matrices (Matrix (..), shape)

-- Convert input from text file into a list of strings
inputToStrings :: String -> [String]
inputToStrings = lines

-- Remove the table headers (first row of text file)
removeHeaders :: [String] -> [String]
removeHeaders (x : xs) = xs

-- Takes a list of strings, and converts them to a list of Floats
convertToNumerals :: [String] -> [[Float]]
convertToNumerals = map wordsToFloat

--Takes a string of words (seperated by space), converts each word to float
wordsToFloat :: String -> [Float]
wordsToFloat s = map stringToFloat (words s)

--Takes a single word and converts it to a float
stringToFloat :: String -> Float
stringToFloat s = read s :: Float

--Takes 2D list of Floats (rows by columns), and builds the X and y matrices.
-- y is a Matrix comprised of the floats in the last column of the input
-- X is a Matrix comprised of all floats in the input, except for the last column
--Returns both X in y as Matrices in a tuple
splitXandY :: [[Float]] -> (Matrix, Matrix)
splitXandY input = (Matrix reducedX (length reducedX, length $ last reducedX), Matrix builtY (length builtY, length $ last builtY))
  where
    reducedX = reduceX input
    builtY = buildY input

--Takes 2D list of Floats, removes the last column in the 2D list
reduceX :: [[Float]] -> [[Float]]
reduceX = map removeLast

-- Take a list and removes the last element
removeLast :: [Float] -> [Float]
removeLast = init

-- Takes a 2D list of Floats, returns the last column in the 2D list
buildY :: [[Float]] -> [[Float]]
buildY input = [[last ys] | ys <- input]

-- Create the data from our 2-tuple of matrices
createData :: (Matrix, Matrix) -> Dataset
createData (m1, m2) = uncurry (Dataset m1 m2) (shape m1)

createInput :: Dataset -> Float -> Int -> Input
createInput = Input

-- Bringing it all together...
parseInput :: String -> String -> String -> Input
parseInput input lr i = createInput (createData $ splitXandY $ convertToNumerals $ removeHeaders $ inputToStrings input) lrFloat iInt
  where
    lrFloat = read lr :: Float
    iInt = read i :: Int
