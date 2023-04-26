/*
Databases Week 8 Tutorial
week8_dml.sql

student id: 
student name:
last modified date:

*/

---==8.2.1 INSERT==--
/*1. Write SQL INSERT statements to add the data into the specified tables */
insert into STUDENT values (11111111,'Bloggs','Fred',to_date('1-Jan-2003', 'dd-Mon-yyyy'));

insert into UNIT values ('FIT9132','Introduction to Databases');

insert into ENROLMENT values (11111111,'FIT9132',2022,1,35,'N');

commit; /* commit once at the end of all insert only*/
---==8.2.2 INSERT using SEQUENCEs ==--
/*1. Create a sequence for the STUDENT table called STUDENT_SEQ because it is mandatory [depends on cardinality] */
drop sequence STUDENT_SEQ;
create sequence STUDENT_SEQ start with 11111115 increment by 1; /* don't commit, don't comment*/

/*2. Add a new student (MICKEY MOUSE) and an enrolment for this student as listed below, 
treat all the data that you add as a single transaction. */
/*Under normal circumstances (ignore line above), there would require 2 commits*/
insert into STUDENT values((STUDENT_SEQ.nextval), 'Mouse', 'Mickey', to_date( '1-Jan-2003', 'dd-Mon-yyyy'));

insert into ENROLMENT values((STUDENT_SEQ.currval), 'FIT9132', 2023, 1, null, null);

commit;
---==8.2.3 Advanced INSERT==--
/*1. A new student has started a course. Subsequently this new student needs to enrol into 
Introduction to databases. Enter the new student's details, then insert his/her enrollment 
to the database using the sequence in combination with a SELECT statement. You can 
make up details of the new student and when they will attempt Introduction to databases 
and you may assume there is only one student with such a name in the system.

You must not do a manual lookup to find the unit code of the Introduction to Databases 
and the student number.
 */
insert into STUDENT values((STUDENT_SEQ.nextval), 'Mouse', 'Minnie', to_date( '1-Jan-2003', 'dd-Mon-yyyy'));
commit;
 
insert into ENROLMENT values((SELECT stu_nbr FROM STUDENT WHERE UPPER(stu_lname) = UPPER('Mouse') AND UPPER(stu_fname) = UPPER('Minnie')), (SELECT unit_code FROM UNIT WHERE UPPER(unit_name) = UPPER('Introduction to databases')), 2023, 1, null, null);
commit;

select * FROM STUDENT;
select * FROM ENROLMENT;

---==8.2.4 Creating a table and inserting data as a single SQL statement==--
/*1. Create a table called FIT5111_STUDENT. The table should contain all enrolments for the 
unit FIT5111 */
DROP TABLE FIT9132_STUDENT CASCADE CONSTRAINTS PURGE;
create TABLE FIT9132_STUDENT as (SELECT * FROM ENROLMENT WHERE UPPER(unit_code) = UPPER('FIT9132'));

COMMENT ON COLUMN FIT9132_STUDENT.stu_nbr IS
    'Student number';

COMMENT ON COLUMN FIT9132_STUDENT.unit_code IS
    'Unit code';

COMMENT ON COLUMN FIT9132_STUDENT.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN FIT9132_STUDENT.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN FIT9132_STUDENT.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN FIT9132_STUDENT.enrol_grade IS
    'Enrolment grade (letter)';
/*Don't commit and pls comment*/

/*2. Check the table exists */
select * FROM cat;
-- or
select * from user_sequences;
select * from user_tables;

/*3. List the contents of the table */
select * from FIT9132_STUDENT;

---==8.2.5 UPDATE==--
/*1. Update the unit name of FIT9999 from 'FIT Last Unit' to 'place holder unit'.*/
SELECT * FROM UNIT;
UPDATE UNIT SET unit_name = 'place holder unit' where upper(unit_code) = UPPER('FIT9999');
commit;

/*2. Enter the mark and grade for the student with the student number of 11111113 
for Introduction to Databases that the student enrolled in semester 1 of 2023. 
The mark is 75 and the grade is D.*/
UPDATE ENROLMENT SET enrol_mark = 75, enrol_grade = 'D' WHERE stu_nbr = 11111113 and unit_code = (SELECT unit_code FROM UNIT WHERE Upper(unit_name) = UPPER('Introduction to Databases')) and enrol_year = 2023 and enrol_semester = 1;
commit;

/*3. The university introduced a new grade classification scale. 
The new classification are:
0 - 44 is N
45 - 54 is P1
55 - 64 is P2
65 - 74 is C
75 - 84 is D
85 - 100 is HD
Change the database to reflect the new grade classification scale.
*/
UPDATE ENROLMENT SET enrol_grade = 'N' WHERE enrol_mark between 0 and 44;
UPDATE ENROLMENT SET enrol_grade = 'P1' WHERE enrol_mark between 45 and 54;
UPDATE ENROLMENT SET enrol_grade = 'P2' WHERE enrol_mark between 55 and 64;
UPDATE ENROLMENT SET enrol_grade = 'C' WHERE enrol_mark between 65 and 74;
UPDATE ENROLMENT SET enrol_grade = 'D' WHERE enrol_mark between 75 and 84;
UPDATE ENROLMENT SET enrol_grade = 'HD' WHERE enrol_mark between 85 and 100;
commit;

/*4. Due to the new regulation, the Faculty of IT decided to change 'Project' unit code 
from FIT9161 into FIT5161. Change the database to reflect this situation.
Note: you need to disable the FK constraint before you do the modification 
then enable the FK to have it active again.
*/
ALTER TABLE ENROLMENT DISABLE CONSTRAINT unit_enrolment_fk;
UPDATE UNIT SET unit_code = '5161' WHERE UPPER(unit_code) = UPPER('9161');
UPDATE ENROLMENT SET unit_code = '5161' WHERE UPPER(unit_code) = UPPER('9161');
commit;
ALTER TABLE ENROLMENT ENABLE CONSTRAINT unit_enrolment_fk;

--==8.2.6 DELETE==--
/*1. A student with student number 11111114 has taken intermission in semester 1 2023, 
hence all the enrolment of this student for semester 1 2023 should be removed. 
Change the database to reflect this situation.*/
DELETE FROM ENROLMENT WHERE stu_nbr = 11111114 AND enrol_semester = 1 AND enrol_year=2023;
commit;

/*2. The faculty decided to remove all Student's Life unit's enrolments. 
Change the database to reflect this situation.
Note: unit names are unique in the database.*/
DELETE FROM ENROLMENT WHERE unit_code = (SELECT unit_code from unit where UPPER(unit_name) = UPPER('Student''s Life'));
commit;

/*3. Assume that Wendy Wheat (student number 11111113) has withdrawn from the university. 
Remove her details from the database.*/
DELETE FROM ENROLMENT WHERE stu_nbr = 11111113;
DELETE FROM STIDENT WHERE stu_nbr = 11111113;
commit;

--Testing only
ALTER TABLE ENROLMENT DROP CONSTRAINT student_enrolment_fk;
ALTER TABLE ENROLMENT ADD CONSTRAINT student_enrolment_fk FOREIGN KEY (stu_nbr) REFERENCES STUDENT (stu_nbr) ON DELETE CASCADE;
DELETE FROM STIDENT WHERE stu_nbr = 11111113;