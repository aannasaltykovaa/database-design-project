drop database if exists fictional_soccer_db_new;

create database fictional_soccer_db_new;

use fictional_soccer_db_new;


-- teams table
create table teams (
    team_id int primary key auto_increment,
    team_name varchar(100) not null unique,
    city varchar(100),
    country varchar(100)
);


-- players table
create table players (
    player_id int primary key auto_increment,
    team_id int,
    first_name varchar(50),
    last_name varchar(50),
    position enum('Goalkeeper', 'Defender', 'Midfielder', 'Forward'),
    foreign key (team_id) references teams(team_id)
);


-- matches table
create table matches (
    match_id int primary key auto_increment,
    match_date date,
    competition varchar(100),
    season varchar(20),
    home_team_id int,
    away_team_id int,
    home_score int,
    away_score int,
    venue varchar(100),
    foreign key (home_team_id) references teams(team_id),
    foreign key (away_team_id) references teams(team_id)
);


-- match events table
create table match_events (
    event_id int primary key auto_increment,
    match_id int,
    team_id int,
    player_id int,
    event_type enum('Pass', 'Shot', 'Turnover', 'Foul', 'Card'),
    minute int,
    field_area enum('Defensive Third', 'Middle Third', 'Attacking Third', 'Penalty Area'),
    outcome varchar(100),
    foreign key (match_id) references matches(match_id),
    foreign key (team_id) references teams(team_id),
    foreign key (player_id) references players(player_id)
);


-- substitutions table
create table substitutions (
    substitution_id int primary key auto_increment,
    match_id int,
    team_id int,
    player_out_id int,
    player_in_id int,
    minute int,
    reason enum('Tactical', 'Fitness', 'Injury'),
    foreign key (match_id) references matches(match_id),
    foreign key (team_id) references teams(team_id),
    foreign key (player_out_id) references players(player_id),
    foreign key (player_in_id) references players(player_id)
);

INSERT INTO teams (team_name, city, country) VALUES
('Riverside FC',       'Riverside',     'Asteria'),
('Harbor United',      'Port Azure',    'Asteria'),
('Northgate Athletic',  'Northgate',     'Asteria'),
('Summit Rovers',      'Summit Vale',   'Asteria'),
('Easton City',        'Easton',        'Asteria'),
('Meadowbrook SC',     'Meadowbrook',   'Asteria');

-- ---------------------------------------------------
-- PLAYERS (48 total, 8 per team)
-- ---------------------------------------------------
INSERT INTO players (team_id, first_name, last_name, position) VALUES
-- Riverside FC (team_id 1) -> player_id 1-8
(1, 'Kai',    'Johnson',  'Goalkeeper'),
(1, 'Alex',   'Silva',    'Defender'),
(1, 'Noah',   'Ibrahim',  'Defender'),
(1, 'Owen',   'Adeyemi',  'Defender'),
(1, 'Liam',   'Fischer',  'Midfielder'),
(1, 'Diego',  'Diallo',   'Midfielder'),
(1, 'Evan',   'Reyes',    'Forward'),
(1, 'Mateo',  'Petrov',   'Forward'),
-- Harbor United (team_id 2) -> player_id 9-16
(2, 'Milo',   'Rousseau', 'Goalkeeper'),
(2, 'Theo',   'Mensah',   'Defender'),
(2, 'Arlo',   'Kovacs',   'Defender'),
(2, 'Jonas',  'Dubois',   'Defender'),
(2, 'Nico',   'Moreau',   'Midfielder'),
(2, 'Felix',  'Thompson', 'Midfielder'),
(2, 'Leo',    'Kimura',   'Forward'),
(2, 'Samir',  'Torres',   'Forward'),
-- Northgate Athletic (team_id 3) -> player_id 17-24
(3, 'Rian',   'Cole',     'Goalkeeper'),
(3, 'Dante',  'Morgan',   'Defender'),
(3, 'Hugo',   'Varela',   'Defender'),
(3, 'Marek',  'Novak',    'Defender'),
(3, 'Ilan',   'Bennett',  'Midfielder'),
(3, 'Tomas',  'Alvarez',  'Midfielder'),
(3, 'Jules',  'Okafor',   'Forward'),
(3, 'Ren',    'Sato',     'Forward'),
-- Summit Rovers (team_id 4) -> player_id 25-32
(4, 'Ari',    'Clarke',   'Goalkeeper'),
(4, 'Bastien','Leroux',   'Defender'),
(4, 'Caleb',  'Nwosu',    'Defender'),
(4, 'Dario',  'Marin',    'Defender'),
(4, 'Emil',   'Costa',    'Midfielder'),
(4, 'Finn',   'Larsson',  'Midfielder'),
(4, 'Gio',    'Mercer',   'Forward'),
(4, 'Hadi',   'Rahman',   'Forward'),
-- Easton City (team_id 5) -> player_id 33-40
(5, 'Isaac',  'Vale',     'Goalkeeper'),
(5, 'Jaden',  'Cruz',     'Defender'),
(5, 'Kian',   'Bishop',   'Defender'),
(5, 'Luca',   'Ferretti', 'Defender'),
(5, 'Mason',  'Park',     'Midfielder'),
(5, 'Nolan',  'Price',    'Midfielder'),
(5, 'Omar',   'Santos',   'Forward'),
(5, 'Pavel',  'Mirov',    'Forward'),
-- Meadowbrook SC (team_id 6) -> player_id 41-48
(6, 'Quinn',  'Hart',     'Goalkeeper'),
(6, 'Rafael', 'Costa',    'Defender'),
(6, 'Soren',  'Lind',     'Defender'),
(6, 'Tariq',  'Malik',    'Defender'),
(6, 'Uri',    'Benali',   'Midfielder'),
(6, 'Victor', 'Stone',    'Midfielder'),
(6, 'Wes',    'Carter',   'Forward'),
(6, 'Yuri',   'Antonov',  'Forward');

