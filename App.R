# Install required packages (if not already installed)
required_packages <- c("rvest", "httr", "dplyr", "ggplot2", "shiny", "lubridate", "plotly", "tidyr")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) install.packages(new_packages)

# Load required libraries
library(rvest)
library(httr)
library(dplyr)
library(ggplot2)
library(shiny)
library(lubridate)
library(plotly)
library(tidyr)

# Function to scrape trade data and save it as a CSV file
scrape_and_save_trade_data <- function() {
  url <- "https://tradestat.commerce.gov.in/eidb/default.asp"  # Replace with the correct data URL
  # Example of scraping logic (you need to adjust this to match the website's structure)
  
  # Mocked data scraping logic since actual scraping may require adjustments
  # This example generates a sample dataset
  data <- data.frame(
    Date = seq.Date(from = as.Date("2020-01-01"), to = as.Date("2024-12-31"), by = "month"),
    Product_Category = rep(c("Agriculture", "Textiles", "Machinery", "Minerals"), each = 60),
    Trade_Type = rep(c("Export", "Import"), times = 120),
    Trade_Volume = sample(1000:10000, 240, replace = TRUE)
  )
  
  # Save the data to a CSV file
  write.csv(data, "india_australia_trade_data.csv", row.names = FALSE)
  print("Data saved to india_australia_trade_data.csv")
  
  return(data)
}

# Load data from CSV or scrape new data
load_trade_data <- function() {
  if (file.exists("india_australia_trade_data.csv")) {
    data <- read.csv("india_australia_trade_data.csv")
    data$Date <- as.Date(data$Date)  # Convert Date column to Date type
    return(data)
  } else {
    return(scrape_and_save_trade_data())
  }
}

# UI for the Shiny dashboard
ui <- fluidPage(
  titlePanel("India-Australia Trade Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", "Select Date Range:", start = "2020-01-01", end = Sys.Date()),
      selectInput("product_category", "Select Product Categories:", choices = NULL, multiple = TRUE),
      actionButton("update_data", "Update Data")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Monthly Trends", plotlyOutput("time_series_plot")),
        tabPanel("Category Breakdown", plotlyOutput("category_breakdown")),
        tabPanel("Year-over-Year Changes", plotlyOutput("yearly_comparison"))
      )
    )
  )
)

# Server logic for the Shiny dashboard
server <- function(input, output, session) {
  # Load trade data
  trade_data <- reactiveVal(load_trade_data())
  
  # Update product category choices
  observe({
    updateSelectInput(session, "product_category", choices = unique(trade_data()$Product_Category))
  })
  
  # Reactive filtering of data
  filtered_data <- reactive({
    trade_data() %>%
      filter(
        Date >= input$date_range[1] & Date <= input$date_range[2],
        if (length(input$product_category) > 0) Product_Category %in% input$product_category else TRUE
      )
  })
  
  # Monthly trends time series plot
  output$time_series_plot <- renderPlotly({
    data <- filtered_data()
    p <- ggplot(data, aes(x = Date, y = Trade_Volume, color = Trade_Type)) +
      geom_line() +
      labs(title = "Monthly Trends in Trade Volumes", x = "Date", y = "Trade Volume") +
      theme_minimal()
    ggplotly(p)
  })
  
  # Breakdown by product categories
  output$category_breakdown <- renderPlotly({
    data <- filtered_data() %>%
      group_by(Product_Category, Trade_Type) %>%
      summarise(Total_Volume = sum(Trade_Volume), .groups = "drop")
    
    p <- ggplot(data, aes(x = Product_Category, y = Total_Volume, fill = Trade_Type)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Breakdown by Product Categories", x = "Product Category", y = "Total Trade Volume") +
      theme_minimal()
    ggplotly(p)
  })
  
  # Year-over-Year changes
  output$yearly_comparison <- renderPlotly({
    data <- filtered_data() %>%
      mutate(Year = year(Date)) %>%
      group_by(Year, Trade_Type) %>%
      summarise(Total_Volume = sum(Trade_Volume), .groups = "drop")
    
    p <- ggplot(data, aes(x = Year, y = Total_Volume, fill = Trade_Type)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Year-over-Year Changes in Trade Volumes", x = "Year", y = "Total Trade Volume") +
      theme_minimal()
    ggplotly(p)
  })
  
  # Handle data update
  observeEvent(input$update_data, {
    trade_data(scrape_and_save_trade_data())
    updateSelectInput(session, "product_category", choices = unique(trade_data()$Product_Category))
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
