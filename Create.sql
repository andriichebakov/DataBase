CREATE TABLE Positions (
    position VARCHAR(60) NOT NULL PRIMARY KEY
);


CREATE TABLE Players (
    player VARCHAR(60) NOT NULL PRIMARY KEY,
    position VARCHAR(60) NOT NULL REFERENCES Positions(position)
);


CREATE TABLE Seasons (
    season VARCHAR(9) NOT NULL PRIMARY KEY
);


CREATE TABLE Player_info (
     player VARCHAR(60) NOT NULL,
     season VARCHAR(9) NOT NULL,
     age Number(2) NOT NULL CHECK (age>0 AND age<120),
     market_value Number(9) CHECK (market_value>0),
     CONSTRAINT PK_Player_info PRIMARY KEY (player, season),
     CONSTRAINT FK1_Player_info FOREIGN KEY (player) REFERENCES Players(player),
     CONSTRAINT FK2_Player_info FOREIGN KEY (season) REFERENCES Seasons(season)
);


CREATE TABLE Leagues (
    league VARCHAR(60) NOT NULL PRIMARY KEY
);


CREATE TABLE Teams (
    team VARCHAR(60) NOT NULL PRIMARY KEY,
    league VARCHAR(60) NOT NULL REFERENCES Leagues(league)
);


CREATE TABLE Transfer (
     player VARCHAR(60) NOT NULL,
     team_from VARCHAR(60) NOT NULL,
     team_to VARCHAR(60) NOT NULL,
     season VARCHAR(9) NOT NULL,
     transfer_fee Number(9) CHECK (transfer_fee>0),
     CONSTRAINT PK_Transfer PRIMARY KEY (player, team_from, team_to, season),
     CONSTRAINT FK1_Transfer FOREIGN KEY (player, season) REFERENCES Player_info(player, season),
     CONSTRAINT FK2_Transfer FOREIGN KEY (team_from) REFERENCES Teams(team),
     CONSTRAINT FK3_Transfer FOREIGN KEY (team_to) REFERENCES Teams(team)
);