-- ---------------------------------------------------
-- MATCHES (5)
-- ---------------------------------------------------
INSERT INTO matches (match_date, competition, season, home_team_id, away_team_id, home_score, away_score, venue) VALUES
('2026-03-14', 'Asterian Premier Division', '2025-26', 1, 2, 2, 1, 'Riverside Stadium'),
('2026-03-21', 'Asterian Premier Division', '2025-26', 3, 1, 1, 1, 'Northgate Park'),
('2026-04-04', 'Asterian Premier Division', '2025-26', 1, 4, 3, 0, 'Riverside Stadium'),
('2026-04-11', 'Asterian Premier Division', '2025-26', 5, 1, 0, 2, 'Easton Grounds'),
('2026-04-18', 'Asterian Premier Division', '2025-26', 1, 6, 2, 2, 'Riverside Stadium');

-- ---------------------------------------------------
-- MATCH_EVENTS (40)
-- ---------------------------------------------------
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute, field_area, outcome) VALUES
-- Match 1: Riverside FC (1) vs Harbor United (2)
(1, 1, 5,  'Pass',     8,  'Middle Third',    'Completed'),
(1, 2, 14, 'Turnover', 14, 'Middle Third',    'Possession Lost'),
(1, 1, 7,  'Shot',     23, 'Penalty Area',    'Goal'),
(1, 2, 15, 'Shot',     31, 'Attacking Third', 'Blocked'),
(1, 2, 16, 'Shot',     39, 'Penalty Area',    'Goal'),
(1, 1, 6,  'Foul',     52, 'Middle Third',    'Committed'),
(1, 1, 8,  'Shot',     68, 'Penalty Area',    'Goal'),
(1, 2, 11, 'Card',     76, 'Defensive Third', 'Yellow'),
-- Match 2: Northgate Athletic (3) vs Riverside FC (1)
(2, 3, 21, 'Pass',     7,  'Middle Third',    'Completed'),
(2, 1, 6,  'Turnover', 16, 'Middle Third',    'Possession Won'),
(2, 3, 23, 'Shot',     28, 'Penalty Area',    'Goal'),
(2, 1, 7,  'Shot',     35, 'Attacking Third', 'Off Target'),
(2, 3, 18, 'Foul',     47, 'Defensive Third', 'Committed'),
(2, 1, 8,  'Shot',     61, 'Penalty Area',    'Goal'),
(2, 1, 5,  'Pass',     72, 'Attacking Third', 'Incomplete'),
(2, 3, 19, 'Card',     84, 'Middle Third',    'Yellow'),
-- Match 3: Riverside FC (1) vs Summit Rovers (4)
(3, 1, 5,  'Pass',     5,  'Middle Third',    'Completed'),
(3, 1, 7,  'Shot',     18, 'Penalty Area',    'Goal'),
(3, 4, 30, 'Turnover', 24, 'Middle Third',    'Possession Lost'),
(3, 1, 8,  'Shot',     37, 'Penalty Area',    'Goal'),
(3, 4, 27, 'Foul',     49, 'Defensive Third', 'Committed'),
(3, 1, 6,  'Pass',     58, 'Attacking Third', 'Completed'),
(3, 1, 7,  'Shot',     71, 'Penalty Area',    'Goal'),
(3, 4, 28, 'Card',     82, 'Defensive Third', 'Yellow'),
-- Match 4: Easton City (5) vs Riverside FC (1)
(4, 5, 37, 'Pass',     9,  'Middle Third',    'Completed'),
(4, 1, 6,  'Turnover', 17, 'Middle Third',    'Possession Won'),
(4, 1, 7,  'Shot',     29, 'Penalty Area',    'Goal'),
(4, 5, 39, 'Shot',     41, 'Attacking Third', 'Blocked'),
(4, 5, 35, 'Foul',     50, 'Middle Third',    'Committed'),
(4, 1, 5,  'Pass',     63, 'Attacking Third', 'Completed'),
(4, 1, 8,  'Shot',     74, 'Penalty Area',    'Goal'),
(4, 5, 36, 'Card',     86, 'Defensive Third', 'Yellow'),
-- Match 5: Riverside FC (1) vs Meadowbrook SC (6)
(5, 1, 6,  'Pass',     6,  'Middle Third',    'Completed'),
(5, 6, 47, 'Shot',     15, 'Penalty Area',    'Goal'),
(5, 1, 7,  'Shot',     26, 'Penalty Area',    'Goal'),
(5, 6, 45, 'Turnover', 33, 'Middle Third',    'Possession Lost'),
(5, 6, 48, 'Shot',     48, 'Penalty Area',    'Goal'),
(5, 1, 3,  'Foul',     57, 'Defensive Third', 'Committed'),
(5, 1, 8,  'Shot',     69, 'Penalty Area',    'Goal'),
(5, 6, 43, 'Card',     81, 'Middle Third',    'Yellow');

