## "Practice / Generate Synthetic Data"


data_file <- read.csv("C:/Users/sanya/Documents/prachi/OneDrive/R programming - Data analytics/game-schedule.csv")

## In a separate R program, load the CSV and validate the schedule: is the correct number of games given the number of teams? 
## are ties resolved? if the overtime flag is TRUE, is the goal differential exactly 1?
## Validating the data 

overtime_games <- which(data_file$ot == TRUE)
goal_difference <- abs(data_file$home.team.goals[overtime_games] - data_file$away.team.goals[overtime_games])

isValid <- !any(goal_difference != 1)
print(isValid)




