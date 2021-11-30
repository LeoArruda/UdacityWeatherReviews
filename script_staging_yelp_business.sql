/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";


CREATE OR REPLACE TABLE yelp_business (
    business_id TEXT,
    name TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    postal_code INT,
    latitude FLOAT,
    longitude FLOAT,
    stars NUMERIC(3,2),
    review_count INT,
    is_open INT,
    attributes_NoiseLevel TEXT,
    attributes_BikeParking BOOLEAN,
    attributes_RestaurantsAttire TEXT,
    attributes_BusinessAcceptsCreditCards BOOLEAN,
    attributes_BusinessParking TEXT,
    attributes_RestaurantsReservations TEXT,
    attributes_GoodForKids BOOLEAN,
    attributes_RestaurantsTakeOut BOOLEAN,
    attributes_Caters BOOLEAN,
    attributes_WiFi TEXT,
    attributes_RestaurantsDelivery BOOLEAN,
    attributes_HasTV BOOLEAN,
    attributes_RestaurantsPriceRange2 INT,
    attributes_Alcohol TEXT,
    attributes_Music TEXT,
    attributes_BusinessAcceptsBitcoin BOOLEAN,
    attributes_GoodForDancing BOOLEAN,
    attributes_DogsAllowed BOOLEAN,
    attributes_BestNights TEXT,
    attributes_RestaurantsGoodForGroups BOOLEAN,
    attributes_OutdoorSeating BOOLEAN,
    attributes_HappyHour BOOLEAN,
    attributes_RestaurantsTableService BOOLEAN,
    attributes_GoodForMeal TEXT,
    attributes_WheelchairAccessible BOOLEAN,
    attributes_Ambience TEXT,
    attributes_CoatCheck BOOLEAN,
    attributes_DriveThru BOOLEAN,
    attributes_Smoking TEXT,
    attributes_BYOB BOOLEAN,
    attributes_Corkage BOOLEAN,
    categories TEXT,
    hours_Monday TEXT,
    hours_Tuesday TEXT,
    hours_Wednesday TEXT,
    hours_Thursday TEXT,
    hours_Friday TEXT,
    hours_Saturday TEXT,
    hours_Sunday TEXT
);


/* Create or replace a file format */
CREATE OR REPLACE FILE FORMAT file_csv_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

/* Create a temporary internal stage that references the file format object.                                  */
/* Similar to temporary tables, temporary stages are automatically dropped at the end of the session.         */

CREATE OR REPLACE TEMPORARY STAGE large_file_stage
    FILE_FORMAT = file_csv_format;

/* Stage the data file.                                                                                       */
PUT file://C:\temp\Udacity\Yelp\yelp_academic_dataset_business.json @large_file_stage auto_compress=true parallel=4;



COPY INTO yelp_business(business_id, name, address, city, state, postal_code, latitude, longitude, stars,
                        review_count, is_open, attributes_NoiseLevel, attributes_BikeParking, attributes_RestaurantsAttire,
                        attributes_BusinessAcceptsCreditCards, attributes_BusinessParking, attributes_RestaurantsReservations,
                        attributes_GoodForKids, attributes_RestaurantsTakeOut, attributes_Caters, attributes_WiFi,
                        attributes_RestaurantsDelivery, attributes_HasTV, attributes_RestaurantsPriceRange2, attributes_Alcohol,
                        attributes_Music, attributes_BusinessAcceptsBitcoin, attributes_GoodForDancing, attributes_DogsAllowed,
                        attributes_BestNights, attributes_RestaurantsGoodForGroups, attributes_OutdoorSeating,
                        attributes_HappyHour, attributes_RestaurantsTableService, attributes_GoodForMeal,
                        attributes_WheelchairAccessible, attributes_Ambience, attributes_CoatCheck, attributes_DriveThru,
                        attributes_Smoking, attributes_BYOB, attributes_Corkage, categories,
                        hours_Monday, hours_Tuesday, hours_Wednesday, hours_Thursday, hours_Friday, hours_Saturday, hours_Sunday)
    FROM (SELECT parse_json($1):business_id,
                 parse_json($1):name,
                 parse_json($1):address,
                 parse_json($1):city,
                 parse_json($1):state,
                 parse_json($1):postal_code,
                 parse_json($1):latitude,
                 parse_json($1):longitude,
                 parse_json($1):stars,
                 parse_json($1):review_count,
                 parse_json($1):is_open,
                 parse_json($1):attributes.NoiseLevel,
                 parse_json($1):attributes.BikeParking,
                 parse_json($1):attributes.RestaurantsAttire,
                 parse_json($1):attributes.BusinessAcceptsCreditCards,
                 parse_json($1):attributes.BusinessParking,
                 parse_json($1):attributes.RestaurantsReservations,
                 parse_json($1):attributes.GoodForKids,
                 parse_json($1):attributes.RestaurantsTakeOut,
                 parse_json($1):attributes.Caters,
                 parse_json($1):attributes.WiFi,
                 parse_json($1):attributes.RestaurantsDelivery,
                 parse_json($1):attributes.HasTV,
                 parse_json($1):attributes.RestaurantsPriceRange2,
                 parse_json($1):attributes.Alcohol,
                 parse_json($1):attributes.Music,
                 parse_json($1):attributes.BusinessAcceptsBitcoin,
                 parse_json($1):attributes.GoodForDancing,
                 parse_json($1):attributes.DogsAllowed,
                 parse_json($1):attributes.BestNights,
                 parse_json($1):attributes.RestaurantsGoodForGroups,
                 parse_json($1):attributes.OutdoorSeating,
                 parse_json($1):attributes.HappyHour,
                 parse_json($1):attributes.RestaurantsTableService,
                 parse_json($1):attributes.GoodForMeal,
                 parse_json($1):attributes.WheelchairAccessible,
                 parse_json($1):attributes.Ambience,
                 parse_json($1):attributes.CoatCheck,
                 parse_json($1):attributes.DriveThru,
                 parse_json($1):attributes.Smoking,
                 parse_json($1):attributes.BYOB,
                 parse_json($1):attributes.Corkage,
                 parse_json($1):categories,
                 parse_json($1):hours.Monday,
                 parse_json($1):hours.Tuesday,
                 parse_json($1):hours.Wednesday,
                 parse_json($1):hours.Thursday,
                 parse_json($1):hours.Friday,
                 parse_json($1):hours.Saturday,
                 parse_json($1):hours.Sunday 
          FROM @large_file_stage/yelp_academic_dataset_business.json.gz t)
    ON_ERROR = 'continue';
	