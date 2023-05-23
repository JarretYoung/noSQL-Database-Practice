--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-alter.sql

--Student ID:       31862616
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:




*/

--4(a)
DESC CABIN;
ALTER TABLE CABIN
    ADD cabin_booked_quantity NUMBER(4) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN cabin.cabin_booked_quantity IS
    'Number of times that the cabin has been booked';
DESC CABIN;    

SELECT * FROM CABIN;    
UPDATE CABIN 
    SET cabin_booked_quantity = (SELECT COUNT(*) FROM BOOKING WHERE BOOKING.cabin_no = CABIN.cabin_no AND BOOKING.resort_id = CABIN.resort_id);
SELECT * FROM CABIN;

--4(b)
DROP TABLE role CASCADE CONSTRAINTS PURGE; 

CREATE TABLE ROLE (
    role_id                     CHAR(1) NOT NULL,
    role_name                   VARCHAR(150) NOT NULL,
    job_description             VARCHAR(300) NOT NULL
);

COMMENT ON COLUMN role.role_id IS
    'Role identifier';

COMMENT ON COLUMN role.role_name IS
    'Name of the role';

COMMENT ON COLUMN role.job_description IS
    'Description of the job/ role';
    
ALTER TABLE role ADD CONSTRAINT role_pk PRIMARY KEY ( role_id );

DESC ROLE;

INSERT INTO ROLE values ('A','Admin','Take bookings, and reply to customer inquiries');
INSERT INTO ROLE values ('C','Cleaning','Clean cabins and maintain resort''s public area');
INSERT INTO ROLE values ('M','Marketing','Prepare and present marketing ideas and deliverables');
commit;
SELECT*FROM ROLE;

DESC STAFF;
SELECT * FROM STAFF;
ALTER TABLE STAFF
    ADD role_id CHAR(1) DEFAULT 'A' NOT NULL;
COMMENT ON COLUMN staff.role_id IS
    'Role identifier';    
DESC STAFF;   
SELECT * FROM STAFF;

ALTER TABLE booking 
    ADD FOREIGN KEY ( role_id ) 
    REFERENCES cabin( role_id );
        
--4(c)
DROP TABLE CABIN_CLEANING_TASK CASCADE CONSTRAINTS PURGE; 
DROP TABLE CABIN_CLEANING_STAFF CASCADE CONSTRAINTS PURGE; 

CREATE TABLE CABIN_CLEANING_TASK (
    resort_id                   NUMBER(4) NOT NULL,
    cabin_no                    NUMBER(3) NOT NULL,
    cct_date               DATE NOT NULL
);

COMMENT ON COLUMN cabin_cleaning_task.resort_id IS
    'Resort identifier';

COMMENT ON COLUMN cabin_cleaning_task.cabin_no IS
    'Cabin number within the resort';
    
COMMENT ON COLUMN cabin_cleaning_task.cct_date IS
    'Date that the cabin is scheduled for cleaning';

ALTER TABLE cabin_cleaning_task ADD CONSTRAINT cct_pk PRIMARY KEY ( resort_id, cabin_no, cct_date );

ALTER TABLE cabin_cleaning_task 
    ADD FOREIGN KEY (resort_id, cabin_no) 
    REFERENCES cabin(resort_id , cabin_no);

CREATE TABLE CABIN_CLEANING_STAFF (
    resort_id                   NUMBER(4) NOT NULL,
    cabin_no                    NUMBER(3) NOT NULL,
    cleaning_date               DATE NOT NULL,
    staff_id                    NUMBER(5) NOT NULL,
    ccs_start_time              DATE,
    ccs_end_time                DATE
);

COMMENT ON COLUMN cabin_cleaning_staff.resort_id IS
    'Resort identifier';

COMMENT ON COLUMN cabin_cleaning_staff.cabin_no IS
    'Cabin number within the resort';
    
COMMENT ON COLUMN cabin_cleaning_staff.cct_date IS
    'Date that the cabin is scheduled for cleaning';    

ALTER TABLE CABIN_CLEANING_STAFF ADD CONSTRAINT ccs_pk PRIMARY KEY ( resort_id, cabin_no, cct_date, staff_id );

ALTER TABLE CABIN_CLEANING_STAFF 
    ADD FOREIGN KEY (resort_id, cabin_no) 
    REFERENCES CABIN_CLEANING_TASK(resort_id , cabin_no);
    
ALTER TABLE staff
    ADD FOREIGN KEY (staff_id) 
    REFERENCES CABIN_CLEANING_TASK(staff_id);    

