-- 1. Справочник клубов (чтобы не дублировать названия текстом)
CREATE TABLE clubs (
    club_id SERIAL PRIMARY KEY,
    club_name VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Таблица игроков (персональные данные, которые не меняются от матча к матчу)
CREATE TABLE players (
    player_id VARCHAR(20) PRIMARY KEY,
    player_name VARCHAR(150) NOT NULL,
    age INT,
    nationality VARCHAR(100),
    team VARCHAR(100), -- Сборная (например, Spain)
    jersey_number INT,
    position VARCHAR(50),
    height_cm INT,
    weight_kg INT,
    preferred_foot VARCHAR(10),
    club_id INT REFERENCES clubs(club_id),
    market_value_eur BIGINT
);

-- 3. Таблица матчей (общая информация о самой игре)
CREATE TABLE matches (
    match_id VARCHAR(20) PRIMARY KEY,
    match_date DATE,
    stadium VARCHAR(150),
    city VARCHAR(100),
    tournament_stage VARCHAR(50)
);

-- 4. Основная таблица фактов: Статистика игрока в конкретном матче
-- Сюда пойдут все игровые, физические и аналитические метрики
CREATE TABLE player_match_stats (
    player_id VARCHAR(20) REFERENCES players(player_id),
    match_id VARCHAR(20) REFERENCES matches(match_id),
    opponent_team VARCHAR(100),
    match_result VARCHAR(5), -- W, L, D
    goals_team INT,
    goals_opponent INT,
    minutes_played INT,
    
    -- Атакующие метрики
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    shots INT DEFAULT 0,
    shots_on_target INT DEFAULT 0,
    expected_goals_xg NUMERIC(5,2),
    expected_assists_xa NUMERIC(5,2),
    key_passes INT DEFAULT 0,
    
    -- Передачи и дриблинг
    successful_passes INT DEFAULT 0,
    total_passes INT DEFAULT 0,
    pass_accuracy NUMERIC(5,2),
    dribbles_attempted INT DEFAULT 0,
    successful_dribbles INT DEFAULT 0,
    crosses INT DEFAULT 0,
    successful_crosses INT DEFAULT 0,
    
    -- Оборонительные метрики
    tackles INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    clearances INT DEFAULT 0,
    blocks INT DEFAULT 0,
    aerial_duels_won INT DEFAULT 0,
    aerial_duels_lost INT DEFAULT 0,
    recoveries INT DEFAULT 0,
    defensive_actions INT DEFAULT 0,
    
    -- Нарушения и карточки
    fouls_committed INT DEFAULT 0,
    fouls_suffered INT DEFAULT 0,
    yellow_cards INT DEFAULT 0,
    red_cards INT DEFAULT 0,
    offsides INT DEFAULT 0,
    
    -- Статистика вратарей (для Rodri Fati и др.)
    saves INT DEFAULT 0,
    save_percentage NUMERIC(5,2),
    punches INT DEFAULT 0,
    clean_sheet INT DEFAULT 0,
    goals_conceded INT DEFAULT 0,
    penalty_saves INT DEFAULT 0,
    
    -- Физ. подготовка и телеметрия
    distance_covered_km NUMERIC(5,2),
    sprint_distance_km NUMERIC(5,2),
    top_speed_kmh NUMERIC(5,2),
    accelerations INT DEFAULT 0,
    decelerations INT DEFAULT 0,
    stamina_score NUMERIC(5,2),
    
    -- Аналитические оценки (Рейтинги)
    player_rating NUMERIC(4,2),
    performance_score NUMERIC(5,2),
    offensive_contribution NUMERIC(5,2),
    defensive_contribution NUMERIC(5,2),
    possession_impact NUMERIC(5,2),
    pressure_resistance NUMERIC(5,2),
    creativity_score NUMERIC(5,2),
    consistency_score NUMERIC(5,2),
    clutch_performance_score NUMERIC(5,2),
    
    -- Накопительный итог на турнире (Tournament summary)
    total_goals_tournament INT DEFAULT 0,
    total_assists_tournament INT DEFAULT 0,
    total_minutes_tournament INT DEFAULT 0,
    player_of_match_awards INT DEFAULT 0,
    tournament_rating NUMERIC(4,2),

    PRIMARY KEY (player_id, match_id) -- Составной ключ: один игрок — один матч
);