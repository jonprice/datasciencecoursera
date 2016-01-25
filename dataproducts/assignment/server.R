library(shiny)

init <- function(){
  library(MASS)
  data(geyser)
  
  
  for(i in 2:length(geyser$waiting)){
    geyser[i,"waitingP1"] = geyser[i-1,]$waiting
    geyser[i,"durationP1"] = geyser[i-1,]$duration
  }
  
  model <<- lm(waiting ~  . - duration, data = geyser)
}

init()


makePrediction <- function(waiting, durration){
  
  
  waitingP1 = waiting
  durationP1 = durration/60
  duration = 0
  newDataFrame = data.frame(waitingP1, durationP1, duration)
  
  predict(model, newdata =newDataFrame,interval = "prediction")
}


shinyServer(
  function(input, output) {
    output$inputWaiting <- renderPrint({input$waiting})
    output$inputErruption <- renderPrint({input$durration})
    output$prediction <- renderPrint({round(makePrediction(input$waiting,input$durration)[1],0 )})
  }
)
