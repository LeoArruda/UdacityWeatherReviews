/*
==========================================================================================================

  SQL-Script to load the data from staging to ODS

==========================================================================================================
*/



/*
==========================================================================================================
Select/use database and schema 
==========================================================================================================
*/
USE DATABASE "UDACITY_FINAL_PROJECT";
USE SCHEMA "UDACITY_FINAL_PROJECT"."ODS_SCHEMA";

TRUNCATE business_hours;
TRUNCATE business_attributes;
TRUNCATE location;
TRUNCATE date_time;
TRUNCATE user;
TRUNCATE tip;
TRUNCATE checkin;
TRUNCATE covid;
TRUNCATE review;
TRUNCATE business;
TRUNCATE temperature;
TRUNCATE precipitation;

/*
==========================================================================================================
Loading location data from staging to ods
==========================================================================================================
*/
INSERT INTO location (address, city, state, postal_code, latitude, longitude)
SELECT ybusiness.address, ybusiness.city, ybusiness.state, ybusiness.postal_code, ybusiness.latitude, ybusiness.longitude
FROM STAGING_SCHEMA.yelp_business AS ybusiness
QUALIFY ROW_NUMBER() 
OVER (PARTITION BY ybusiness.state, ybusiness.postal_code, ybusiness.city, ybusiness.address ORDER BY ybusiness.state, ybusiness.postal_code, ybusiness.city, ybusiness.address) = 1;

/*
==========================================================================================================
Loading business data from staging to ods 
==========================================================================================================
*/
INSERT INTO business (business_id, name, location_id, stars, review_count, is_open, categories)
SELECT  ybusiness.business_id,
        ybusiness.name,
        lo.location_id,
        ybusiness.stars,
        ybusiness.review_count,
        ybusiness.is_open,
		ybusiness.categories
FROM STAGING_SCHEMA.yelp_business AS ybusiness
LEFT JOIN location AS lo
ON ybusiness.address = lo.address AND
ybusiness.city = lo.city AND
ybusiness.state = lo.state AND
ybusiness.postal_code = lo.postal_code
WHERE ybusiness.business_id NOT IN (SELECT business_id FROM business);

/*
==========================================================================================================
 Loading business_hours data from staging to ods
==========================================================================================================
*/
INSERT INTO business_hours (business_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday)
SELECT  ybusiness.business_id,
		ybusiness.hours_Monday,
		ybusiness.hours_Tuesday,
		ybusiness.hours_Wednesday,
		ybusiness.hours_Thursday,
		ybusiness.hours_Friday,
		ybusiness.hours_Saturday,
		ybusiness.hours_Sunday
FROM STAGING_SCHEMA.yelp_business AS ybusiness;

/*
==========================================================================================================
Loading business_attributes data from staging to ods 
==========================================================================================================
*/
INSERT INTO business_attributes (
		business_id,NoiseLevel,BikeParking,RestaurantsAttire,BusinessAcceptsCreditCards,BusinessParking,RestaurantsReservations,GoodForKids,RestaurantsTakeOut,Caters, 						
		WiFi,RestaurantsDelivery,HasTV,RestaurantsPriceRange2,Alcohol,Music,BusinessAcceptsBitcoin,GoodForDancing,DogsAllowed,BestNights,RestaurantsGoodForGroups,
		OutdoorSeating,HappyHour,RestaurantsTableService,GoodForMeal,WheelchairAccessible,Ambience,CoatCheck,DriveThru,Smoking,BYOB,Corkage )
SELECT 	ybusiness.business_id,
		ybusiness.attributes_NoiseLevel,
		ybusiness.attributes_BikeParking,
		ybusiness.attributes_RestaurantsAttire,
		ybusiness.attributes_BusinessAcceptsCreditCards,
		ybusiness.attributes_BusinessParking,
		ybusiness.attributes_RestaurantsReservations,
		ybusiness.attributes_GoodForKids,
		ybusiness.attributes_RestaurantsTakeOut,
		ybusiness.attributes_Caters,
		ybusiness.attributes_WiFi,
		ybusiness.attributes_RestaurantsDelivery,
		ybusiness.attributes_HasTV,
		ybusiness.attributes_RestaurantsPriceRange2,
		ybusiness.attributes_Alcohol,
		ybusiness.attributes_Music,
		ybusiness.attributes_BusinessAcceptsBitcoin,
		ybusiness.attributes_GoodForDancing,
		ybusiness.attributes_DogsAllowed,
		ybusiness.attributes_BestNights,
		ybusiness.attributes_RestaurantsGoodForGroups,
		ybusiness.attributes_OutdoorSeating,
		ybusiness.attributes_HappyHour,
		ybusiness.attributes_RestaurantsTableService,
		ybusiness.attributes_GoodForMeal,
		ybusiness.attributes_WheelchairAccessible,
		ybusiness.attributes_Ambience,
		ybusiness.attributes_CoatCheck,
		ybusiness.attributes_DriveThru,
		ybusiness.attributes_Smoking,
		ybusiness.attributes_BYOB,
		ybusiness.attributes_Corkage
FROM STAGING_SCHEMA.yelp_business AS ybusiness;

