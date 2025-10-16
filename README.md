# diproperm

This fork of jiadongm/diproperm provides several fixes to the package. 

0.3.0 allows the results to be reproduced by setting a random seed.

0.3.1 introduces two bug fixes:
1. Fixed a bug in the permutation statistics calculation 
2. Fixed a bug in the SVM implementation


**Known issues:**
- svm implementation may not be correct as a small simulation study shows that its power is rather bad.
- When balance is set to TRUE, the resampling of the labels in the permutation step returns a new value 0.
