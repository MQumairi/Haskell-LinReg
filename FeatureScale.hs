module FeatureScale where

import Coefficients
import Datasets
import Input
import Matrices (Matrix (..), eleWiseOp, transpose, value)

-- Takes in an Input, outputs the same Input feature scaled.

-- Takes in Martrix, returns a Vector of the ranges (+1 in case range is 0) for each Matrix column
calcColRanges :: Matrix -> Matrix
calcColRanges m = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  where
    matrixVal = [[maximum row] | row <- transpose $ value m]

-- Takes a matrix, returns the same matrix with each X feature scaled
scaleMatrix :: Matrix -> Matrix
scaleMatrix m = Matrix matrixVal (length matrixVal, length $ last matrixVal)
  where
    matrixVal = transpose [[x1 / head row2 | x1 <- row1] | (row1, row2) <- zip (transpose $ value m) (value $ calcColRanges m)]

-- Takes an input, returns the same input except that the features Matrix is feature scaled
scaleInput :: Input -> Input
scaleInput (Input (Dataset f t m n) lr epochs) = Input datasetVal lr epochs
  where
    datasetVal = Dataset (scaleMatrix f) t m n

-- Takes coefficients, ranges vector and returns the same coefficients unscaled
unscaleCoefficents :: Coefficients -> Matrix -> Coefficients
unscaleCoefficents (Coefficients weights bias) ranges = Coefficients weightsUnscaled bias
  where
    weightsUnscaled = eleWiseOp (/) weights ranges