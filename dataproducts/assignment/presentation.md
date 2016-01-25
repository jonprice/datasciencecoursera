Predicting Old Faithful
========================================================
author: Jon
date: 24-Jan-2016

Using a Linear Models with inputs of the last eruption and waiting time to predict how long until the next eruption. 

https://jonprice.shinyapps.io/assignment/

Data set
========================================================

The geyser data set from the MASS package was used to create the model

- duration	numeric	Eruption time in minutes
- waiting	numeric	Waiting time for this eruption in minutes


```
'data.frame':	299 obs. of  2 variables:
 $ waiting : num  80 71 57 80 75 77 60 86 77 56 ...
 $ duration: num  4.02 2.15 4 4 4 ...
```


Model Creation
========================================================

To be able to make predictions about a future erruption I created two new data fields for each record. 

- waitingP1 = waiting at time -1
- durationP1 = durration at time -1


```
    waiting duration waitingP1 durationP1
297      58        4        85   2.066667
298      88        4        58   4.000000
299      79        2        88   4.000000
```


Model Performance
========================================================

![plot of chunk unnamed-chunk-3](presentation-figure/unnamed-chunk-3-1.png) 


Ideas to Improvments the Performance
========================================================


- Use more than the previous eruption waiting and duration time
- Find a more up to date set of data for predictions
- Try other machine learning technics like Nearest Neighbor or Neural Net



