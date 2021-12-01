/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";

/* Create or replace a file format */
CREATE OR REPLACE FILE FORMAT file_json_format
    FIELD_DELIMITER = NONE
    RECORD_DELIMITER = '\\n';

/* Create a temporary internal stage that references the file format object.                                  */
/* Similar to temporary tables, temporary stages are automatically dropped at the end of the session.         */

CREATE OR REPLACE TEMPORARY STAGE large_file_stage
    FILE_FORMAT = file_json_format;

/* Stage the data file.                                                                                       */
PUT file://C:\temp\Udacity\Yelp\yelp_academic_dataset_checkin.json @large_file_stage auto_compress=true parallel=4;



COPY INTO yelp_checkin(business_id, date)
    FROM (SELECT parse_json($1):business_id,
                 parse_json($1):date
          FROM @large_file_stage/yelp_academic_dataset_checkin.json.gz t)
    ON_ERROR = 'continue';