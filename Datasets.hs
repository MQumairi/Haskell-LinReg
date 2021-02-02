module Datasets where

import Matrices

{- Defines a Dataset.
    Holdes:
      1. The features Matrix (of shape m x n)
      2. The target Matrix (of shape m x 1)
      3. The number of samples (m)
      4. The number of features (n)
-}
data Dataset = Dataset Matrix Matrix Int Int
  deriving (Show, Eq)

features :: Dataset -> Matrix
features (Dataset f _ _ _) = f

targets :: Dataset -> Matrix
targets (Dataset _ t _ _) = t

noOfSamples :: Dataset -> Int
noOfSamples (Dataset _ _ m _) = m

noOfFeatures :: Dataset -> Int
noOfFeatures (Dataset _ _ _ n) = n