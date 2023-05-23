/*
Databases Week 11 Tutorial Class
week11_sql_adv.sql

student id: 
student name:
last modified date:
*/
--1
SELECT stuid , stulname || ' ' || stufname as "full name", to_char(studob, 'dd-Mon-yyyy') AS "date of birth"
    FROM UNI.STUDENT NATURAL JOIN UNI.ENROLMENT
    WHERE UPPER(unitcode) = 'FIT9132' AND studob = (SELECT MIN(studob) FROM UNI.STUDENT NATURAL JOIN UNI.ENROLMENT WHERE unitcode = 'FIT9132')
    ORDER BY stuid;


--2



--3



--4
SELECT unitcode, unitname, to_char(ofyear,'yyyy') as ofyear, ofsemester, enrolmark, 
CASE enrolgrade 
WHEN 'N' then 'Fail'
WHEN 'P' then 'Pass'
WHEN 'C' then 'Credit'
WHEN 'B' then 'BODOH'
WHEN 'D' then 'Distinction'
WHEN 'HD' then 'High Distinction'
END AS enrolment_grade
    FROM UNI.UNIT NATURAL JOIN UNI.ENROLMENT NATURAL JOIN UNI.STUDENT
    WHERE UPPER(stufname || ' ' || stulname) = UPPER('Claudette Serman')
    ORDER BY ofyear, ofsemester , unitcode;

--5



--6



--7
/* Using outer join */
SELECT unitcode, count(prerequnitcode) AS "number" 
    FROM UNI.UNIT NATURAL LEFT JOIN UNI.PREREQ
    GROUP BY unitcode HAVING count(prerequnitcode) = 0;


/* Using set operator MINUS */
SELECT unitcode, unitname FROM UNI.UNIT WHERE unitcode IN(
SELECT unitcode FROM UNI.UNIT
MINUS
SELECT unitcode FROM UNI.PREREQ);


/* Using subquery */
SELECT unitcode, unitname
    FROM uni.unit 
    WHERE unitcode NOT IN (SELECT unitcode FROM UNI.PREREQ);


--8
SELECT unitcode, ofsemester, count(stuid), lpad(to_char(NVL(AVG(enrolmark), '0.00'), '990.00'), 15, ' ') as avg_mark
    FROM UNI.ENROLMENT NATURAL RIGHT JOIN UNI.OFFERING
    WHERE to_char(ofyear, 'yyyy') = '2019'
    GROUP BY unitcode, ofsemester
    ORDER BY avg_mark, ofsemester, unitcode;


--9



--10



--11
SELECT staffid , stafffname || ' ' || stafflname as staffname, 'Lecturer' as type, count(clno) as no_of_classe, sum(clduration) as total_hours, 
lpad(to_char((sum(clduration) * 75.6), '$900.00'), 15, ' ') AS weekly_payment
    FROM UNI.STAFF NATURAL JOIN UNI.SCHEDCLASS
    WHERE cltype = 'L' AND ofsemester = 1 AND to_char(ofyear, 'yyyy') = 2020
    GROUP BY staffid, stafffname || ' ' || stafflname
UNION
SELECT staffid , stafffname || ' ' || stafflname as staffname, 'Tutorial' as type, count(clno) as no_of_classe, sum(clduration) as total_hours, 
lpad(to_char((sum(clduration) * 42.85), '$900.00'), 15, ' ') AS weekly_payment
    FROM UNI.STAFF NATURAL JOIN UNI.SCHEDCLASS
    WHERE cltype = 'T' AND ofsemester = 1 AND to_char(ofyear, 'yyyy') = 2020
    GROUP BY staffid, stafffname || ' ' || stafflname
ORDER BY staffid, type ;
    
--12


    
--13
SELECT stuid, stufname || ' ' || stulname as stu_name, lpad(to_char(AVG(enrolmark), '990.00'), 9, ' ')as WAM, 
to_char(AVG(CASE enrolgrade 
WHEN 'N' then 0.3
WHEN 'P' then 1.0
WHEN 'C' then 2.0
WHEN 'B' then 10.0
WHEN 'D' then 3.0
WHEN 'HD' then 4.0
END), '0.00') AS GPA
    FROM UNI.STUDENT NATURAL JOIN UNI.ENROLMENT 
    GROUP BY stuid, stufname || ' ' || stulname
    ORDER BY gpa desc, stuid;



