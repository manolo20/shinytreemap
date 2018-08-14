# :maple_leaf: Canadian Consumer Price Index shiny treemap :maple_leaf: 

This application shows in a hover treemap the contribution to change of every item of the basket of good and services to the overall Canadian Consumer Price Index for every Canadian jurisdiction.

Unfortunately, I have not been able to properly define the coordinates in the *tmLocate* function. If you solve this issue, I would love to hear the [solution](https://stackoverflow.com/questions/51717531/hover-treemap-in-a-shinyapp-not-showing-the-right-values).

To run this application from RStudio, please follow the following instructions:

```
## Installing missing packages
pkgs <- c("shiny", "dplyr", "treemap", "gridBase")

pkgs_needed <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]

if(length(pkgs_needed)) install.packages(pkgs_needed)

## Run app from Github repo
shiny::runGitHub('manolo20/shinytreemap')
```
