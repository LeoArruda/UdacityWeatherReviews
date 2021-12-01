/* Select and use database and schema */
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA";


/* Create or replace a file format */
CREATE OR REPLACE FILE FORMAT file_csv_format
	FIELD_DELIMITER = ','
	SKIP_HEADER = 1 
    RECORD_DELIMITER = '\\n';

/* Create a temporary internal stage that references the file format object.                                  */
/* Similar to temporary tables, temporary stages are automatically dropped at the end of the session.         */

CREATE OR REPLACE TEMPORARY STAGE large_file_stage
    FILE_FORMAT = file_csv_format;

/* Stage the data file.                                                                                       */
PUT file://C:\temp\Udacity\Weather\USW00023169-temperature-degreeF.csv  @large_file_stage auto_compress=true parallel=4;          


COPY INTO weather_temperature(date, min, max, normal_min, normal_max)
    FROM @large_file_stage/USW00023169-temperature-degreeF.csv.gz
    ON_ERROR = 'continue';