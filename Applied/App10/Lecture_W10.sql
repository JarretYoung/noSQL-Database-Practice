SELECT
    drone_id, dt_carry_kg,
    CASE
        WHEN dt_carry_kg = 0  THEN
            'No load'
        WHEN dt_carry_kg < 4  THEN
            'Light Loads'
        ELSE
            'Heavy Loads'
    END AS carryingcapacity,
    drone_cost_hr
FROM
         drone.drone_type
    NATURAL JOIN drone.drone
ORDER BY
    drone_id;
    
SELECT drone_id,
drone_flight_time
FROM drone.drone
WHERE drone_flight_time > 
    (
        SELECT AVG(drone_flight_time)
        FROM drone.drone
    )
ORDER BY drone_id;

--Write an SQL Query to find the details of all drones which have a purchase price 
--less than the average purchase price for all drones manufactured by DJI Da-Jiang Innovations. 
SELECT  drone_id, dt_code, drone_pur_price,
        to_char(drone_pur_date, 'yyyy') AS YearPurchased,
        manuf_name
FROM    drone.drone NATURAL JOIN
        drone.drone_type NATURAL JOIN
        drone.manufacturer
WHERE   drone_pur_price >
        (SELECT AVG(drone_pur_price)
        FROM drone.drone NATURAL JOIN
        drone.drone_type NATURAL JOIN
        drone.manufacturer
        WHERE UPPER(manuf_name) = 'DJI DA-JIANG INNOVATIONS'
        )
ORDER BY drone_id;

SELECT cust_id
    FROM 
    WHERE max(rent_out_dt - rent_in_dt)
    

-- Subquery - nested
SELECT  drone_id, 
        (rent_in_dt - rent_out_dt) AS MaxDaysOut,
        cust_id
FROM    drone.cust_train
        NATURAL JOIN drone.rental
WHERE
        rent_in_dt IS NOT NULL 
        AND
        (drone_id, (rent_in_dt - rent_out_dt))
        IN (
        SELECT drone_id, 
                MAX(rent_in_dt - rent_out_dt)
        FROM drone.rental
        WHERE rent_in_dt IS NOT NULL
        GROUP BY drone_id
        )
ORDER BY drone_id, cust_id;

-- Subquery - Correlated
SELECT  drone_id, 
        (rent_in_dt - rent_out_dt) AS MaxDaysOut,
        cust_id
FROM    drone.cust_train
        NATURAL JOIN drone.rental r1
WHERE
        rent_in_dt IS NOT NULL AND
        (rent_in_dt - rent_out_dt)
        = (
            SELECT MAX(rent_in_dt - rent_out_dt)
            FROM drone.rental r2
            WHERE rent_in_dt IS NOT NULL
            AND r1.drone_id = r2.drone_id
        )
ORDER BY drone_id, cust_id;

-- Subquery - Inline
SELECT  rental.drone_id, 
        (rent_in_dt - rent_out_dt) AS MaxDaysOut,
        cust_id
FROM (
        (SELECT drone_id, MAX(rent_in_dt - rent_out_dt) AS MaxOut
         FROM drone.rental
         WHERE rent_in_dt IS NOT NULL
         GROUP BY drone_id
        ) maxtable
        JOIN drone.rental
        ON maxtable.drone_id = rental.drone_id
        AND(rent_in_dt - rent_out_dt) = maxtable.MaxOut
    )
    JOIN drone.cust_train USING (ct_id)
ORDER BY drone_id, cust_id;

--Slide #15
--How many completed rentals have been recorded?
SELECT
	drone_id,
	COUNT(*) AS times_rented
FROM
	drone.rental
WHERE
	rent_in_dt IS NOT NULL
GROUP BY
	drone_id
ORDER BY
	drone_id;

--List for each drone the number of times the drone 
--has been rented in a completed rental
SELECT
	COUNT(*) AS totalrentals
FROM
	drone.rental
WHERE
	rent_in_dt IS NOT NULL;

-- Slide #16: Subquery - inline
SELECT
    drone_id,
    COUNT(*) AS times_rented,
    to_char(COUNT(*) * 100 /(
        SELECT
            COUNT(rent_in_dt)
        FROM
            drone.rental
    ), '990.99') AS percent_overall
FROM
    drone.rental
WHERE
    rent_in_dt IS NOT NULL
GROUP BY
    drone_id
ORDER BY
    percent_overall DESC;


drop drone_details purge;
CREATE TABLE drone_details (
    dd_id   NUMBER(5) NOT NULL,
    dd_purchasedate DATE NOT NULL,
    dd_model    VARCHAR2(50) NOT NULL,
    CONSTRAINT drone_Details_pk PRIMARY KEY (dd_id)
);

INSERT INTO drone_details
(SELECT  drone_id, drone_pur_date, dt_model
    FROM drone.drone
        NATURAL JOIN drone.drone_type
);

--SELECT * FROM drone_details;
CREATE TABLE drone_details AS
(SELECT  drone_id, drone_pur_date, dt_model
    FROM drone.drone
        NATURAL JOIN drone.drone_type
);
SELECT * FROM drone_details;


DROP TABLE employee;
CREATE TABLE employee
(emp_no number(3) NOT NULL PRIMARY KEY,
emp_fname   varchar2(20) NOT NULL
);

SELECT * FROM employee;

ALTER TABLE employee
ADD mgr_no NUMBER(3);

ALTER TABLE employee
ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr_no) REFERENCES employee (emp_no)
;

INSERT INTO employee (emp_no, emp_fname) VALUES (100,'Alice');
INSERT INTO employee (emp_no, emp_fname) VALUES (200,'Bob');
INSERT INTO employee (emp_no, emp_fname) VALUES (300,'Chris');
INSERT INTO employee (emp_no, emp_fname) VALUES (400,'David');
INSERT INTO employee (emp_no, emp_fname) VALUES (500,'Eddie');

UPDATE employee
SET mgr_no = 100
WHERE emp_no > 300;

UPDATE employee
SET mgr_no = 200
WHERE emp_no = 300;
SELECT e1.emp_no, e1.emp_fname, e2.emp_fname AS mgr_name
FROM employee e1 JOIN employee e2
ON e1.emp_no = e2.mgr_no;

SELECT e1.emp_no, e1.emp_fname, e2.emp_fname AS mgr_name
FROM employee e1 LEFT OUTER JOIN employee e2
ON e1.mgr_no = e2.emp_no;




SELECT drone_id, to_char(drone_pur_date, 'dd-Mon-yyyy') AS purchaseDate, drone_cost_hr
FROM drone.drone
WHERE drone_id IN
    (SELECT drone_id FROM drone.drone
        MINUS
        SELECT drone_id FROM drone.rental
    )
ORDER BY drone_id;



select lpad('Page 1', 15, '*') as "Lpad example"
from dual;
select rpad('Page 1', 15, '*') as "Rpad example"
from dual;
SELECT
    drone_id,
    COUNT(*) AS times_rented,
    lpad(ltrim(to_char(COUNT(*) * 100 /(
--    lpad((to_char(COUNT(*) * 100 /(
        SELECT
            COUNT(rent_in_dt)
        FROM
            drone.rental
    ), '990.99')),15,'*') AS percent_overall
FROM
    drone.rental
WHERE
    rent_in_dt IS NOT NULL
GROUP BY
    drone_id
ORDER BY
    percent_overall DESC;

