ui = # Define UI for slider demo application
  fluidPage(
    
    #  Application title
    titlePanel("A Prior Intuition"),
    
    # Sidebar with sliders that demonstrate various available
    # options
    sidebarLayout(
      sidebarPanel(
        # Simple integer interval
        sliderInput("N", "N",min=2, max=500, value=5),
        sliderInput("a", "a",min=0.1, max=10.0, value=1),
        sliderInput("b", "b",min=0.1, max=10.0, value=1)
      ),
      # Show a plot and table summarizing the values entered
      mainPanel(
        plotOutput("plot"),
        tableOutput("values")
      )
    )
  )