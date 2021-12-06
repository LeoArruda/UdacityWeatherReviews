/*
==========================================================================================================
 Use database and schema
==========================================================================================================
 */

USE DATABASE "UDACITY_FINAL_PROJECT";

USE SCHEMA "UDACITY_FINAL_PROJECT"."DW_SCHEMA";

/*
==========================================================================================================
 SQL queries code that reports the business name, temperature, precipitation, and ratings.
==========================================================================================================
*/
USE DATABASE "UDACITY_FINAL_PROJECT";

USE SCHEMA "UDACITY_FINAL_PROJECT"."DW_SCHEMA";

SELECT fRev.date           AS Date, 
       dBus.name           AS "Business Name", 
	   AVG(fRev.stars)     AS "Average Stars", 
	   dTemp.temp_min      AS "Min Temperature", 
	   dTemp.temp_max      AS "Max Temperature", 
	   dPrec.precipitation AS "Precipitation", 
	   dPrec.precipitation_normal AS "Precipitation Normal"
FROM factReview             AS fRev
LEFT JOIN dimBusiness       AS dBus  
   ON fRev.business_id=dBus.business_id
LEFT JOIN dimTemperature    AS dTemp 
   ON fRev.date=dTemp.date
LEFT JOIN dimPrecipitation  AS dPrec 
   ON fRev.date=dPrec.date
WHERE dBus.location_city='Austin' 
AND dBus.location_state='TX'
GROUP BY fRev.date, dBus.name, dTemp.temp_min, dTemp.temp_max, dPrec.precipitation, dPrec.precipitation_normal
ORDER BY fRev.date DESC;