module Main where

import Coefficients
import Datasets
import FeatureScale
import Input
import Matrices
import ParseInput
import Regression
import System.Directory
import System.IO

main :: IO ()
main = do
  putStrLn "Welcome to LinReg!\nThis is a haskell tool for solving regression problems developed by Mohammed Alqumairi.\nTo begin, please type the name of the file containing your dataset (e.g. input.txt)"
  textFile <- getLine
  inputString <- readFile textFile
  putStrLn "Please insert the learning rate you wish to use (e.g. 0.5)"
  learningRate <- getLine
  putStrLn "Please insert the number of epochs you wish the algorithm to run for (e.g. 1000)"
  iterations <- getLine
  putStrLn "Thank you. Please be patient while the software processes your request.\nTime needed to process will be proportional to size of your dataset and the number of epochs you chose."
  let parsedInput = parseInput inputString learningRate iterations
  let ranges = calcColRanges (features $ dataset parsedInput)
  -- print ranges
  let scaledInput = scaleInput parsedInput
  let output = linReg scaledInput
  let unscaledOutput = unscaleCoefficents output ranges
  putStr "Bias: "
  print (bias unscaledOutput)
  putStr "Weights: "
  print (value (weights unscaledOutput))
  putStrLn "Finished."