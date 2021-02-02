module Coefficients where

import Matrices

{- Defines the Coefficients type.
    Holdes:
      1. The theta1 matrix
      2. The theta0 bias
-}
data Coefficients = Coefficients Matrix Float
  deriving (Show, Eq)

weights :: Coefficients -> Matrix
weights (Coefficients p _) = p

bias :: Coefficients -> Float
bias (Coefficients _ b) = b