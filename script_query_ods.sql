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
==========================================================================================================
 In this query, I'm connecting the Yelp Data and Climate data, joining the records by transforming the
 Timestamp to Date from Yelp data with the Climate Date.
 With that, I can identify when the reviews happened and how was the weather at that moment.
==========================================================================================================
*/


SELECT BUSINESS.NAME, 
       AVG(REVIEW.STARS) AS "AVERAGE STARS",
       TEMP.TEMP_MIN AS "TEMP. MINIMUM",
       TEMP.TEMP_MAX AS "TEMP. MAXIMUM",
       PREC.PRECIPITATION AS "PRECIPITATION",
       COVID.HIGHLIGHTS AS "HIGHLIGHTS",
       CAST(REVIEW.TIMESTAMP AS DATE) AS DATE
FROM "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."REVIEW" AS REVIEW
LEFT JOIN "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."BUSINESS" AS BUSINESS
     ON REVIEW.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."ODS_SCHEMA"."TEMPERATURE" AS TEMP
     ON CAST(REVIEW.TIMESTAMP AS DATE) = TEMP.DATE
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."WEATHER_PRECIPITATION" AS PREC
     ON CAST(REVIEW.TIMESTAMP AS DATE) = PREC.DATE
LEFT JOIN  "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_TIP" AS TIP
     ON TIP.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN  "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_USER" AS USERS
     ON REVIEW.USER_ID = TIP.USER_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_COVID" AS COVID
     ON COVID.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_CHECKIN" AS CHECKIN
     ON COVID.BUSINESS_ID = BUSINESS.BUSINESS_ID
GROUP BY BUSINESS.NAME, REVIEW.TIMESTAMP, REVIEW.STARS, TEMP.TEMP_MIN, TEMP.TEMP_MAX
ORDER BY 4 DESC
LIMIT 8;