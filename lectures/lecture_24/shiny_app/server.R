# Create Shiny Application
server = function(input, output) {
  
  # Show the values using an HTML plot
  output$plot <- renderPlot({
    set.seed(123)
    sample = rbinom(input$N,1,.4)
    successes = sum(sample)
    bayes_plot(successes,input$N,input$a,input$b)
  })
  # Show the values using an HTML table
  output$values <- renderTable({
    set.seed(123)
    sample = rbinom(input$N,1,.4)
    bayes_values(.4,sum(sample),input$N,input$a,input$b)
  })
}
