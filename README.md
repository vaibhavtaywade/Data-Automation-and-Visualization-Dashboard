# Data-Automation-and-Visualization-Dashboard

# India-Australia Trade Dashboard

## Tools and Libraries Used
- **R**: Programming language for data analysis and visualizations.
- **Shiny**: Framework for building interactive web applications.
- **rvest**: Web scraping (optional for real-time data fetching).
- **httr**: HTTP requests (not directly used in the code).
- **dplyr**: Data manipulation for filtering, grouping, and summarizing.
- **ggplot2**: Plotting library for static visualizations.
- **plotly**: Converts ggplot2 plots to interactive visualizations.
- **lubridate**: Date-time manipulation.
- **tidyr**: Data tidying and reshaping.

## How to Run the Automation Script

### 1. Install R and RStudio
- Download and install R from [CRAN](https://cran.r-project.org/).
- Install RStudio from [RStudio](https://posit.co/download/rstudio-desktop/).

### 2. Install Required Libraries
Run the following script in RStudio to install the necessary packages:
```r
required_packages <- c("rvest", "httr", "dplyr", "ggplot2", "shiny", "lubridate", "plotly", "tidyr")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) install.packages(new_packages)
```

### Run the Script
- Copy the provided code into an R script file (india_australia_trade_dashboard.R).
- Run the script in RStudio by clicking the "Run" button or using source("india_australia_trade_dashboard.R") in the console.

## Using the Shiny App
Once the script is executed, the app will automatically open in your browser with the title "India-Australia Trade Dashboard". The features available in the app are:

- Select date ranges for analysis.
- Choose specific product categories for visualization.
- View visualizations such as:
  - Monthly Trends in trade volumes (exports/imports).
  - Breakdown by product categories.
  - Year-over-Year changes in trade volumes.
- Update the trade data with the **Update Data** button.
- Export the data shown in the dashboard using the **Download Data** button.


