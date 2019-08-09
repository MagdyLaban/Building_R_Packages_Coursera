
<!-- README.md is generated from README.Rmd. Please edit that file -->

# farspackage

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/MagdyLaban/Building_R_Packages_Coursera.svg?branch=master)](https://travis-ci.com/MagdyLaban/Building_R_Packages_Coursera)
<!-- badges: end -->

``` r
library(farspackage)
```

This package contains functions that read US National Highway Traffic
Safety Administration’s **Fatality Analysis Reporting System (FARS)**
data and summarize them

  - ## Reading in
    
    For reading the complete file use: **fars\_read(filename)**. It
    reads a CSV file and creates a tibble from it. Specify the filename
    using the **filename** argument . argument.

  - ## Making file name
    
    To make a file you have to use **make\_file(year)** and specify an
    integer value for **year** argument .

  - ## Filtering
    
    The **fars\_read\_years(years)** function takes a numeric value as
    **years** argument and returns a list of tibbles consisting of two
    columns: **MONTH** and **year**.

  - ## Summarizing
    
    The **fars\_summarize\_years(years)** function summarizes accidents
    for the specified **years**, grouped by **months**.

  - ## Plotting
    
    To plot the data for the specified state in the specified year you
    have to use the **fars\_map\_state(state.num, year)** function .
    **state.num** represents the state number and it takes a numeric
    value and **year** represents which year the accidents had token
    place and it is a numeric value .
