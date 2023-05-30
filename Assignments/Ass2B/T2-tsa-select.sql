--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-tsa-select.sql

--Student ID:
--Student Name:
--Unit Code:
--Applied Class No:

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT town_id, town_name, poi_type_id, poi_type_descr, count(poi_type_id) as poi_count 
    FROM tsa.town natural join tsa.point_of_interest natural join tsa.poi_type
    GROUP BY town_id, town_name, poi_type_id, poi_type_descr
    ORDER BY town_id, poi_type_descr;
    
/*2(b)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
 
SELECT  m1.member_id, 
        m1.member_gname || ' ' || m1.member_fname as member_name,
        r1.resort_id,
        r1.resort_name, 
        COUNT(m2.member_id_recby) as number_of_recommendations
    FROM (tsa.member m1 JOIN tsa.resort r1 ON m1.resort_id = r1.resort_id) LEFT JOIN tsa.member m2 ON m1.member_id = m2.member_id_recby
    GROUP BY m1.member_id, m1.member_gname, m1.member_fname, r1.resort_id, r1.resort_name
    ORDER BY m1.member_id;


/*2(c)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer



/*2(d)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer


/*2(e)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer



/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

