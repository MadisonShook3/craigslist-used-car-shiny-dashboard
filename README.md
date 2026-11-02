# craigslist-used-car-shiny-dashboard
Interactive R Shiny dashboard exploring Craigslist used-car prices and trends.

## Project Overview

This project is an interactive data visualization dashboard built using R Shiny. It explores Craigslist used-car listings to help users understand how vehicle prices relate to model year, mileage, and manufacturer.
This is Project 2 of my Data Science Portfolio and builds on the cleaned dataset from Project 1.

## Dataset

The dataset comes from the Craigslist Cars and Trucks dataset available on Kaggle.
The original data was cleaned in Project 1 by handling missing values, removing invalid prices, standardizing categorical variables, and filtering unrealistic values.
The dashboard uses `dashboard_vehicles.csv`, containing 85,547 vehicle listings and 13 variables.

## Dashboard Features

### Tab 1: Price Explorer

- Displays median vehicle asking prices by model year.
- Allows users to filter by manufacturer.
- Includes an adjustable price-range slider.
- Provides an interactive graph with hover information.

### Tab 2: Mileage Analysis

- Displays a scatterplot comparing vehicle mileage and asking price.
- Allows users to filter by model-year range.
- Uses a random sample of up to 3,000 vehicles to improve performance.
- Includes interactive zooming and hover features.

## Tools and Packages

- R
- Shiny
- ggplot2
- Plotly
- dplyr
- data.table

## How to Run

1. Download or clone this repository.
2. Open the project in RStudio or Posit Cloud.
3. Install the required packages:

```r
install.packages(c("shiny", "ggplot2", "plotly", "dplyr", "data.table"))
```

4. Make sure `dashboard_vehicles.csv` and `app.R` are in the same folder.
5. Open `app.R` and click **Run App**.

## Project Files

- `app.R` — R Shiny dashboard application.
- `dashboard_vehicles.csv` — Cleaned dataset used for visualization.
- `README.md` — Project documentation.

## Limitations

The dataset represents a subset of Craigslist vehicle listings rather than the entire used-car market. Prices are seller-reported asking prices rather than actual sale prices. The mileage analysis uses a sample of up to 3,000 listings to keep the interactive visualization responsive.

## Conclusion

This dashboard demonstrates how interactive visualizations can be used to explore relationships in real-world data. Users can compare asking prices across manufacturers and model years and investigate how mileage relates to vehicle pricing.