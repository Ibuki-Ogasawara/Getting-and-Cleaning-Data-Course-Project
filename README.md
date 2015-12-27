# Getting-and-Cleaning-Data-Course-Project
Part1\\
The code uploads the datasets and merges on the "X" test and train files. 

Part2 and 3\
The vector "meanstdcol" is manually created by looking at the "features" data.
Xmeanstd_test_train only includes mean and standard deviation of each variable.

Part4
"cleaned" is the labeled dataset. The code merges the features file with "cleaned" and turns the first row into the heading. You can also do this without using "rbind" and directly using "colnames".

Part5
"averages" is the function that calculates the average of each variable, each activities, and each subjects return to 30 by 63 matrix with subjects' id numbers and 62 different variables in the columns. 


