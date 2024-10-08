-- 경기 정보 테이블
CREATE TABLE sport_event (
    id VARCHAR PRIMARY KEY,
    start_time TIMESTAMP,
    start_time_confirmed BOOLEAN,
    sport_name VARCHAR,
    category_name VARCHAR,
    competition_name VARCHAR,
    competition_type VARCHAR,
    competition_gender VARCHAR,
    season_name VARCHAR,
    season_start_date DATE,
    season_end_date DATE,
    stage_order INTEGER,
    stage_type VARCHAR,
    stage_phase VARCHAR,
    round_number INTEGER,
    round_name VARCHAR,
    group_id VARCHAR,
    group_name VARCHAR,
    best_of INTEGER,
    status VARCHAR,
    match_status VARCHAR,
    home_score INTEGER,
    away_score INTEGER,
    winner_id VARCHAR,
    venue_id VARCHAR
);

-- 참가자 정보 테이블
CREATE TABLE competitors (
    competitor_id VARCHAR,
    event_id VARCHAR,
    name VARCHAR,
    country VARCHAR,
    country_code VARCHAR,
    abbreviation VARCHAR,
    qualifier VARCHAR,
    gender VARCHAR,
    date_of_birth DATE
);
--     PRIMARY KEY (competitor_id, event_id),
--     CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES sport_event(id)

-- 경기 장소 테이블
CREATE TABLE venue (
    id VARCHAR PRIMARY KEY,
    name VARCHAR,
    city_name VARCHAR,
    country_name VARCHAR,
    map_coordinates VARCHAR,
    country_code VARCHAR,
    timezone VARCHAR
);

-- 세부 점수 테이블
CREATE TABLE period_scores (
    id SERIAL PRIMARY KEY,
    event_id VARCHAR,
    period_number INTEGER,
    home_score INTEGER,
    away_score INTEGER,
    period_type VARCHAR
);
--     CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES sport_event(id),
--     CONSTRAINT unique_event_period UNIQUE (event_id, period_number)
ALTER TABLE competitors
ADD CONSTRAINT unique_competitor_event UNIQUE (competitor_id, event_id);
ALTER TABLE period_scores
ADD CONSTRAINT unique_event_period UNIQUE (event_id, period_number);

