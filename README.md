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