-- ---------------------------------------------------
-- SUBSTITUTIONS (40)
-- ---------------------------------------------------
INSERT INTO substitutions (match_id, team_id, player_out_id, player_in_id, minute, reason) VALUES
-- Match 1: Riverside FC (1) vs Harbor United (2)
(1, 1, 1,  5,  55, 'Tactical'),
(1, 1, 2,  6,  62, 'Tactical'),
(1, 1, 3,  7,  69, 'Fitness'),
(1, 1, 4,  8,  76, 'Tactical'),
(1, 2, 9,  13, 58, 'Tactical'),
(1, 2, 10, 14, 65, 'Tactical'),
(1, 2, 11, 15, 72, 'Fitness'),
(1, 2, 12, 16, 79, 'Tactical'),
-- Match 2: Northgate Athletic (3) vs Riverside FC (1)
(2, 3, 17, 21, 55, 'Tactical'),
(2, 3, 18, 22, 62, 'Tactical'),
(2, 3, 19, 23, 69, 'Fitness'),
(2, 3, 20, 24, 76, 'Tactical'),
(2, 1, 1,  5,  58, 'Tactical'),
(2, 1, 2,  6,  65, 'Tactical'),
(2, 1, 3,  7,  72, 'Fitness'),
(2, 1, 4,  8,  79, 'Tactical'),
-- Match 3: Riverside FC (1) vs Summit Rovers (4)
(3, 1, 1,  5,  55, 'Tactical'),
(3, 1, 2,  6,  62, 'Tactical'),
(3, 1, 3,  7,  69, 'Fitness'),
(3, 1, 4,  8,  76, 'Tactical'),
(3, 4, 25, 29, 58, 'Tactical'),
(3, 4, 26, 30, 65, 'Tactical'),
(3, 4, 27, 31, 72, 'Fitness'),
(3, 4, 28, 32, 79, 'Tactical'),
-- Match 4: Easton City (5) vs Riverside FC (1)
(4, 5, 33, 37, 55, 'Tactical'),
(4, 5, 34, 38, 62, 'Tactical'),
(4, 5, 35, 39, 69, 'Fitness'),
(4, 5, 36, 40, 76, 'Tactical'),
(4, 1, 1,  5,  58, 'Tactical'),
(4, 1, 2,  6,  65, 'Tactical'),
(4, 1, 3,  7,  72, 'Fitness'),
(4, 1, 4,  8,  79, 'Tactical'),
-- Match 5: Riverside FC (1) vs Meadowbrook SC (6)
(5, 1, 1,  5,  55, 'Tactical'),
(5, 1, 2,  6,  62, 'Tactical'),
(5, 1, 3,  7,  69, 'Fitness'),
(5, 1, 4,  8,  76, 'Tactical'),
(5, 6, 41, 45, 58, 'Tactical'),
(5, 6, 42, 46, 65, 'Tactical'),
(5, 6, 43, 47, 72, 'Fitness'),
(5, 6, 44, 48, 79, 'Tactical');

