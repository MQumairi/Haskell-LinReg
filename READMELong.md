# LinReg

#### By Mohammed Alqumairi

## About

LinReg is a regression problem solver, that makes use of the Linear Regression and Gradient Descent algorithms. It takes in a dataset, and calculates the weights and bias for the hyperplane of best fit. These can then be used to make predictions about unknown samples.

The equation for the hypothesis (h) of a multi-variate linear regression:

### h = b + (w1 \* x1) + (w2 \* x2) + (w3 \* x3) ... + (wn \* xn)

Where:

- b is the bias (aka the intercept)
- w is the weight. One weight for each feature (corresponding to a column in the dataset), until wn
- x is the feature value for a specific sample
- n is the number of features

LinReg calculates the bias term, and a weight for each feature. The bias will be outputed as a float. The weights will be outputed as a list, of length n. One weight for each feature, in the order those features appear in the dataset.

This ReadMe will hold instructions detailing how to use LinReg. For a summarized version, see the [shortened README](./README.md).

## Contents

- [How to Run the Program](#howto)
- [Formatting the Input File](#input)
- [Verifying the Results](#verify)
- [How to Tune Learning Rate and Epochs](#tune)
- [Tests](#tests)
- [About the Code](#code)
- [Encountered Challenge](#challenge)
- [Third Party Contributions](#references)

## How to Run the Program <a name="howto"></a>

**Step 1:** Ensure your current directory is the "coursework" folder that this file is contained in. Then run:\
`runhaskell Main`

**Step 2:** You will be greeted with a welcome message, and asked to type the name of the text file holding your dataset. Let's use an example dataset found in input.txt. Type:\
`input.txt`

To use your own input file, [ensure it is formatted correctly](#input).

**Step 3:** You will be asked to insert the learning rate you wish to use for the purposes of gradient descent. Type:\
`0.5`

**Step 4:** You will then be asked to insert the number of epochs you wish the gradient descent algorithm to run for. Assuming your learning rate is small enough, the more the epochs, the more accurate the result will be. This however comes at the cost of performance. Let's go with 1000 epochs for now. Type:\
`1000`

Notice: The learning rate and number of epochs, may need be tuned for different datasets. For information on how to tune them, [read below](#tune).

**Result:** After some time (proportional to the size of the dataset, and the number of epochs chosen), LinReg will output a value for the bias, and a list of weights. You can compare these results with those calculated by Scikit-Learn [using the Python Verifier](#verify). As you can see, LinReg can achieve very accurate results!

## Formatting the Input file <a name="input"></a>

The input file will hold your dataset. This will be a text file (.txt) that you must place inside the "coursework" folder.

The dataset in the input file is a table, formatted using the following rules:
- Every row of the table corresponds to a new line in the text file 
- Every column is separated with a single space
- The first row is the header row, holding the title for each column. The final column is your target column.
- For the functioning of the Python Verifier, the final column must be titled "y"
- Apart from the first header row in the text file, all values in the dataset must be numerical

Feel free to check the sample input files (input.txt, input1.txt, input2.txt, input3.txt, and boston.txt) if you require further clarification.

## Verifying the Results <a name="verify"></a>

The output from LinReg may be evaluated by comparing it with results obtained using an established statistics library. For the examiner's convenience, I have included a "Verifier.py" file which makes use of Scikit-Learn for this purpose. This is not necessary for the functioning of LinReg, and the examiner is free to select another method for verification purposes.

To use Verifier.py, ensure you have Python, Numpy, Pandas, and Scikit-Learn installed. The script was tested using Python 3.8.3 using the Anaconda environment. Then follow the steps below.

**Step 1:** Ensure your current directory is the "coursework" folder. Run:\
`python Verifier.py`

**Step 2:** You will be prompted to enter the name of the text file containing your dataset. Type that in. For example:\
`input.txt`

**Result:** The Verifier will output a value for the bias, and an array of weights, using Scikit-Learn. You can compare these with the results obtained using LinReg.

## How to Tune Learning Rate and Epochs <a name="tune"></a>

Since I am using gradient descent to tune my parameters, the learning rate and the number of epochs to iterate for, are the two hyperparameters that the user needs to tune.

The learning rate determines the step size of the Gradient Descent algorithm. A number between 0 and 1. If the learning rate is too small, the algorithm will learn more slowly, hence you will need more epochs to reach the optimal result. If the learning rate is too high, the algorithm will diverge, outputting incorrect parameters (when this happens, usually the ouputted weights array will contain some values which are NaN). Ideally, you want the largest possible learning rate that does not cause the algorithm to diverge. I reccomend starting with 0.5 for the learning rate. If the outputted weights array contains NaN values, try again with a smaller learning weight (e.g. 0.4). Repeat until the algorithm stops diverging.

The number of epochs is the number of iterations for Gradient Descent you wish the algorithm to run for. Assuming your chosen learning rate is small enough, the more the epochs, the more accurate the outputted result will be. However, this comes at the cost of performance- the more the epochs, the longer it will take the program to execute. I reccomend starting with 1000 epochs. After LinReg finishes executing, run again using a greater number of epochs (e.g. 10000). If there is a signficant disparity between the results after the two runs, repeat this process with an even greater number of epochs, until the disparity is no longer significant.

## Tests <a name="tests"></a>

I have tabulated the ouputs of LinReg using each of the sample input files. The ouputs obtained from Scikit-Learn using the same inputs were added for comparison's sake.

| Input File | Learning Rate | Epochs | LinReg Bias | LinReg Weights                                                                                                                  | SciKit-Learn Bias    | SciKit-Learn Weights                                                                                                                     |
| ---------- | ------------- | ------ | ----------- | ------------------------------------------------------------------------------------------------------------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| input.txt  | 0.5           | 1000   | 4.880177    | 0.198294<br>0.7188662<br>0.8524282                                                                                              | 4.880165322068354    | 0.19829517<br>0.71886712<br>0.85242901                                                                                                   |
| input1.txt | 0.5           | 1000   | -0.24000283 | 0.92800057                                                                                                                      | -0.24000767368750608 | 0.92800153                                                                                                                               |
| input2.txt | 0.5           | 1000   | 1.9693025   | 0.9346864<br>0.89539075<br>0.67222714                                                                                           | 1.969294057080127    | 0.93468698<br>0.89539156<br>0.67222764                                                                                                   |
| input3.txt | 0.5           | 1000   | 0.16018465  | 1.1546878<br>0.9532798<br>0.9994971<br>0.95564324<br>0.9078755<br>1.1276116<br>1.0319495<br>0.9178561<br>0.8091981<br>1.0298774 | 0.16016152436949227  | 1.15468819<br>0.95328017<br>0.99949774 <br>0.95564382<br>0.9078763<br>1.12761249<br>1.03194998<br>0.91785616<br>0.80919865<br>1.02987786 |

I then tried using a real dataset on LinReg- the Boston house prices dataset (retrieved from Kaggle). After some tuning, I found that a good learning rate was around 0.4, and that Gradient Descent required around 10,000 epochs to reach a near optimal result.

Warning: this test will take signficant time to execute, given the size of the dataset, and the number of epochs chosen to reach the results.

| Input File | Learning Rate | Epochs | LinReg Bias | LinReg Weights                                                                                                                                                                              | SciKit-Learn Bias | SciKit-Learn Weights                                                                                                                                                                                         |
|------------|---------------|--------|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| boston.txt | 0.4           | 10000  | 36.146996   | -0.107844375<br>4.641067e-2<br>2.0260321e-2<br>2.6879923<br>-17.630888<br>3.8292494<br>5.622324e-4<br>-1.4714662<br>0.30482042<br>-1.2311089e-2<br>-0.94805914<br>9.349744e-3<br>-0.5237158 | 36.45948838509019 | -0.108011358<br>4.64204584e-2<br>2.05586264e-2<br>2.68673382<br>-17.7666112<br>3.80986521<br>6.92224640e-4<br>-1.47556685<br>0.306049479<br>-1.23345939e-2<br>-0.952747232<br>9.31168327e-3<br>-0.524758378 |

## About the Code <a name="code"></a>

The main function (in Main.hs) is the entry point to LinReg, and the only place where IO interaction occurs. The user chooses the text file holding the dataset, and selects their learning rate (lr) and the number of epochs (e) to run gradient descent for.

The text file is passed to parseInput (ParseInput.hs), its purpose is to parse the txt file into two matrices: 
- an m by n matrix for the features (where m is the number of samples, and n is the number of features)
- an m by 1 matrix for the target (where m is the number of samples)

Every matrix, alongside its shape, are held by the Matrix data type (defined in Matrices.hs).

The two matrices are wrapped by the Dataset type (defined in Datasets.hs). And this dataset, alongside the user's chosen lr and e, is wrapped by the Input type (defined in Input.hs). This is to improve the modularity of the program.

The matricies, are then passed to linReg (Regression.hs) to apply the Linear Regression algorithm using Gradient Descent. This makes use of various higher order functions in Matrices.hs (e.g. eleWiseOp), as well as recursion (gradDescent in Regression.hs), to calculate the weights and bias. The weights and bias are stored as a Coefficients datatype (Coefficients.hs), and printed to console.

## Encountered Challenge <a name="challenge"></a>

A challenge encountered was the peformance of LinReg on datasets where there exists a significant disparity in the scales of various columns. For example, the boston house prices dataset (in boston.txt), where the NOX column held values between 0 and 1, whereas the TAX column held values in the hundreds. In such cases, LinReg required an extremley small lr (around 1e-8), and an extremly large e (around 100,000) in order to reach near optimal results, translating to extremly long execution times (nearly half an hour!). 

I was able to drastically improve pefromance by employing feature scaling. This involved scaling each column by dividing the values therin, by the maximum value in that column. This ensured that all columns have values between 0 and 1. LinReg performs feature scaling on all inputs automatically, before passing the dataset to the linReg function (in Regression.hs). The outputted coefficents are then "unscaled" to remove the impact of feature scaling on the output. 

After feature scaling, a good result can be obtained for the boston house prices dataset, with an lr of 0.4, and just 10,000 epochs. And while this still takes some time to process (given the size of the dataset, and the fact I'm using gradient descent instead of the normal equation), it represents a noteworthy improvement over the performance of LinReg without feature scaling.

## Third Party Contributions <a name="references"></a>

- transpose function (Matrices.hs) was taken from: https://stackoverflow.com/questions/2578930/understanding-this-matrix-transposition-function-in-haskell
- boston dataset (boston.txt) was taken from: https://www.kaggle.com/vikrishnan/boston-house-prices
