library(shiny)
library(ggplot2)
#load("data.RData")


shinyServer(function(input, output) {
  
   
  output$plot1 <- renderPlot(function(){ 
    
    print("in renderPlot")
    print(paste0("Selected City is:  ", input$selectcity))
    print(paste0("Selected Comparison1 is:  ", input$comparison1))
    print(paste0("Selected Comparison2 is:  ", input$comparison2))
    c1<<-input$comparison1
    c2<<-input$comparison2
    print(c1)
    print(c2)
    
    print(paste0("Selected Food is:  ", input$selectfood))
    print(paste0("Selected Comparison1 is:  ", input$comparison_a))
    print(paste0("Selected Comparison2 is:  ", input$comparison_b))
    c3<<-input$comparison_a
    c4<<-input$comparison_b
    print(c3)
    print(c4)
    
    myDataCity <<- subset(food, city==input$selectcity)
    myDataFood <<- subset(food, term==input$selectfood )
    print("myDataCity:")
    print(myDataCity)
    print("myDataFood:")
    print(myDataFood)
    
   
    
    if (input$city){
    #y<-function(ym, xm){lm(ym~mx, myDataCity)}
    #y<-with(myDataCity,lm(c1~c2))
     
      #y <- regress(ym, xm, myDataCity)
      y <- regress(myDataCity[[c1]], myDataCity[[c2]], myDataCity)
      
    a=y$coefficients[1]
    b=y$coefficients[2]
    print(paste0("a=",a))
    print(paste0("b=",b))
    
  
    ggplot(myDataCity,aes(y=myDataCity[[c1]],x=myDataCity[[c2]]))+xlab(c2)+ylab(c1)+geom_point(aes(color=term))+geom_abline(intercept=a, slope=b)
    
    }
    else{
      if(input$food){
        
        z <- regress(myDataFood[[c3]], myDataFood[[c4]], myDataFood)
        
        m=z$coefficients[1]
        n=z$coefficients[2]
        print(paste0("m=",m))
        print(paste0("n=",n))
        print(myDataFood[[c3]])
        
        
        ggplot(myDataFood,aes(y=myDataFood[[c3]],x=myDataFood[[c4]]))+xlab(c4)+ylab(c3)+geom_point(aes(color=city))+geom_abline(intercept=m, slope=n)
        
    
   
      }
    }
    
    
    
  }) #renderplot
  
}) # shiny server


