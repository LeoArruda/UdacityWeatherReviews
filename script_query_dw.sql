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

SELECT fRev.date            AS Date, 
       dBus.name            AS "Business Name", 
	   AVG(fRev.stars)      AS "Average Stars", 
	   dWeath.temp_min      AS "Min Temperature", 
	   dWeath.temp_max      AS "Max Temperature", 
	   dWeath.precipitation AS "Precipitation", 
	   dWeath.precipitation_normal AS "Precipitation Normal"
FROM factReview             AS fRev
LEFT JOIN dimBusiness       AS dBus  
   ON fRev.business_id=dBus.business_id
LEFT JOIN dimWeather  AS dWeath 
   ON fRev.date=dWeath.date
WHERE dBus.location_city='Austin' 
AND dBus.location_state='TX'
GROUP BY fRev.date, dBus.name, dWeath.temp_min, dWeath.temp_max, dWeath.precipitation, dWeath.precipitation_normal
ORDER BY fRev.date DESC;