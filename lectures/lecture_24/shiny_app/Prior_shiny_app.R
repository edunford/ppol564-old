library(shiny)

bayes_plot = function(successes,trials,a,b){
  # Posterior
  post_dens =curve(dbeta(x,successes+a,trials-successes+b)*(1/trials),
                   add=F,col="steelblue",lwd=5,
                   ylab="Density",xlab="Probability",
                   main="Prior(Beta)*L(Binomial) = Beta Posterior")
  
  # Likelihood
  curve(dbinom(successes,trials,x),add=T,ylim=c(0,max(post_dens$y)),
        col="grey",lwd=5,lty=5,ylab="Density",xlab="Probability",
        main="Prior(Beta)*L(Binomial) = Beta Posterior")
  
  # Prior
  curve((dbeta(x,a,b)*(1/trials)),add=T,col="orange",lwd=5)
  
  # Legend
  legend("topright",c("Likelihood","Prior","Posterior"),
         lty=c(5,1,1),col=c("grey","orange","steelblue"),
         lwd=3,cex=.8)
}

bayes_values = function(truth,successes,trials,a,b){
  L = round(successes/trials,2)
  prior = round(quantile(rbeta(10e3,a,b),probs=c(.025,.5,.975)),2)
  posterior = round(quantile(rbeta(10e3,successes+a,trials-successes+b),probs=c(.025,.5,.975)),2)
  X = data.frame("Value"=c("Truth","Likelihood","Prior","Posterior"),
                 "median"=c(truth,L,prior[2],posterior[2]),
                 "Lower"=c("-","-",prior[1],posterior[1]),
                 "Upper"=c("-","-",prior[3],posterior[3]))
  return(X)
}



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

shinyApp(ui,server)
