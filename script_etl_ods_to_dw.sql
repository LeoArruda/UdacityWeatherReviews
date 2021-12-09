/* 
==========================================================================================================
SQL-Script to load data into the tables for the DW Schema
==========================================================================================================


==========================================================================================================
 Use database and schema
==========================================================================================================
 */

USE DATABASE "UDACITY_FINAL_PROJECT";

USE SCHEMA "UDACITY_FINAL_PROJECT"."DW_SCHEMA";


/*
==========================================================================================================
 Truncate all DW tables before loading
==========================================================================================================
*/

TRUNCATE TABLE dimBusiness;
TRUNCATE TABLE dimDate;
TRUNCATE TABLE dimWeather;
TRUNCATE TABLE dimUser;
TRUNCATE TABLE factReview;



/* 
==========================================================================================================
Load Dimension table Date
==========================================================================================================
*/
INSERT INTO dimDate ( timestamp,date,day,month,year,week,quarter  )
SELECT
	dtime.timestamp,
    dtime.date,     
    dtime.day,      
    dtime.month,    
    dtime.year,     
	dtime.week,     
	dtime.quarter
FROM ODS_SCHEMA.date_time AS dtime;


/*
==========================================================================================================
Load Dimension table Weather 
==========================================================================================================
*/
INSERT INTO dimWeather ( date,temp_min,temp_max,temp_normal_min,temp_normal_max, precipitation, precipitation_normal )
SELECT temp.date,
       temp.temp_min,
       temp.temp_max,
       temp.temp_normal_min,
       temp.temp_normal_max,
       pre.precipitation,
       pre.precipitation_normal
FROM ODS_SCHEMA.precipitation as pre
INNER JOIN ODS_SCHEMA.temperature AS temp
ON pre.date = temp.date;

/* 
==========================================================================================================
Load Dimension table User 
==========================================================================================================
*/
INSERT INTO dimUser ( user_id,name,review_count,yelping_since,useful,funny,cool,elite,
    friends,fans,average_stars,compliment_hot,compliment_more,compliment_profile,compliment_cute,compliment_list,
    compliment_note,compliment_plain,compliment_cool,compliment_funny,compliment_writer,compliment_photos)
SELECT
	user.user_id,
    user.name,
    user.review_count,
    user.yelping_since,
    user.useful,
    user.funny,
    user.cool,
    user.elite,
    user.friends,
    user.fans,
    user.average_stars,
    user.compliment_hot,
    user.compliment_more,
    user.compliment_profile ,
    user.compliment_cute,
    user.compliment_list,
    user.compliment_note,
    user.compliment_plain,
    user.compliment_cool,
    user.compliment_funny,
    user.compliment_writer,
    user.compliment_photos
FROM ODS_SCHEMA.user as user;

/* 
==========================================================================================================
Load Dimension table business 
==========================================================================================================
*/
INSERT INTO dimBusiness ( business_id,name,stars,review_count,is_open,categories,location_address,location_city,
                        location_state,location_postal_code,location_latitude,location_longitude,checkin_date,
                        covid_highlights,covid_delivery_or_takeout,covid_grubhub_enabled,covid_call_to_action_enabled,
                        covid_request_a_quote_enabled,covid_covid_banner,covid_temporary_closed_until,covid_virtual_services_offered )
SELECT business.business_id,
       business.name,
       business.stars,
       business.review_count,
       business.is_open,
       business.categories,
       location.address,
       location.city,
       location.state,
       location.postal_code,
       location.latitude,
       location.longitude,
       checkin.timestamp,
       covid.highlights,
       covid.delivery_or_takeout,
       covid.grubhub_enabled,
       covid.call_to_action_enabled,
       covid.request_a_quote_enabled,
       covid.covid_banner,
       covid.temporary_closed_until,
       covid.virtual_services_offered
FROM ODS_SCHEMA.business        AS business
LEFT JOIN ODS_SCHEMA.location   AS location ON business.location_id=location.location_id
LEFT JOIN ODS_SCHEMA.checkin    AS checkin ON business.business_id=checkin.business_id
LEFT JOIN ODS_SCHEMA.covid      AS covid ON business.business_id=covid.business_id;


/* 
==========================================================================================================
Load Fact table Review 
==========================================================================================================
*/

INSERT INTO factReview (review_id, user_id, business_id, stars, useful, funny, cool, text, timestamp, date)
SELECT  review.review_id,
        review.user_id,
        review.business_id,
        review.stars,
        review.useful,
        review.funny,
        review.cool,
        review.text,
        review.timestamp,
        dtime.date
FROM ODS_SCHEMA.review AS review
LEFT JOIN ODS_SCHEMA.date_time AS dtime ON review.timestamp=dtime.timestamp;