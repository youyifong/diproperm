args <- commandArgs(trailingOnly = TRUE)
print(args)

i=as.integer(args[1])
set.seed(i)

dir.create("output", showWarnings = FALSE, recursive=TRUE)

library(glue)
library(MASS)
library(diproperm)

n=20
p=5
mu <- mu1 <- rep(0,p) 
mu1[1]=mu1[1]+0.5    # 0 for size, 0.5 for power
Sigma <- diag(rep(1,p))
y=c(rep(1,n/2), rep(-1,n/2))

X <- rbind(
  mvrnorm(n = n/2, mu = mu,  Sigma = Sigma),
  mvrnorm(n = n/2, mu = mu1, Sigma = Sigma)
)

classifier="dwd"
# classifier="md"

out=DiProPerm (X=X, y=y, B=1000, classifier=classifier, univ.stat="md", cores=1)

pvalue = out$pvalue
save(pvalue, file=glue("output/seed_{i}.Rdata"))


if(F) 
{
# load .Rdata files from the output folder and combine into a single vector
load_simulation_results <- function(output_folder="output") {
  # List all .Rdata files in the output folder
  rdata_files <- list.files(output_folder, pattern = "\\.Rdata$", full.names = TRUE)

  # Loop through each file and load the data
  sapply (rdata_files, function(file) {
    load(file)  # This will load the data into the environment
    # Assuming each .Rdata file contains a variable named 'result'
    pvalue
  })
}

res=load_simulation_results()
res[res=="<0.001"]="0.001"
res=as.numeric(res)
mean(res < 0.05)
}
