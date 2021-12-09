/* SQL-Script to create or replace the tables for the ODS */

/* Select/use database and schema */

USE DATABASE "UDACITY_FINAL_PROJECT";

CREATE OR REPLACE SCHEMA "UDACITY_FINAL_PROJECT"."ODS_SCHEMA";

USE SCHEMA "UDACITY_FINAL_PROJECT"."ODS_SCHEMA";

/* Table location */
CREATE OR REPLACE TABLE location (
    location_id     INT      PRIMARY KEY  IDENTITY,
    address         TEXT,
    city            TEXT,
    state           TEXT,
    postal_code     INT,
    latitude        FLOAT,
    longitude       FLOAT
);

/* 
==========================================================================================================
Create Business table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE business (
    business_id         TEXT   PRIMARY KEY,
    name                TEXT,
    location_id         INT,
    stars               NUMERIC(3,2),
    review_count        INT,
    is_open             BOOLEAN,
	categories 			TEXT,
    CONSTRAINT FK_BUSINESS_LOCATION_ID FOREIGN KEY(location_id)    REFERENCES  location(location_id)
);


/* 
==========================================================================================================
Create Business Attributes table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE business_attributes (
    business_id         		TEXT     PRIMARY KEY,
    NoiseLevel 					TEXT,
    BikeParking 				BOOLEAN,
    RestaurantsAttire 			TEXT,
    BusinessAcceptsCreditCards 	BOOLEAN,
    BusinessParking 			TEXT,
    RestaurantsReservations 	TEXT,
    GoodForKids 				BOOLEAN,
    RestaurantsTakeOut 			BOOLEAN,
    Caters 						BOOLEAN,
    WiFi 						TEXT,
    RestaurantsDelivery 		BOOLEAN,
    HasTV 						BOOLEAN,
    RestaurantsPriceRange2 		INT,
    Alcohol 					TEXT,
    Music 						TEXT,
    BusinessAcceptsBitcoin 		BOOLEAN,
    GoodForDancing 				BOOLEAN,
    DogsAllowed 				BOOLEAN,
    BestNights 					TEXT,
    RestaurantsGoodForGroups 	BOOLEAN,
    OutdoorSeating 				BOOLEAN,
    HappyHour 					BOOLEAN,
    RestaurantsTableService 	BOOLEAN,
    GoodForMeal 				TEXT,
    WheelchairAccessible 		BOOLEAN,
    Ambience 					TEXT,
    CoatCheck 					BOOLEAN,
    DriveThru 					BOOLEAN,
    Smoking 					TEXT,
    BYOB 						BOOLEAN,
    Corkage 					BOOLEAN,
	CONSTRAINT FK_BUSINESS_ATTRIBUTE_BUSINESS_ID FOREIGN KEY(business_id)    REFERENCES  business(business_id)
);

/* 
==========================================================================================================
Create Business table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE business_hours (
    business_id       TEXT   PRIMARY KEY,
    monday            TEXT,
	tuesday           TEXT,
	wednesday         TEXT,
	thursday          TEXT,
	friday            TEXT,
	saturday          TEXT,
	sunday            TEXT,
	CONSTRAINT FK_BUSINESS_HOURS_BUSINESS_ID FOREIGN KEY(business_id)    REFERENCES  business(business_id)
);


/* 
==========================================================================================================
Create Date Time table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE date_time (
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
Create User table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE user (
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
    compliment_photos   INT,
    CONSTRAINT FK_USER_DATE_TIME_ID FOREIGN KEY(yelping_since)      REFERENCES  date_time(timestamp)
);

/* 
==========================================================================================================
Create Tip table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE tip (
    tip_id              INT  PRIMARY KEY   IDENTITY,
    user_id             TEXT,
    business_id         TEXT,
    text                TEXT,
    timestamp           DATETIME,
    compliment_count    INT,
	CONSTRAINT FK_TIP_BUSINESS_ID  FOREIGN KEY(business_id)    REFERENCES  business(business_id),
    CONSTRAINT FK_TIP_USER_ID      FOREIGN KEY(user_id)        REFERENCES  user(user_id),
    CONSTRAINT FK_TIP_DATE_TIME_ID FOREIGN KEY(timestamp)      REFERENCES  date_time(timestamp)
);

/* 
==========================================================================================================
Create Review table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE review (
    review_id           TEXT   PRIMARY KEY,
    user_id             TEXT,
    business_id         TEXT,
    stars               NUMERIC(3,2),
    useful              BOOLEAN,
    funny               BOOLEAN,
    cool                BOOLEAN,
    text                TEXT,
    timestamp           DATETIME,
	CONSTRAINT FK_REVIEW_BUSINESS_ID FOREIGN KEY(business_id)    REFERENCES  business(business_id),
    CONSTRAINT FK_REVIEW_USER_ID FOREIGN KEY(user_id)        REFERENCES  user(user_id),
    CONSTRAINT FK_REVIEW_DATE_TIME_ID FOREIGN KEY(timestamp)      REFERENCES  date_time(timestamp)
);

/* 
==========================================================================================================
Create Chekin table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE checkin (
    checkin_id          INT     PRIMARY KEY  IDENTITY,
    business_id         TEXT,
    timestamp           DATETIME,
    CONSTRAINT FK_CHECKIN_BUSINESS_ID FOREIGN KEY(business_id)    REFERENCES  business(business_id)
);

/* 
==========================================================================================================
Create Covid table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE covid (
    covid_id                    INT     PRIMARY KEY  IDENTITY,
    business_id                 TEXT,
    highlights                  TEXT,
    delivery_or_takeout         TEXT,
    grubhub_enabled             TEXT,
    call_to_action_enabled      TEXT,
    request_a_quote_enabled     TEXT,
    covid_banner                TEXT,
    temporary_closed_until      TEXT,
    virtual_services_offered    TEXT,
    CONSTRAINT FK_COVID_BUSINESS_ID   FOREIGN KEY(business_id)    REFERENCES  business(business_id)
);

/* 
==========================================================================================================
Create Temperature table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE temperature (
    temperature_id              INT     PRIMARY KEY  IDENTITY,
    date                        DATE,
    temp_min                    FLOAT,
    temp_max                    FLOAT,
    temp_normal_min             FLOAT,
    temp_normal_max             FLOAT
);

/* 
==========================================================================================================
Create Precipitation table 
==========================================================================================================
*/
CREATE OR REPLACE TABLE precipitation (
    precipitation_id            INT     PRIMARY KEY  IDENTITY,
    date                        DATE,
    precipitation               FLOAT,
    precipitation_normal        FLOAT
);