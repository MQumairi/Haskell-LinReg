module Input where

import Datasets

{- Defines the Input to the algorithm.
    Holdes:
      1. The Dataset (d)
      2. The learning rate (lr)
      3. The iterations (i)
-}

data Input = Input Dataset Float Int
  deriving (Show, Eq)

dataset :: Input -> Dataset
dataset (Input d _ _) = d

learningRate :: Input -> Float
learningRate (Input _ lr _) = lr

iterations :: Input -> Int
iterations (Input _ _ i) = i
