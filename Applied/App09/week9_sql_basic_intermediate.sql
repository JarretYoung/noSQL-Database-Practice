/*
Databases Week 9 Tutorial Class
week9_sql_basic_intermediate.sql

student id: 
student name:
applied class number:
last modified date:

*/

/* Part A - Retrieving data from a single table */

-- A1
SELECT stuid,stufname, stulname, to_char(studob) AS studob, stuaddress, stuphone, stuemail 
    FROM UNI.STUDENT 
    WHERE upper(stuaddress) LIKE upper('%Caulfield')
    ORDER BY stuid;

-- A2
SELECT * 
    FROM UNI.UNIT
    WHERE unitcode LIKE 'FIT1___';

-- A3
SELECT stuid, stulname, stufname, stuaddress
    FROM UNI.STUDENT
    WHERE UPPER(stulname) like UPPER('S%') AND UPPER(stufname) LIKE UPPER('%i%');
SELECT * FROM UNI.STUDENT;

-- A4


-- A5
SELECT to_char(ofyear,'yyyy') as offeryear, ofsemester, unitcode 
    FROM UNI.OFFERING JOIN UNI.UNIT USING (unitcode)
    WHERE ofsemester = 2 AND (to_char(ofyear,'yyyy') = 2019 OR to_char(ofyear,'yyyy') = 2020)
    ORDER BY offeryear, ofsemester, unitcode;


-- A6
SELECT stuid, unitcode, enrolmark
    FROM (UNI.STUDENT JOIN UNI.ENROLMENT USING (stuid)) JOIN UNI.OFFERING USING (unitcode, ofsemester, ofyear)
    WHERE UPPER(enrolgrade) = 'N' AND to_char(ofyear,'yyyy') = 2021 AND ofsemester = 2
    ORDER BY stuid, unitcode;   
    



/* Part B - Retrieving data from multiple tables */

-- B1
--SELECT *
--    FROM UNI.ENROLMENT join UNI.STUDENT
--    ON UNI.ENROLMENT.stuid = UNI.STUDENT.stuid;
--
--SELECT * 
--    FROM UNI.ENROLMENT e JOIN UNI.STUDENT s
--    ON e.stuid = s.stuid;
--    
--SELECT *    
--    FROM 

SELECT unitcode, ofsemester, stafffname || ' ' || stafflname as "cheif_examiner"
    FROM (UNI.STAFF JOIN UNI.OFFERING USING (staffid))JOIN UNI.UNIT USING (unitcode) 
    WHERE to_char(ofyear, 'yyyy') = 2021
    ORDER BY ofsemester, unitcode;
-- the JOIN UNI.UNIT USING (unitcode) is excessive    

-- B2


-- B3


-- B4
SELECT unitcode, unitname, ofsemester, to_char(ofyear, 'yyyy') as offyear, NVL(to_char(enrolmark, '990'),'N/A' ) as enrolmark, NVL(enrolgrade, 'N/A') as enrolgrade
    FROM ((UNI.STUDENT JOIN UNI.ENROLMENT USING (stuid)) JOIN UNI.OFFERING USING (unitcode, ofsemester, ofyear)) JOIN UNI.UNIT USING(unitcode)
    WHERE UPPER(stufname) =  UPPER('Brier') AND UPPER(stulname) = UPPER('Kilgour')  
    ORDER BY offyear, ofsemester, unitcode;

-- B5
SELECT * FROM UNI.ENROLMENT;

SELECT unitcode, unitname
    FROM UNI.UNIT
    WHERE;

-- B6


-- B7


-- B8



/* Part C - Aggregate Function, Group By and Having */

-- C1
SELECT to_char(round(AVG(enrolmark),2), '99.99') as avgenrolmark, to_char(ofyear, 'yyyy') as offeryear, ofsemester
    FROM UNI.ENROLMENT JOIN UNI.OFFERING USING (unitcode, ofsemester, ofyear)
    WHERE UPPER(unitcode) = UPPER('FIT9136')
    GROUP BY ofyear, ofsemester
    ORDER BY offeryear, ofsemester;

-- C2


-- C3
SELECT * FROM UNI.PREREQ;
SELECT unitcode, prerequisiteunitcode
    FROM UNI.UNIT JOIN UNI.PREREQ;
    

-- C4


-- C5


-- C6


-- C7

