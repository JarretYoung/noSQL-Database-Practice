/*
FIT3171 Week 10 Tutorial Class
student_enrolment_schema_insert.sql

Create and populate unit,student and enrolment tables
Create audit_log table and sequence

Databases Units
Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.

*/

SET ECHO ON;

--creating tables

DROP TABLE audit_log CASCADE CONSTRAINTS;

DROP TABLE enrolment CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE unit CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE audit_log (
    audit_no        NUMBER(6) NOT NULL,
    audit_date      DATE NOT NULL,
    audit_user      VARCHAR2(30) NOT NULL,
    audit_stu_nbr   NUMBER(8) NOT NULL,
    audit_unit_code CHAR(7) NOT NULL
);

COMMENT ON COLUMN audit_log.audit_no IS
    'audit number (unique for each audit';

COMMENT ON COLUMN audit_log.audit_date IS
    'Audit date';

COMMENT ON COLUMN audit_log.audit_user IS
    'Audit oracle user';

COMMENT ON COLUMN audit_log.audit_stu_nbr IS
    'Student number that is deleted';

COMMENT ON COLUMN audit_log.audit_unit_code IS
    'Deleted unit code';

ALTER TABLE audit_log ADD CONSTRAINT audit_log_pk PRIMARY KEY ( audit_no );

CREATE TABLE enrolment (
    stu_nbr        NUMBER(8) NOT NULL,
    unit_code      CHAR(7) NOT NULL,
    enrol_year     NUMBER(4) NOT NULL,
    enrol_semester CHAR(1) NOT NULL,
    enrol_mark     NUMBER(3),
    enrol_grade    CHAR(2)
);

COMMENT ON COLUMN enrolment.stu_nbr IS
    'Student number';

COMMENT ON COLUMN enrolment.unit_code IS
    'Unit code';

COMMENT ON COLUMN enrolment.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN enrolment.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN enrolment.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN enrolment.enrol_grade IS
    'Enrolment grade (letter)';

ALTER TABLE enrolment
    ADD CONSTRAINT enrolment_pk PRIMARY KEY ( stu_nbr,
                                              enrol_year,
                                              enrol_semester,
                                              unit_code );

CREATE TABLE student (
    stu_nbr      NUMBER(8) NOT NULL,
    stu_lname    VARCHAR2(50),
    stu_fname    VARCHAR2(50),
    stu_dob      DATE NOT NULL,
    stu_avg_mark NUMBER(5, 2)
);

COMMENT ON COLUMN student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN student.stu_lname IS
    'Student last name';

COMMENT ON COLUMN student.stu_fname IS
    'Student first name';

COMMENT ON COLUMN student.stu_dob IS
    'Student date of birth';

COMMENT ON COLUMN student.stu_avg_mark IS
    'Student''s average mark';

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( stu_nbr );

CREATE TABLE unit (
    unit_code       CHAR(7) NOT NULL,
    unit_name       VARCHAR2(50) NOT NULL,
    unit_no_student NUMBER(4) NOT NULL
);

COMMENT ON COLUMN unit.unit_code IS
    'Unit code';

COMMENT ON COLUMN unit.unit_name IS
    'Unit name';

COMMENT ON COLUMN unit.unit_no_student IS
    'Number of students enroled in the unit';

ALTER TABLE unit ADD CONSTRAINT unit_pk PRIMARY KEY ( unit_code );

ALTER TABLE unit ADD CONSTRAINT unit_nk UNIQUE ( unit_name );

ALTER TABLE enrolment
    ADD CONSTRAINT student_enrolment FOREIGN KEY ( stu_nbr )
        REFERENCES student ( stu_nbr );

ALTER TABLE enrolment
    ADD CONSTRAINT unit_enrolment FOREIGN KEY ( unit_code )
        REFERENCES unit ( unit_code );
        
--Creating sequence for AUDIT_LOG table
drop sequence audit_seq;
create sequence audit_seq start with 1 increment by 1;

--Inserting data
insert into STUDENT values (11111121,'Bloggs','Fred',to_date('01-FEB-91','DD-MON-YY'),46);
insert into STUDENT values (11111122,'Nice',null,to_date('15-SEP-92','DD-MON-YY'),66);
insert into STUDENT values (11111123,'Wheat','Wendy',to_date('23-OCT-89','DD-MON-YY'),75);
insert into STUDENT values (11111124,'Sheen','Cindy',to_date('12-MAR-89','DD-MON-YY'),75.5);
insert into STUDENT values (11111125,null,'Andrew',to_date('11-AUG-90','DD-MON-YY'),64.25);


insert into UNIT values ('FIT9131','Programming foundations',5);
insert into UNIT values ('FIT9132','Introduction to databases',5);
insert into UNIT values ('FIT9134','Computer architecture and operating systems',5); 
insert into UNIT values ('FIT9135','Data communications',5);
insert into UNIT values ('FIT5057','Project management',5);

insert into ENROLMENT values ('11111121','FIT9131',2020,'1',35,'N ');
insert into ENROLMENT values ('11111122','FIT9131',2020,'1',62,'C ');
insert into ENROLMENT values ('11111123','FIT9131',2020,'1',76,'D ');
insert into ENROLMENT values ('11111124','FIT9131',2020,'1',85,'HD');
insert into ENROLMENT values ('11111125','FIT9131',2020,'1',64,'C ');

insert into ENROLMENT values ('11111121','FIT9132',2020,'1',55,'P ');
insert into ENROLMENT values ('11111122','FIT9132',2020,'1',67,'C ');
insert into ENROLMENT values ('11111123','FIT9132',2020,'1',62,'C ');
insert into ENROLMENT values ('11111124','FIT9132',2020,'1',45,'N ');
insert into ENROLMENT values ('11111125','FIT9132',2020,'1',55,'P ');

insert into ENROLMENT values ('11111121','FIT9135',2020,'2',46,'N ');
insert into ENROLMENT values ('11111122','FIT9135',2020,'2',70,'D ');
insert into ENROLMENT values ('11111123','FIT9135',2020,'2',83,'HD');
insert into ENROLMENT values ('11111124','FIT9135',2020,'2',92,'HD');
insert into ENROLMENT values ('11111125','FIT9135',2020,'2',66,'C ');

insert into ENROLMENT values ('11111121','FIT9134',2020,'2',48,'N ');
insert into ENROLMENT values ('11111122','FIT9134',2020,'2',65,'C ');
insert into ENROLMENT values ('11111123','FIT9134',2020,'2',79,'D ');
insert into ENROLMENT values ('11111124','FIT9134',2020,'2',80,'HD');
insert into ENROLMENT values ('11111125','FIT9134',2020,'2',72,'D ');


insert into ENROLMENT values ('11111121','FIT5057',2021,'1',null,null);
insert into ENROLMENT values ('11111122','FIT5057',2021,'1',null,null);
insert into ENROLMENT values ('11111123','FIT5057',2021,'1',null,null);
insert into ENROLMENT values ('11111124','FIT5057',2021,'1',null,null);
insert into ENROLMENT values ('11111125','FIT5057',2021,'1',null,null);

commit;
SET ECHO OFF;