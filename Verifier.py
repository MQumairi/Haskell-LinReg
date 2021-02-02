import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import os

# If current directory is "coursework" folder ensure "path" variable is empty string.
# Else if current directory is root "in3043-portfolio-MQumairi" folder, ensure path variable is "./coursework"
path = ""

print("Insert the name of the text file")

# Insert name of text file below
name_of_input_txt = input()
filename_read = os.path.join(path, name_of_input_txt)

# Import data from text file
data = pd.read_csv(filename_read, sep=" ")
features = data.drop('y', axis=1)
target = data['y']

# Model and fit
linear_regression = LinearRegression()
# print((features))
linear_regression.fit(features, target)

# # Print results
print(f"Bias: {linear_regression.intercept_}")
print(f"Weights: {linear_regression.coef_}")