/*
==========================================================================================================
Loading timestamps - yelping_since - from user table to date_time table
==========================================================================================================
*/
INSERT INTO date_time (timestamp, date, day, month, year, week, quarter)
SELECT yuser.yelping_since,
       DATE(yuser.yelping_since),
       DAY(yuser.yelping_since),
       MONTH(yuser.yelping_since),
       YEAR(yuser.yelping_since),
	   WEEK(yuser.yelping_since),
	   QUARTER(yuser.yelping_since)
FROM STAGING_SCHEMA.yelp_user AS yuser
WHERE yuser.yelping_since NOT IN (SELECT timestamp FROM date_time);

/*
==========================================================================================================
Loading user data from staging to ods
==========================================================================================================
*/
INSERT INTO user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends,
                  fans, average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
                  compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
                  compliment_writer, compliment_photos)
       
SELECT yuser.user_id, yuser.name, yuser.review_count, yuser.yelping_since, yuser.useful, yuser.funny, yuser.cool, yuser.elite, yuser.friends,
       yuser.fans, yuser.average_stars, yuser.compliment_hot, yuser.compliment_more, yuser.compliment_profile, yuser.compliment_cute,
       yuser.compliment_list, yuser.compliment_note, yuser.compliment_plain, yuser.compliment_cool, yuser.compliment_funny,
       yuser.compliment_writer, yuser.compliment_photos
FROM STAGING_SCHEMA.yelp_user AS yuser
WHERE yuser.user_id NOT IN (SELECT user_id FROM user);

/*
==========================================================================================================
Loading timestamps - yelping_tip - from user table to date_time table
==========================================================================================================
*/
INSERT INTO date_time (timestamp, date, day, month, year, week, quarter)
SELECT ytip.timestamp,
       DATE(ytip.timestamp),
       DAY(ytip.timestamp),
       MONTH(ytip.timestamp),
       YEAR(ytip.timestamp),
	   WEEK(ytip.timestamp),
	   QUARTER(ytip.timestamp)
FROM STAGING_SCHEMA.yelp_tip AS ytip
WHERE ytip.timestamp NOT IN (SELECT timestamp FROM date_time);

/*
==========================================================================================================
Loading tips from staging.yelping_tip table to ods
==========================================================================================================
*/
INSERT INTO tip (user_id, business_id, text, timestamp, compliment_count)
SELECT ytip.user_id, ytip.business_id, ytip.text, ytip.timestamp, ytip.compliment_count
FROM STAGING_SCHEMA.yelp_tip AS ytip;

/*
==========================================================================================================
Loading checkin data from staging.yelping_checkin table to ods
==========================================================================================================
*/
INSERT INTO checkin (business_id, date)
SELECT ycheck.business_id, ycheck.date
FROM STAGING_SCHEMA.yelp_checkin AS ycheck;


/*
==========================================================================================================
Loading covid data from staging.yelping_covid table to ods
==========================================================================================================
*/
INSERT INTO covid (business_id, highlights, delivery_or_takeout, grubhub_enabled, call_to_action_enabled, 
				   request_a_quote_enabled, covid_banner, temporary_closed_until, virtual_services_offered)
SELECT ycovid.business_id, ycovid.highlights, ycovid.delivery_or_takeout, ycovid.grubhub_enabled, ycovid.call_to_action_enabled, 
	   ycovid.request_a_quote_enabled, ycovid.covid_banner, ycovid.temporary_closed_until, ycovid.virtual_services_offered
FROM STAGING_SCHEMA.yelp_covid AS ycovid;


/*
==========================================================================================================
Loading timestamps - yelping_review - from user table to date_time table
==========================================================================================================
*/
INSERT INTO date_time (timestamp, date, day, month, year, week, quarter)
SELECT yreview.timestamp,
       DATE(yreview.timestamp),
       DAY(yreview.timestamp),
       MONTH(yreview.timestamp),
       YEAR(yreview.timestamp),
	   WEEK(yreview.timestamp),
	   QUARTER(yreview.timestamp)
FROM STAGING_SCHEMA.yelp_review AS yreview
WHERE yreview.timestamp NOT IN (SELECT timestamp FROM date_time);


/*
==========================================================================================================
Loading review data from staging.yelping_review table to ods
==========================================================================================================
*/
INSERT INTO review (review_id, user_id, business_id, stars, useful, funny, cool, text, timestamp)
SELECT  yreview.review_id, yreview.user_id, yreview.business_id, yreview.stars, 
		yreview.useful, yreview.funny, yreview.cool, yreview.text, yreview.timestamp
FROM STAGING_SCHEMA.yelp_review AS yreview
WHERE yreview.review_id NOT IN (SELECT review_id FROM review);

/*
==========================================================================================================
Loading temperature data from staging.weather_temperature table to ods
==========================================================================================================
*/
INSERT INTO temperature (date, temp_min, temp_max, temp_normal_min, temp_normal_max)
SELECT wtemp.date, wtemp.min, wtemp.max, wtemp.normal_min, wtemp.normal_max
FROM STAGING_SCHEMA.weather_temperature AS wtemp;

/*
==========================================================================================================
Loading precipitation data from staging.weather_precipitation table to ods
==========================================================================================================
*/
INSERT INTO precipitation (date, precipitation, precipitation_normal)
SELECT wprec.date, TRY_CAST(wprec.precipitation AS FLOAT), wprec.precipitation_normal
FROM STAGING_SCHEMA.weather_precipitation AS wprec;