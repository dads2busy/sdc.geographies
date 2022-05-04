# SIMPLE PLOTTING ACS DATA EXAMPLE

# LOAD LIBRARIES
library(shiny)
library(tidycensus)
library(sf)
library(ggplot2)


# ONLY DO THESE ONCE BY PUTTING ABOVE/OUTSIDE THE "ui" AND "server" FUNCTIONS
# ONLY MAKE CONNECTION AND CREATE DATA FILE ONCE, THEN LOAD FROM FILE FROM THEN ON

# If data file does not exist, create it. Otherwise, load the data file.
if(!file.exists("acs_va_arlington_3857.RDS")) {
    # SET YOUR CENSUS API KEY (stored in my .Renviron file in my home directory)
    census_api_key(Sys.getenv("CENSUS_API_KEY"))

    # GET ACS DATA WITH GEOGRAPHY
    acs_va_arlington <- get_acs(geography = "tract", variables = c("B01001_001", "B01001_002", "B01001_026"),
                                state = "VA", county = "Arlington County", geometry = TRUE)

    # CHOOSE A PROJECTION FOR YOUR GEOGRAPHY
    acs_va_arlington_3857 <- st_transform(acs_va_arlington, 3857)

    # SAVE TO AN RDS FILE
    saveRDS(acs_va_arlington_3857, "acs_va_arlington_3857.RDS")

    map_data <- readRDS("acs_va_arlington_3857.RDS")
} else {
    map_data <- readRDS("acs_va_arlington_3857.RDS")
}

# Set the dropdown select variables
vars <- c("Total Population" = "B01001_001",
          "Male Population" = "B01001_002",
          "Female Population" = "B01001_026")


# DEFINE UI FOR APPLICATION THAT DRAWS A MAP
ui <- fluidPage(

    # Application title
    titlePanel("Virginia Census Tract Populations"),
    # Dropdown select
    selectInput("variable", "Variable:", vars),
    # Place to plot the map
    plotOutput("map")
)

# DEFINE SERVER LOGIC TO DRAW THE MAP
server <- function(input, output) {
    output$map <- renderPlot({
        ggplot(map_data[map_data$variable == input$variable,]) +
            geom_sf(aes(fill = estimate))
    })
}

# RUN THE APPLICATION
shinyApp(ui = ui, server = server)
