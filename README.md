# Udacity Weather Reviews - Project




## Requirements:
- Downloading the Data
In this project, you will merge two massive, real-world datasets in order to draw conclusions about how weather affects Yelp reviews.

The first step is to obtain the data we will use for the project.

Make sure you have around 10 GB free disk space.

- YELP DATA
Navigate to the Yelp Dataset, then enter your details and click Download

On this page download 2 files “Download JSON” and “COVID-19 Data”

- CLIMATE DATA

Go to [Climate Explorer](https://crt-climate-explorer.nemac.org/) in order to download 2 csv files.

Enter any city or zip code. (note not all cities are included, please use one of the cities listed here)


---

## Deliverables

1. Data Architecture Diagram - Link: [Diagram](./screenshots/Udacity-Data_Architecture_Diagram.PNG)
2. Screenshot of 6 tables created upon upload of YELP data - Link: [Yelp Data](./screenshots/s1-Yelp-data.PNG)
3. Screenshot of 2 tables created upon upload of climate data - Link: [Climate Data](./screenshots/s2-Climate-data.PNG)
4. Scripts to load files to Staging.
   1. Staging weather precipitation - Link: [Staging Precipitation](./script_staging_weather_precipitation.sql)
   2. Staging weather temperature - Link: [Staging Temperature](./script_staging_weather_temperature.sql)
   3. Staging yelp business - Link: [Staging yelp business](./script_staging_yelp_business.sql)
   4. Staging yelp checkin - Link: [Staging yelp checkin](./script_staging_yelp_checkin.sql)
   5. Staging yelp covid - Link: [Staging yelp covid](./script_staging_yelp_covid.sql)
   6. Staging yelp review - Link: [Staging yelp review](./script_staging_yelp_review.sql)
   7. Staging yelp tip - Link: [Staging yelp tip](./script_staging_yelp_tip.sql)
   8. Staging yelp user - Link: [Staging yelp user](./script_staging_yelp_user.sql)

4. SQL queries code that transform from staging  -> ODS  - Link: [ETL Staging to ODS](./script_etl_staging_to_ods.sql)

5. SQL queries code that use JSON functions to transform data from a single JSON structure of staging to multiple columns of ODS. - Link: [JSON Function](./screenshots/s5-query-JSON-functions.PNG)

6. Screenshot of table with three columns: raw files, staging, and ODS. (and sizes) -> Link: [Raw files, staging and ODS](./screenshots/s6-query-ODS-yelp-climate.PNG)

7. ER Diagram
    1. ODS Diagram - Link: [ODS Schema](./screenshots/Udacity-ODS_Schema.PNG)
  
8. SQL queries code to integrate climate and Yelp data - Link: [integrate climate and Yelp data](./screenshots/Udacity-ODS_Schema.PNG)

9. STAR schema
   1. DW  Star Schema - Link: [DW Schema](./screenshots/Udacity-DW_Schema.PNG)

10. SQL queries code necessary to move the data from ODS to DWH. -> Link: [ETL ODS to DW](./script_etl_ods_to_dw.sql)

11. SQL queries code that report business name, temperature, precipitation, and ratings. -> Link: [DW Query](./script_query_dw.sql)
