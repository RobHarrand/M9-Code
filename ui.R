shinyUI(fluidPage(
  titlePanel("Titanic Prediction Applet"),
  
  sidebarLayout(
    sidebarPanel(
        radioButtons("Pclass", label = "Passenger Class", choices = list("1st Class" = 1, "2nd Class" = 2,
                                                                         "3rd Class" = 3), selected = 1),
        radioButtons("Sex", label = "Sex", choices = list("Male" = 1, "Female" = 0), selected = 1),
        numericInput("Age", label = "Age", value = 0, min = 0, max = 150),

      column(3,
             h4("Survival Calculation"),
             actionButton("action", label = "Calculate"))
            
      
    ),
    
    mainPanel(
      img(src="pic.png", height = 96, width = 300),
      textOutput("text1")
      )
  )
))


