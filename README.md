---
title: "R workshops"
author: "Tim Knutsen"
date: "12.1.2016"
output: html_document
---

Repository for the CIGENE R workshops. 

We used to have a R-lovers club, so this is a great opportunity to revive it. 

## Preparation
To prepare for this, I suggest that you find yourself some data, and try to solve some problems.
eg:

* read the data into R. 
* select columns to new data frame.
* filter the new df based on a column. 
* Make a new column by adding two other columns together. 
* summarize the data by eg. grouping by a column  and showing the mean for each group.
* Plot your results using ggplot2. http://www.cookbook-r.com/Graphs/index.html 

## Data:
1. Jings rna-seq data is actually a very messy data set, and a good starting point. 
2. Use the built in datasets i R:


```r
if(!require(ggplot2)) install.packages("ggplot2")
cars <- mtcars
flowers <- iris
diamonds <- ggplot2::diamonds

ggplot2::ggplot(cars, aes(hp, mpg)) + 
	geom_point(aes(colour = as.factor(cyl)))
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) 

## Learning:
There a many, many books and resources. It is easy to get lost. Find a good source, and stick to it. Also, google will solve almost everything. 
For the basics, I really like http://www.statmethods.net/ . This has examples for doing 90 % of the most basic stuff you need to do.

### Hadley
For this workshop, we can go through how to do a rna-seq basic analysis using Hadley Wickams package dplyr which I find immensely useful. https://github.com/hadley/dplyr 
He has created small intro tutorial using a built in dataset. 
https://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html  

### Videos
If you like videos, I think this course is easy to understand and explained well. http://varianceexplained.org/RData/ 

If you REALLY like videos, go for one of these full blown online courses: https://www.coursera.org/learn/r-programming 
https://www.coursera.org/learn/data-cleaning and see related courses. 



