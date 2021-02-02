# LinReg

## About

LinReg is a regression problem solver, that makes use of the Linear Regression and Gradient Descent algorithms. It takes in a dataset, and calculates the weights and bias for the hyperplane of best fit.

This ReadMe is a summarized version of [READMELong](./READMELong.md) to satisfy the 2KB limit.

## How to Run the Program

Ensure current directory is the "coursework" folder. Run:\
`runhaskell Main`

You will be asked to type the name of the text file containing your dataset. Let's use an example dataset found in input.txt. Type:\
`input.txt`

You will be asked to insert the learning rate you wish to use. Type:\
`0.5`

You will then be asked to insert the number of epochs you wish the algorithm to run for. Type:\
`1000`

Notice: The learning rate and number of epochs, may need be tuned for different datasets.

Wait for execution. Time needed is proportional to size of dataset, and number of epochs chosen.

LinReg will output a value for the bias, and a list holding the weights.

## Verifying the Results

The output from LinReg may be evaluated by comparing it with results obtained using Scikit-Learn.

Ensure current directory is the "coursework" folder. Run:\
`python Verifier.py`

You will be asked to type the name of the text file. For example:\
`input.txt`

You can compare the output with the results obtained using LinReg.

## About the Code

The main function (Main.hs) is the single point of IO interaction. The user chooses the txt file holding the dataset.

The txt file is passed to parseInput (ParseInput.hs), its purpose is to parse the txt file into matricies that can be used for calculations. Datatypes representing matrices (Matrices.hs), the dataset (Datasets.hs), and the complete input (Input.hs) were coded to improve modularity. Input is feature scaled to improve performance (FeatureScale.hs).

The matricies, are then passed to linReg (Regression.hs) for linear regression. This makes use of various higher order functions in Matrices.hs (e.g. eleWiseOp), as well as recursion (gradDescent in Regression.hs), to calculate the weights and bias. The weights and bias are stored as a Coefficients datatype (Coefficients.hs), and printed to console.

## Third Party Contributions

- transpose function (Matrices.hs) was taken from: https://stackoverflow.com/questions/2578930/understanding-this-matrix-transposition-function-in-haskell
- boston dataset (boston.txt) was taken from: https://www.kaggle.com/vikrishnan/boston-house-prices
