library(shiny) 
library(datasets)
library(ggplot2)
library(magrittr)

# Load in the "esoph" dataset
esophData <- esoph

# Define server logic required to compute the average proportion of cancer cases and associated heatmap
shinyServer(function(input, output) {
        
        # By declaring datasetInput as a reactive expression we ensure that:
        # 1) It is only called when the inputs it depends on changes 
        # 2) The computation and result are shared by all the callers 
        # (it only executes a single time)
        #
        ageInput <- reactive({
                switch(input$agegp,
                       "25-34"="25-34", "35-44"="35-44", "45-54"="45-54", 
                       "55-64"="55-64", "65-74"="65-74", "75+"="75+")
                })
        
        # The output$prop depends on the ageInput reactive expression, so will be 
        # re-executed whenever ageInput is invalidated (i.e. whenever the input$agegp changes)
        output$prop <- renderPrint({
                esoph_subset <- esophData[esophData$agegp == input$agegp,]
                sum(esoph_subset$ncases)/(sum(esoph_subset$ncases)+sum(esoph_subset$ncontrols))
        })

        # Expression that generates a heatmap. The expression is wrapped in a call to renderPlot to indicate that:
        #
        # 1) It is "reactive" and therefore should be automatically re-executed when inputs change
        # 2) Its output type is a plot
        #
        output$distPlot <- renderPlot({
                esoph_subset <- esophData[esophData$agegp == input$agegp,]
                esoph_subset$cancer.prop <- esoph_subset$ncases/(esoph_subset$ncases + esoph_subset$ncontrols)
                myPlot <- qplot(x=alcgp, y=tobgp, fill=cancer.prop, geom='tile', data=esoph_subset)
                myPlot + labs(x='Alcohol consumption', y='Tobacco Consumption', title='Cancer proportion by Alcohol and Tobacco consumptions')
        })
})