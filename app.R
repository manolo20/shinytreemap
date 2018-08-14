
library(shiny)
library(treemap)
library(dplyr)
library(gridBase)


weights <- readRDS("manolo20/shinytreemap/treemap1.rds")

### Handle cliks on a treemap
tmLocate <-
  function(coor, tmSave) {
    tm <- tmSave$tm
    
    # retrieve selected rectangle
    rectInd <- which(tm$x0 < coor[1] & (tm$x0 + tm$w) > coor[1] &
                       tm$y0 < coor[2] & (tm$y0 + tm$h) > coor[2])
    
    return(tm[rectInd[1], ])
    
  }

ui = fluidPage(pageWithSidebar(
  headerPanel("Interactive treemap"),
  sidebarPanel(
    selectInput("prov", "Select province:",choices = unique(weights$Region)), width = 2
  ),
  mainPanel(
    plotOutput("plot", hover="hover", height = 700, width = 900), 
    tableOutput("record")
  )
)
)

server = function(input, output){
  sel1 <- reactive({
    weights %>% filter(Region %in% input$prov)
  })
  
  getRecord <- reactive({
    x <- input$hover$x
    y <- input$hover$y
    
    x <- (x - .tm$vpCoorX[1]) / (.tm$vpCoorX[2] - .tm$vpCoorX[1])
    y <- (y - .tm$vpCoorY[1]) / (.tm$vpCoorY[2] - .tm$vpCoorY[1])
    
    
    l <- tmLocate(list(x=x, y=y), .tm)
    l[, 1:(ncol(l)-9)]            
  })
  
  output$plot <- renderPlot({ 
    #cat(input$hover$x, "\n")
    par(mar=c(0,0,0,0), xaxs='i', yaxs='i') 
    plot(c(0,1), c(0,1),axes=F, col="white")
    vps <- baseViewports()
    
    .tm <<- treemap(sel1(), 
                    index=c("Level.0","Level.1"),
                    vSize="X2015", vp=vps$plot)
    
  })
  output$record <- renderTable({
    getRecord()
  })
}

shinyApp(ui=ui, server=server)





