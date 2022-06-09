#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
TRUNCATE=$($PSQL "TRUNCATE teams,games;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
if [[ $YEAR != "year" ]]
then
INSERT_TEAM1=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
INSERT_TEAM2=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
#GET TEAM ID
TEAM_IDW=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
TEAM_IDO=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$TEAM_IDW','$TEAM_IDO','$WINNER_GOALS','$OPPONENT_GOALS');")
fi
done
