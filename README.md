# diproperm

This fork of jiadongm/diproperm provides several fixes to the package. 

0.3.0 allows the results to be reproduced by setting a random seed.

0.3.1 introduces two bug fixes:
1. Fixed a bug in the permutation statistics calculation 
2. Fixed a bug in the SVM implementation

0.3.2 sets balance to FALSE by default because when TRUE, there is a bug such that the resampling of the labels in the permutation step returns a new value 0. Also updated the implementation of balance FALSE to have replace=TRUE in sample function.

**Known issues:**
- svm implementation may not be correct as the power is lower than expected in some settings.


Some simulation study results:
- md  (1000 replicates). size: 0.052, power: 0.110
- dwd (1000 replicates): size: 0.040; power: 0.097

```{bash}
ml fhR/4.4.0-foss-2023b

for (( i =1; i<=1000; i++)); do
    sbatch  --wrap="Rscript simstudy.R $i" --output=logs/sim_$i.out 
done
```