-- soccer_db_schema sample queries

-- Queries
-- 1 Display match results with team names
/*
This query displays a list of all matches and shows the names
of home/away teams.
In terms of stakeholders, this query benefits coaches, 
analysts and managers who want an overview of past matches,
scores, dates, and locations.
*/

SELECT m.match_id, m.match_date, home.team_name AS home_team,
	away.team_name AS away_team, m.home_score, m.away_score,
    m.venue
FROM matches AS m
JOIN teams AS home
	ON m.home_team_id = home.team_id
JOIN teams AS away
	ON m.away_team_id = away.team_id
ORDER BY m.match_date;

-- Query 2: Players who scored goals
/*
The query identifys every player who scored at least a goal
and cound the number of goals for each player.
This info/query is particularly relevant for coaches,
analysts, and players who want to identfy productive attacking
players and review scoring performance.
*/

SELECT p.first_name, p.last_name, t.team_name,
	COUNT(*) AS goals_scored
FROM match_events AS me
JOIN players AS p
	ON me.player_id = p.player_id
JOIN teams AS t
	ON p.team_id = t.team_id
WHERE me.event_type = 'Shot'
	AND me.outcome = 'Goal'
GROUP BY
	p.player_id,
    p.first_name,
    p.last_name,
    t.team_name
ORDER BY goals_scored DESC;

-- Query 3: Show Substitution Details
/* 
The query provides a history of subsitutions displaying
match, team, player leaving, player entering, minute, reason

Key stakeholders are coaches medical staff, analysts, and
managers. The query helps these stakeholders evaluate tactical
decisions and substitutions caused by fitness/injury is 
particularly important for these stakeholders.
*/
SELECT s.match_id, m.match_date, t.team_name,
	CONCAT(p_out.first_name, ' ', p_out.last_name) AS player_out,
    CONCAT(p_in.first_name, ' ', p_in.last_name) AS player_in,
    s.minute, s.reason
FROM substitutions AS s
JOIN matches AS m
	ON s.match_id = m.match_id
JOIN teams AS t
	ON s.team_id = t.team_id
JOIN players AS p_out
	ON s.player_out_id = p_out.player_id
JOIN players AS p_in
	ON s.player_in_id = p_in.player_id
ORDER BY 
	m.match_date,
    s.minute;

-- Query 4 Show all yellow cards recorded
/*
This query shows all the yellow cards recorded in the database. 
This is particularly useful for players, coaches, and analysts.
Coaches and player need to know this info to know how aggressive they
can potentially play. 
*/
SELECT p.first_name, p.last_name, me.minute
FROM match_events AS me
JOIN players AS p
	ON me.player_id = p.player_id
WHERE me.event_type = 'Card'
	AND me.outcome = 'Yellow';

-- VIEWS
-- View 1: player and team information
/*
Useful for coaches, analysts, and managers
The view combines player information with the player's
team name. 
*/
CREATE VIEW player_team_view AS
SELECT p.player_id, p.first_name,
	p.last_name, p.position, t.team_name
FROM players AS p
JOIN teams AS t
	ON p.team_id = t.team_id;
    
SELECT *
FROM player_team_view;
 
-- View 2: Match event details
/*
This view combines match-events data with player and team names. 
Coaches and analysts who want to review passes, shots, fouls,
cards, and other recorded events.
*/
CREATE VIEW match_event_view AS
SELECT me.event_id, me.match_id, p.first_name,
	p.last_name, t.team_name, me.event_type, me.minute,
    me.outcome
FROM match_events AS me
JOIN players AS p
	ON me.player_id = p.player_id
JOIN teams AS t
	ON me.team_id = t.team_id;

SELECT *
FROM match_event_view;
