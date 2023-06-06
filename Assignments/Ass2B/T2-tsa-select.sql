--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-tsa-select.sql

--Student ID:       318626166
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT town_id, town_name, poi_type_id, poi_type_descr, count(poi_type_id) as poi_count 
    FROM tsa.town natural join tsa.point_of_interest natural join tsa.poi_type
    GROUP BY town_id, town_name, poi_type_id, poi_type_descr
    HAVING  count(poi_type_id) > 1
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
FROM
    (tsa.member m1
    JOIN tsa.resort r1 ON m1.resort_id = r1.resort_id)
    LEFT JOIN tsa.member m2 ON m1.member_id = m2.member_id_recby
GROUP BY
    m1.member_id, m1.member_gname, m1.member_fname, r1.resort_id, r1.resort_name
HAVING
    COUNT(m2.member_id_recby) = (
        SELECT MAX(COUNT(m2.member_id_recby))
        FROM (tsa.member m1
            JOIN tsa.resort r1 ON m1.resort_id = r1.resort_id)
            LEFT JOIN tsa.member m2 ON m1.member_id = m2.member_id_recby
        GROUP BY m1.member_id, m1.member_gname, m1.member_fname, r1.resort_id, r1.resort_name
    )
ORDER BY
    r1.resort_id, m1.member_id;   
/*2(c)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT  poi1.poi_id,
        poi1.poi_name,
        NVL(to_char(MAX(r1.review_rating)), 'NR') AS max_rating,
        NVL(to_char(MIN(r1.review_rating)), 'NR') AS min_rating,
        NVL(to_char(AVG(r1.review_rating), '99.9'), 'NR') AS avg_rating
    FROM tsa.point_of_interest poi1 LEFT JOIN tsa.review r1 ON poi1.poi_id = r1.poi_id
    GROUP BY poi1.poi_id, poi1.poi_name    
    ORDER BY poi1.poi_id;

/*2(d)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer   
SELECT  poi.poi_name,
        pt.poi_type_descr,
        town.town_name,
        LPAD('Lat: ' || to_char(town.town_lat,'999.000000') || ' Long: ' || to_char(town.town_long,'999.000000'),35,' ') as town_location,
        NVL(COUNT(r.review_id), 0) AS review_count,
        CASE 
            WHEN to_char(round(COUNT(r.review_id) * 100 / (SELECT COUNT(*) FROM tsa.review), 2),'90.00') = 0 THEN 'No reviews completed'
            ELSE to_char(round(COUNT(r.review_id) * 100 / (SELECT COUNT(*) FROM tsa.review), 2),'90.00') || '%'
        END AS review_percentage
    FROM tsa.point_of_interest poi JOIN tsa.poi_type pt ON poi.poi_type_id = pt.poi_type_id
        JOIN tsa.town ON poi.town_id = town.town_id
        LEFT JOIN tsa.review r ON poi.poi_id = r.poi_id
    GROUP BY poi.poi_id, poi.poi_name, pt.poi_type_descr, town.town_name, town.town_lat, town.town_long
    ORDER BY town.town_name, review_count DESC, poi.poi_name;    
    
/*2(e)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT  r1.resort_id, 
        r1.resort_name, 
        m1.member_no, 
        m1.member_gname || ' ' || m1.member_fname as member_name, 
        m1.member_date_joined, 
        m2.member_no || ' ' || m2.member_gname || ' ' || m2.member_fname as recommended_by_details, 
        LPAD('$' || to_char(round(SUM(CASE WHEN mc1.mc_paid_date IS NULL THEN 0 ELSE mc1.mc_total END))), 13, ' ') as total_charges
    FROM tsa.member m1 
        JOIN tsa.resort r1 ON m1.resort_id = r1.resort_id
        JOIN tsa.member_charge mc1 ON m1.member_id = mc1.member_id
        JOIN tsa.member m2 ON m1.member_id_recby = m2.member_id
        JOIN tsa.town t1 ON r1.town_id = t1.town_id
    WHERE (NOT (UPPER(t1.town_name) = UPPER('Byron Bay') AND UPPER(t1.town_state) = UPPER('NSW') ))
    HAVING SUM(mc1.mc_total) < (SELECT AVG(sum(mc.mc_total))
                                    FROM tsa.member_charge mc  
                                    JOIN tsa.member m ON m.member_id = mc.member_id 
                                    WHERE m.resort_id = r1.resort_id
                                    GROUP BY m.member_id)
    GROUP BY m1.member_id, m1.member_gname, m1.member_fname, m1.member_no, m1.member_date_joined, m2.member_no, m2.member_gname, m2.member_fname, m2.member_no, r1.resort_id, r1.resort_name
    ORDER BY r1.resort_id, m1.member_no; 
        

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
  
SELECT  r1.resort_id,    
        r1.resort_name, 
        poi1.poi_name, 
        t2.town_name, 
        t2.town_state, 
        NVL(to_char(poi1.poi_open_time, 'HH12:MI AM'), 'Not Applicable') as poi_opening_time,
        to_char(geodistance(t1.town_lat, t1.town_long, t2.town_lat, t2.town_long),'90.0') || ' Kms' AS distance
  FROM tsa.resort r1
    JOIN tsa.town t1 ON r1.town_id = t1.town_id
    JOIN tsa.town t2 ON geodistance(t1.town_lat, t1.town_long, t2.town_lat, t2.town_long) <= 100
    JOIN tsa.point_of_interest poi1 ON t2.town_id = poi1.town_id
  ORDER BY r1.resort_name, geodistance(t1.town_lat, t1.town_long, t2.town_lat, t2.town_long);
    
    
    
    