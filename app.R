
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(data.table)

# Load cleaned dataset
vehicles <- fread("dashboard_vehicles.csv")

# User interface
ui <- fluidPage(
  titlePanel("Craigslist Used Car Dashboard"),
  
  tabsetPanel(
    tabPanel("Price Explorer",
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                   "manufacturer",
                   "Select Manufacturer:",
                   choices = c("All", sort(unique(na.omit(vehicles$manufacturer)))),
                   selected = "All"
                 ),
                 sliderInput(
                   "price",
                   "Price Range ($):",
                   min = 500,
                   max = 100000,
                   value = c(500, 100000)
                 )
               ),
               mainPanel(
                 h3("Vehicle Prices by Model Year"),
                 plotlyOutput("pricePlot")
               )
             )
    ),
    
    tabPanel("Mileage Analysis",
             sidebarLayout(
               sidebarPanel(
                 sliderInput(
                   "year",
                   "Model Year:",
                   min = floor(min(vehicles$year, na.rm = TRUE)),
                   max = ceiling(max(vehicles$year, na.rm = TRUE)),
                   value = range(vehicles$year, na.rm = TRUE)
                 )
               ),
               mainPanel(
                 h3("Mileage vs. Asking Price"),
                 plotlyOutput("mileagePlot")
               )
             )
    )
  )
)

# Server logic
server <- function(input, output, session) {
  
  filtered_prices <- reactive({
    data <- vehicles %>%
      filter(
        price >= input$price[1],
        price <= input$price[2],
        !is.na(year)
      )
    
    if (input$manufacturer != "All") {
      data <- data %>%
        filter(manufacturer == input$manufacturer)
    }
    
    data
  })
  
  output$pricePlot <- renderPlotly({
    summary_data <- filtered_prices() %>%
      group_by(year) %>%
      summarise(
        median_price = median(price, na.rm = TRUE),
        listings = n(),
        .groups = "drop"
      )
    
    p <- ggplot(summary_data,
                aes(x = year, y = median_price,
                    text = paste("Listings:", listings))) +
      geom_line(color = "steelblue", linewidth = 1) +
      geom_point(color = "darkblue") +
      labs(
        x = "Model Year",
        y = "Median Asking Price ($)",
        title = "Median Vehicle Price by Model Year"
      ) +
      theme_minimal()
    
    ggplotly(p, tooltip = c("x", "y", "text"))
  })
  
  output$mileagePlot <- renderPlotly({
    data <- vehicles %>%
      filter(
        year >= input$year[1],
        year <= input$year[2],
        !is.na(odometer),
        !is.na(price)
      )
    
    # Randomly sample up to 3,000 vehicles
    if (nrow(data) > 3000) {
      data <- data %>% slice_sample(n = 3000)
    }
    
    p <- ggplot(data, aes(x = odometer, y = price)) +
      geom_point(alpha = 0.35, color = "darkgreen") +
      labs(
        x = "Mileage",
        y = "Asking Price ($)",
        title = "Mileage vs. Vehicle Price"
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
}

# Launch application
shinyApp(ui = ui, server = server)
