/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";


CREATE OR REPLACE TABLE yelp_user (
    user_id TEXT,
    name TEXT,
    review_count INT,
    yelping_since DATETIME,
    useful INT,
    funny INT,
    cool INT,
    elite TEXT,
    friends TEXT,
    fans INT,
    average_stars NUMERIC(3,2),
    compliment_hot INT,
    compliment_more INT,
    compliment_profile INT,
    compliment_cute INT,
    compliment_list INT,
    compliment_note INT,
    compliment_plain INT,
    compliment_cool INT,
    compliment_funny INT,
    compliment_writer INT,
    compliment_photos INT
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
PUT file://C:\temp\Udacity\Yelp\yelp_academic_dataset_user.json @large_file_stage auto_compress=true parallel=4;

COPY INTO yelp_user(user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends, fans, average_stars,
                    compliment_hot, compliment_more, compliment_profile, compliment_cute, compliment_list, compliment_note,
                    compliment_plain, compliment_cool, compliment_funny, compliment_writer, compliment_photos)
    FROM (SELECT parse_json($1):user_id,
                 parse_json($1):name,
                 parse_json($1):review_count,
                 to_timestamp_ntz(parse_json($1):yelping_since),
                 parse_json($1):useful,
                 parse_json($1):funny,
                 parse_json($1):cool,
                 parse_json($1):elite,
                 parse_json($1):friends,
                 parse_json($1):fans,
                 parse_json($1):average_stars,
                 parse_json($1):compliment_hot,
                 parse_json($1):compliment_more,
                 parse_json($1):compliment_profile,
                 parse_json($1):compliment_cute,
                 parse_json($1):compliment_list,
                 parse_json($1):compliment_note,
                 parse_json($1):compliment_plain,
                 parse_json($1):compliment_cool,
                 parse_json($1):compliment_funny,
                 parse_json($1):compliment_writer,
                 parse_json($1):compliment_photos
          FROM @large_file_stage/yelp_academic_dataset_user.json.gz t)
    ON_ERROR = 'continue';

