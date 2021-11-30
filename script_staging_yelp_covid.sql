/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";

CREATE OR REPLACE TABLE yelp_covid (
    business_id TEXT,
    highlights TEXT,
    delivery_or_takeout TEXT,
    grubhub_enabled TEXT,
    call_to_action_enabled TEXT,
    request_a_quote_enabled TEXT,
    covid_banner TEXT,
    temporary_closed_until TEXT,
    virtual_services_offered TEXT
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
PUT file://C:\temp\Udacity\Yelp\yelp_academic_dataset_covid_features.json @large_file_stage auto_compress=true parallel=4;

COPY INTO yelp_covid(business_id, highlights, delivery_or_takeout, grubhub_enabled, call_to_action_enabled,
                     request_a_quote_enabled, covid_banner, temporary_closed_until, virtual_services_offered)
    FROM (SELECT parse_json($1):business_id,
                 parse_json($1):highlights,
                 parse_json($1):delivery_or_takeout,
                 parse_json($1):Grubhub_enabled,
                 parse_json($1):Call_To_Action_enabled,
                 parse_json($1):Request_a_Quote_Enabled,
                 parse_json($1):Covid_Banner,
                 parse_json($1):Temporary_Closed_Until,
                 parse_json($1):Virtual_Services_Offered
          FROM @large_file_stage/yelp_academic_dataset_covid_features.json.gz t)
    ON_ERROR = 'continue';