--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-tsa-json.sql

--Student ID:       31862616
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:

Uses the assumption based on the brief that the objects have to be generated
while wrapped with an array as shown in the image

*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SET PAGESIZE 200


SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
        '_id' VALUE town.town_id,
        'name' VALUE town.town_name || ', ' || town.town_state,
        'location' VALUE JSON_OBJECT(
            'latitude' VALUE town.town_lat, 
            'longitude' VALUE town.town_long
        ),
        'avg_temperature' VALUE JSON_OBJECT(
            'summer' VALUE town.town_avg_summer_temp, 
            'winter' VALUE town.town_avg_winter_temp
        ),
        'no_of_resorts' VALUE COUNT(resort.resort_id),
        'resorts' VALUE JSON_ARRAYAGG(
            JSON_OBJECT(
                'id' VALUE resort.resort_id,
                'name' VALUE resort.resort_name,
                'address' VALUE resort.resort_street_address,
                'phone' VALUE resort.resort_phone,
                'year_built' VALUE to_char(resort.resort_yr_built_purch, 'yyyy'),
                'company_name' VALUE company.company_name
            )   
        )
    ) FORMAT JSON
)
    FROM tsa.town
        JOIN tsa.resort ON town.town_id = resort.town_id
        JOIN tsa.company ON resort.company_abn = company.company_abn
    GROUP BY town.town_id, town.town_name, town.town_state, town.town_lat, town.town_long, town.town_avg_summer_temp, town.town_avg_winter_temp
    HAVING COUNT(resort.resort_id) > 0;
    

