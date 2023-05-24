--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-alter.sql

--Student ID:       31862616
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:
Assumptions: 
- There can be more than one staff that can clean a room but they do not need to be at the same time.
    For instance, staff 1 cleans from 1pm-2pm then staff 2 cleans from 2pm-3pm 

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

ALTER TABLE staff 
    ADD FOREIGN KEY ( role_id ) 
    REFERENCES role( role_id );
        
--4(c)
DROP TABLE CABIN_CLEANING_TASK CASCADE CONSTRAINTS PURGE; 
DROP TABLE CABIN_CLEANING_STAFF CASCADE CONSTRAINTS PURGE; 

-- Is the table to store information on cleaning activity that needs to be done on a cabin
CREATE TABLE CABIN_CLEANING_TASK (
    resort_id                   NUMBER(4) NOT NULL,
    cabin_no                    NUMBER(3) NOT NULL,
    cct_date                    DATE NOT NULL
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

DESC CABIN_CLEANING_TASK;

-- This table contains information on the staff that cleans a cabin and how long they do so
CREATE TABLE CABIN_CLEANING_STAFF (
    resort_id                   NUMBER(4) NOT NULL,
    cabin_no                    NUMBER(3) NOT NULL,
    cct_date                    DATE NOT NULL,
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
    
COMMENT ON COLUMN cabin_cleaning_staff.staff_id IS
    'Date that the cabin is scheduled for cleaning';     
    
COMMENT ON COLUMN cabin_cleaning_staff.ccs_start_time IS
    'Date that the cabin is scheduled for cleaning';    
    
COMMENT ON COLUMN cabin_cleaning_staff.ccs_end_time IS
    'Time that the staff';     

ALTER TABLE cabin_cleaning_staff ADD CONSTRAINT ccs_pk PRIMARY KEY ( resort_id, cabin_no, cct_date, staff_id );

ALTER TABLE cabin_cleaning_staff 
    ADD FOREIGN KEY (resort_id, cabin_no, cct_date) 
    REFERENCES CABIN_CLEANING_TASK(resort_id , cabin_no, cct_date);
    
ALTER TABLE cabin_cleaning_staff
    ADD FOREIGN KEY (staff_id) 
    REFERENCES staff(staff_id);    

DESC CABIN_CLEANING_TASK;