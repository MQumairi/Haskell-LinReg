module Regression where

import Coefficients
import Datasets
import Input
import Matrices

-- Takes the features (X), theta1 Matrix (weights), theta0 Float (bias), and returns a hypothesis based on current parameters
hypothesize :: Matrix -> Matrix -> Float -> Matrix
hypothesize features theta1 = scalarOp (+) (dotVector features theta1)

-- Calculates gradients for theta0 (partial derivative of cost function with respect to bias)
-- Takes in the predictions (calculated through hypothesize), the target (y), and the number of samples
theta0Gradient :: Matrix -> Matrix -> Int -> Float
theta0Gradient prediction target m = sumVector $ scalarOp (/) (eleWiseOp (-) prediction target) mf
  where
    mf = fromIntegral m :: Float

-- Calculates gradients for each theta1 (partial derivative of cost function with respect to each weight)
-- Takes in the features (X) predictions (calculated through hypothesize), the target (y), and the number of samples
-- Returns all theta1s as a matrix (n by 1, where n is the number of columns in the X).
theta1Gradient :: Matrix -> Matrix -> Matrix -> Int -> Matrix
theta1Gradient features prediction target m = scalarOp (/) (sumCols (eleWiseOp (*) features (eleWiseOp (-) prediction target))) mf
  where
    mf = fromIntegral m :: Float

-- Performs gradient descent for i epochs (first parameter)
gradDescent :: Int -> Dataset -> Float -> Matrix -> Float -> Coefficients
gradDescent iterations dataset theta0 theta1 lr
  | iterations <= 0 = Coefficients weights bias
  | otherwise = gradDescent (iterations - 1) dataset bias weights lr
  where
    weights = eleWiseOp (-) theta1 (scalarOp (*) (theta1Gradient (features dataset) (hypothesize (features dataset) theta1 theta0) (targets dataset) (noOfSamples dataset)) lr)
    bias = theta0 - (theta0Gradient (hypothesize (features dataset) theta1 theta0) (targets dataset) (noOfSamples dataset) * lr)

-- Bringing it all together...
linReg :: Input -> Coefficients
linReg input = gradDescent i d theta0 theta1 lr
  where
    i = iterations input
    d = dataset input
    theta0 = 0.0
    theta1 = zeros (noOfFeatures d)
    lr = learningRate input
