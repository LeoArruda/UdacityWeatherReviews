/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";


CREATE OR REPLACE TABLE yelp_review (
    review_id TEXT,
    user_id TEXT,
    business_id TEXT,
    stars NUMERIC(3,2),
    useful INT,
    funny INT,
    cool INT,
    text TEXT,
    timestamp DATETIME
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
PUT file://C:\temp\Udacity\Yelp\yelp_academic_dataset_review.json @large_file_stage auto_compress=true parallel=4;


COPY INTO yelp_review(review_id, user_id, business_id, stars, useful, funny, cool, text, timestamp)
    FROM (SELECT parse_json($1):review_id,
                 parse_json($1):user_id,
                 parse_json($1):business_id,
                 parse_json($1):stars,
                 parse_json($1):useful,
                 parse_json($1):funny,
                 parse_json($1):cool,
                 parse_json($1):text,
                 to_timestamp_ntz(parse_json($1):date)
          FROM @large_file_stage/yelp_academic_dataset_review.json.gz t)
    ON_ERROR = 'continue';