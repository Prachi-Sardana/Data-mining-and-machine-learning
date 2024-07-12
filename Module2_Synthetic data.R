## "Practice / Generate Synthetic Data"


# Loading the data into dataframe
teams_df <- read.csv(url("http://artificium.us/assignments/06.r/a-6-108/teams.csv"))

# Created a smaller version of 4 teams
head(teams_df,4)

# Number of teams 
num_teams <- nrow(teams_df)

# number of teams = 16 ( 2*16*15 = 480) since each team place with the other twice one home team and another away team
games <- 2*(num_teams)*(num_teams - 1)

# created an empty data frame game_schedule with the coloumns
schedule_game <- data.frame(home.team = integer(games),
                            away.team = integer(games),
                            home.team.goals = integer(games),
                            away.team.goals = integer(games),
                            ot = integer(games)
                            )



# Initialized game_counter to 1
game.counter <- 1


## iterated over the home teams and away teams considering team1 as home team
for (team1 in 1:(num_teams)) {
  ## considering team2 as away team
  for (team2 in 1:num_teams) {
    if (team1 != team2) {
      schedule_game$home.team[game.counter] <- team1
      schedule_game$away.team[game.counter] <- team2
      game.counter <- game.counter + 1
    }
  }
}


# swapping the home team and the away team 

home_score <- schedule_game$home.team[1:(game.counter - 1)]
away_score <- schedule_game$away.team[1:(game.counter -1)]


schedule_game$home.team[game.counter:games] <- away_score
schedule_game$away.team[game.counter:games]<- home_score


# generating scores using run if function which generates a random uniformly distributed number from a range

schedule_game$home.team.goals <- as.integer(round(runif(games, min = 0, max = 9 ),0))

schedule_game$away.team.goals <- as.integer(round(runif(games,min =0,max =9),0))


# For a tie setting the ot flag 

schedule_game$ot <- (schedule_game$home.team.goals == schedule_game$away.team.goals)

# for overtime win awarding an extra goal to one of the teams

# if the winner achieves less than 70% away team2 away team wins a chance over team1 home team

overtime <- which(schedule_game$ot == TRUE)

for (overtime_win in overtime){
  winner <- runif(1)
  if (winner < 0.7){
    schedule_game$home.team.goals[overtime_win]<- schedule_game$away.team.goals[overtime_win]+ 1
  }else{
    schedule_game$away.team.goals[overtime_win]<- schedule_game$away.team.goals[overtime_win]+ 1
  }
}



## Used schedule_game$home.team and schedule_game$away.team columns 
## to index the teams_df$team.name column to map the team numbers to team names

schedule_game$home.team <- teams_df$team.name[schedule_game$home.team]
schedule_game$away.team <- teams_df$team.name[schedule_game$away.team]


# Writing the game_schedule csv file
write_file <- write.csv(schedule_game, "game-schedule.csv")



  





