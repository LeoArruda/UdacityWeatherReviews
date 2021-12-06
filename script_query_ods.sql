/*
==========================================================================================================
 Use database and schema
==========================================================================================================
 */

USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."ODS_SCHEMA";

/*
==========================================================================================================
 SQL queries code that reports the business name, review stars, and temperature minimum and maximum.
==========================================================================================================
*/

SELECT BUSINESS.NAME, 
       AVG(REVIEW.STARS) AS "AVERAGE STARS",
       TEMP.TEMP_MIN AS "TEMP. MINIMUM",
       TEMP.TEMP_MAX AS "TEMP. MAXIMUM",
       CAST(REVIEW.TIMESTAMP AS DATE) AS DATE
FROM "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."REVIEW" AS REVIEW
LEFT JOIN "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."BUSINESS" AS BUSINESS
     ON REVIEW.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."TEMPERATURE" AS TEMP
     ON CAST(REVIEW.TIMESTAMP AS DATE) = TEMP.DATE
GROUP BY BUSINESS.NAME, REVIEW.TIMESTAMP, REVIEW.STARS, TEMP.TEMP_MIN, TEMP.TEMP_MAX
ORDER BY 4 DESC
LIMIT 8;