# load shiny package
library(shiny)

shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Old Faithful prediction"),
    
    sidebarPanel(
      numericInput('waiting', 'Enter waiting time before last erruption in minutes', 90, min = 20, max = 200, step = 5),
      numericInput('durration', 'Enter last erruption durration in seconds', 120, min = 30, max = 400, step = 5)
      
    ),
    mainPanel(
      h3('Results of Old Faithful erruption prediction'),
      h4('You entered a waiting time of:'),
      verbatimTextOutput("inputWaiting"),
      h4('You entered and erruption durration of:'),
      verbatimTextOutput("inputErruption"),
      h4('The next erruption will be in about (minutes)'),
      verbatimTextOutput("prediction")
    )
  )
)