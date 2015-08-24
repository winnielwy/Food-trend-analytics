library(shiny)

shinyUI(fluidPage(
  titlePanel('Comparison'),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Compare varibles"),
      
      checkboxInput('city','compare variables for each city'),
      
      selectInput("selectcity",label = "city",
                  choices=list("New York", "Atlanta","Portland","Washington DC",
                               "Charlotte", "Houston","Los Angeles", "Chicago",
                               "Denver","Kansas City"), selected="New York"),
      br(),
      
      selectInput("comparison1",label ="comparison1",
                  choices=list("percentage_tweet","percentage_count","sentiment","avgprice"),selected="avgprice"),
      
      br(),
      selectInput("comparison2",label ="comparison2",
                  choices=list("percentage_tweet","percentage_count","sentiment","avgprice"),selected="sentiment"),
      
      br(),
      checkboxInput('food','compare variables for each food'),
      
      selectInput("selectfood",label ="food",
                  choices=list("kale","bacon","tofu","chicken and waffles",
                               "taco","food truck","dumplings","quinoa",
                               "green-free","sriracha"),selected="kale"),
      br(),
      
      selectInput("comparison_a",label ="comparison1",
                  choices=list("percentage_tweet","percentage_count","sentiment","HipInc","avgprice","MedInc"),selected="avgprice"),
      
      br(),
      selectInput("comparison_b",label ="comparison2",
                  choices=list("percentage_tweet","percentage_count","sentiment","HipInc","avgprice","MedInc"),selected="MedInc"),
      
      br(),
      br(),
      p("Definition: ",style = "color:blue"),
      h6("sentiment: sentiment score for a spacific food"),
      h6("avgprice: average price for a spacific food"),
      h6("HipInc: the total income for 25-34 group people "),
      h6("MedInc: the median income for a spacific city"),
      h6("percentage_count: the percentage of restaurants for a spacific food in a city"),
      h6("percentage_tweet: the percentage of tweets for a spacific food in a city")
     
      
      
    ),
    
    mainPanel('Output area',
              plotOutput("plot1"))
    
  ))
  
)
