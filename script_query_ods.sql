/*
==========================================================================================================
 Use database and schema
==========================================================================================================
 */

USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."ODS_SCHEMA";

/*
==========================================================================================================
 SQL queries code that reports the business name, review stars, and temperature minimum and maximum,
 precipitation, covid highlights, tips, checkin, and users. 

 In this query, I'm connecting all Yelp Data tables and Climate data tables, joining the records by 
 transforming the Timestamp to Date from Yelp data with the Climate Date.
 With that, I can identify when the reviews happened and how was the weather at that moment.
==========================================================================================================

****  This query shows how all tables could be joining by teh keys: Business_id, users_id, and date.  ****

==========================================================================================================

*/

SELECT BUSINESS.NAME, 
       SUM(REVIEW.STARS) AS "SUM STARS",
       TEMP.MIN AS "TEMP. MINIMUM",
       TEMP.MAX AS "TEMP. MAXIMUM",
       PREC.PRECIPITATION AS "PRECIPITATION",
       COVID.HIGHLIGHTS AS "HIGHLIGHTS",
       COUNT(TIP.COMPLIMENT_COUNT) AS "# OF TIPS",
       COUNT(CHECKIN.DATE) AS "# OF CHECKINS",
       AVG(USERS.AVERAGE_STARS) AS "AVG STARS",
       CAST(REVIEW.TIMESTAMP AS DATE) AS DATE
FROM "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_REVIEW" AS REVIEW
JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_BUSINESS" AS BUSINESS
     ON REVIEW.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN  "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_TIP" AS TIP
     ON TIP.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN  "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_USER" AS USERS
     ON USERS.USER_ID = REVIEW.USER_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_COVID" AS COVID
     ON COVID.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."YELP_CHECKIN" AS CHECKIN
    ON CHECKIN.BUSINESS_ID = BUSINESS.BUSINESS_ID
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."WEATHER_TEMPERATURE" AS TEMP
     ON CAST(REVIEW.TIMESTAMP AS DATE) = TO_DATE(TEMP.DATE, 'YYYYMMDD')
LEFT JOIN "UDACITY_FINAL_PROJECT"."STAGING_SCHEMA"."WEATHER_PRECIPITATION" AS PREC
     ON CAST(REVIEW.TIMESTAMP AS DATE) = TO_DATE(PREC.DATE, 'YYYYMMDD')
GROUP BY BUSINESS.NAME, REVIEW.TIMESTAMP, REVIEW.STARS, TEMP.MIN, TEMP.MAX, PREC.PRECIPITATION, COVID.HIGHLIGHTS
ORDER BY 10 DESC;