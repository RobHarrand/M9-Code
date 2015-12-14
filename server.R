library(caret) #Classification and regression training

train = read.csv("train.csv", header = TRUE) #Read in the data

#Alter variables accordingly,
train$Survived[train$Survived == '0'] = 'Perished'
train$Survived[train$Survived == '1'] = 'Survived'

train$Sex = as.character(train$Sex)
train$Sex[train$Sex == 'male'] = 1
train$Sex[train$Sex == 'female'] = 0
train$Sex = as.factor(train$Sex)

train$Survived = factor(train$Survived)
train$Pclass = factor(train$Pclass)


set.seed(1) #Set seed for reporoducibility

#Set the trainControl parameters,
fitControl = trainControl(method = "repeatedcv", number = 10, repeats = 20, summaryFunction = twoClassSummary, 
                          classProbs = TRUE)

#Create the model,
model = train(Survived ~ Pclass + Sex + Age, 
              method = "glm", 
              data = train,
              #tuneGrid = grid,
              preProcess =  "knnImpute",
              trControl = fitControl,
              metric = "ROC")

#Create the links to the interface,
shinyServer(
    function(input, output) {
        
        risk = reactiveValues()
        
        observeEvent(input$action, {
            
            mydatanew = data.frame("Passenger Class", "Sex", "Age")
            colnames(mydatanew) = c("Passenger Class", "Sex", "Age")
            mydatanew$Pclass = input$Pclass
            mydatanew$Sex = input$Sex
            mydatanew$Age = input$Age
            predicted = predict(model, newdata = mydatanew, type="prob")  
            output$text1 <- renderText({ 
                
                {paste("The chance of survival is:  ", (round(predicted[,2],2))*100, "%")} 
                
            })
        })
    }
)
