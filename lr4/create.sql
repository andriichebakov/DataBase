CREATE TABLE match (
    home            VARCHAR2(60) NOT NULL,
    visitors        VARCHAR2(60) NOT NULL,
    datetime        DATE NOT NULL,
    home_score      NUMBER(2),
    visitors_score  NUMBER(2)
);

ALTER TABLE match
    ADD CONSTRAINT match_pk PRIMARY KEY ( datetime,
                                          home,
                                          visitors );

CREATE TABLE player (
    player    VARCHAR2(60) NOT NULL,
    position  VARCHAR2(60) NOT NULL
);

ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY ( player );

CREATE TABLE position (
    position VARCHAR2(60) NOT NULL
);

ALTER TABLE position ADD CONSTRAINT position_pk PRIMARY KEY ( position );

CREATE TABLE season (
    season VARCHAR2(9) NOT NULL
);

ALTER TABLE season ADD CONSTRAINT season_pk PRIMARY KEY ( season );

CREATE TABLE team (
    team VARCHAR2(60) NOT NULL
);

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( team );

CREATE TABLE transfer (
    player     VARCHAR2(60) NOT NULL,
    season     VARCHAR2(9) NOT NULL,
    team_from  VARCHAR2(60) NOT NULL,
    team_to    VARCHAR2(60) NOT NULL,
    age        NUMBER(3)
);

ALTER TABLE transfer
    ADD CONSTRAINT transfer_pk PRIMARY KEY ( season,
                                             player,
                                             team_from,
                                             team_to );

ALTER TABLE match
    ADD CONSTRAINT match_team_fk FOREIGN KEY ( home )
        REFERENCES team ( team );

ALTER TABLE match
    ADD CONSTRAINT match_team_fkv2 FOREIGN KEY ( visitors )
        REFERENCES team ( team );

ALTER TABLE player
    ADD CONSTRAINT player_position_fk FOREIGN KEY ( position )
        REFERENCES position ( position );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_player_fk FOREIGN KEY ( player )
        REFERENCES player ( player );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_season_fk FOREIGN KEY ( season )
        REFERENCES season ( season );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_team_fk FOREIGN KEY ( team_from )
        REFERENCES team ( team );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_team_fkv2 FOREIGN KEY ( team_to )
        REFERENCES team ( team );