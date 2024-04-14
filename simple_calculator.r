library(shiny)
library(shinydashboard)

ui <- fluidPage(
  titlePanel("Simple Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("num1","Enter the number 1:",value = 0),
      numericInput("num2","Enter the number 2:",value = 0),
      selectInput("operator","Select Operator:",
                  choices = c("Addition" = "+",
                              "Subtraction" = "-",
                              "Multiplication" = "*",
                              "Division" = "/")),
      actionButton("calcualte","Calculate")
    ),
    mainPanel(
      box(title = "Output: ", textOutput("result"),style = "color: blue; font size: 20px;")
    )
  ),
  tags$div(
    style = "text-align: center; margin-top: 20px;",
    "Copyright © 21MID0016-Richard L"
  )
)


server <- function(input, output){
  result <- reactive({
    num1 <- input$num1
    num2 <- input$num2
    operator <- input$operator
    
    switch(operator,
           "+" = num1 + num2,
           "-" = num1 - num2,
           "*" = num1 * num2,
           "/" = if (num2 != 0) num1/num2 else "Error: Division by zero")
  })
  
  output$result <- renderText({
    result_value <- result()
    if(is.numeric(result())){
      result_text <- paste("Result of", input$num1, input$operator, input$num2, "is:", result_value)
    } else{
      result()
    }
  })
}

shinyApp(ui = ui, server = server)