library(shiny)

# Define UI for esophageal cancer probability application
shinyUI(fluidPage(

        # Application title 
        titlePanel("Dataset from case-control study of (o)esophageal cancer in Ille-et-Vilaine, France"),
        
        h4("Please choose Age group on the left and it will take a few seconds for the results on the right to refresh !!!"),

        # Sidebar with controls to select an age group
        sidebarLayout(
                sidebarPanel(
                        selectInput(inputId="agegp", label="Choose Age group (years):", 
                                    c("25-34", "35-44", "45-54", "55-64", "65-74", "75+"))
                        ),
                
                # Show the computed average proportion of cancer cases and a heatmap
                # with the association of Alochol and Tobacco consumptions given the seleted age group
                #
                mainPanel(
                        h4("Here will return the computed average proportion of cancer cases correspnding to the age group selection"),
                        
                        verbatimTextOutput("prop"),
                        
                        h4("Here will return the heatmap of cases proportion in association with Alochol and Tobacco consumptions"),
                        
                        plotOutput("distPlot")
                        )
                )
        ))