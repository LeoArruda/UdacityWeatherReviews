/* 
==========================================================================================================
SQL-Script to create or replace the tables for the DW Schema
==========================================================================================================


==========================================================================================================
 Create and use database and schema
==========================================================================================================
 */

USE DATABASE "UDACITY_FINAL_PROJECT";

USE SCHEMA "UDACITY_FINAL_PROJECT"."DW_SCHEMA";


/* 
==========================================================================================================
Create Dimension table business 
==========================================================================================================
*/
CREATE OR REPLACE TABLE dimBusiness (
    business_id                       TEXT   PRIMARY KEY,
    name                              TEXT,
    stars                             NUMERIC(3,2),
    review_count                      INT,
    is_open                           BOOLEAN,
	categories 			              TEXT,
	location_address                  TEXT,
    location_city                     TEXT,
    location_state                    TEXT,
    location_postal_code              INT,
    location_latitude                 FLOAT,
    location_longitude                FLOAT, 
	checkin_date                      DATETIME,
	covid_highlights                  TEXT,
    covid_delivery_or_takeout         TEXT,
    covid_grubhub_enabled             TEXT,
    covid_call_to_action_enabled      TEXT,
    covid_request_a_quote_enabled     TEXT,
    covid_covid_banner                TEXT,
    covid_temporary_closed_until      TEXT,
    covid_virtual_services_offered    TEXT
);


/* 
==========================================================================================================
Create Dimension table Date
==========================================================================================================
*/
CREATE OR REPLACE TABLE dimDate (
    timestamp           DATETIME    PRIMARY KEY,
    date                DATE,
    day                 INT,
    month               INT,
    year                INT,
	week                INT,
	quarter             INT
);

/* 
==========================================================================================================
Create Dimension table User 
==========================================================================================================
*/
CREATE OR REPLACE TABLE dimUser (
    user_id             TEXT      PRIMARY KEY,
    name                TEXT,
    review_count        INT,
    yelping_since       DATETIME,
    useful              INT,
    funny               INT,
    cool                INT,
    elite               TEXT,
    friends             TEXT,
    fans                INT,
    average_stars       NUMERIC(3,2),
    compliment_hot      INT,
    compliment_more     INT,
    compliment_profile  INT,
    compliment_cute     INT,
    compliment_list     INT,
    compliment_note     INT,
    compliment_plain    INT,
    compliment_cool     INT,
    compliment_funny    INT,
    compliment_writer   INT,
    compliment_photos   INT
);


/*
==========================================================================================================
Create Dimension table Weather (Consolidating Temperature and Precipitation) 
==========================================================================================================
*/
CREATE OR REPLACE TABLE dimWeather (
    date                        DATE    PRIMARY KEY,
    temp_min                    FLOAT,
    temp_max                    FLOAT,
    temp_normal_min             FLOAT,
    temp_normal_max             FLOAT,
    precipitation               FLOAT,
    precipitation_normal        FLOAT
);


/* 
==========================================================================================================
Create Fact table Review 
==========================================================================================================
*/
CREATE OR REPLACE TABLE factReview (
    review_id           TEXT   PRIMARY KEY,
    user_id             TEXT,
    business_id         TEXT,
    stars               NUMERIC(3,2),
    useful              BOOLEAN,
    funny               BOOLEAN,
    cool                BOOLEAN,
    text                TEXT,
    timestamp           DATETIME,
	date                DATE,
	CONSTRAINT FK_FACT_REVIEW_DIMBUSINESS_ID              FOREIGN KEY(business_id)    REFERENCES  dimBusiness(business_id),
    CONSTRAINT FK_FACT_REVIEW_DIMUSER_ID                  FOREIGN KEY(user_id)        REFERENCES  dimUser(user_id),
    CONSTRAINT FK_FACT_REVIEW_TIMESTAMP_DIMDATE_TIMESTAMP FOREIGN KEY(timestamp)      REFERENCES  dimDate(timestamp),
	CONSTRAINT FK_FACT_REVIEW_DATE_DIMWEATHER_DATE        FOREIGN KEY(date)           REFERENCES  dimWeather(date)
);