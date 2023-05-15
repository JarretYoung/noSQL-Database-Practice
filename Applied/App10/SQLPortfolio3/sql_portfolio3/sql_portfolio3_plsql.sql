--Comment out SET ECHO, SET SERVEROUTPUT and SPOOL commands before submitting your portfolio
SET ECHO ON
SET SERVEROUTPUT ON
SPOOL sql_portfolio3_plsql_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio3_plsql.sql

--Student ID:
--Student Name:
--Unit Code:
--Tutorial Class No:

-- PLEASE PLACE REQUIRED TRIGGER STATEMENT HERE
-- ENSURE your trigger ends with a line break, then a slash (/) then another line break


CREATE OR REPLACE TRIGGER check_content_policy
BEFORE INSERT ON POLICY
FOR EACH ROW
DECLARE
    furnish_status CHAR;
    prev_policy_enddate DATE;
    count_policy NUMBER;
BEGIN
        IF (:new.policy_type_code = 'C') then   
            SELECT prop_fully_furnished into furnish_status FROM PROPERTY WHERE PROPERTY.prop_no = :new.prop_no; 
            IF (furnish_status = 'N') then
                raise_application_error(-20000, 'A content policy cannot be added if the property is not fully furnished.');
            END IF;           
        END IF;
        
        SELECT count(*) into count_policy FROM POLICY WHERE POLICY.prop_no = :new.prop_no AND UPPER(POLICY.policy_type_code) = UPPER(:new.policy_type_code);
        IF (count_policy > 0) THEN
            SELECT to_date(policy_enddate, 'dd-Mon-yyyy') into prev_policy_enddate FROM POLICY WHERE POLICY.prop_no = :new.prop_no AND UPPER(POLICY.policy_type_code) = UPPER(:new.policy_type_code);
            IF (to_date(:new.policy_startdate, 'dd-Mon-yyyy') <= prev_policy_enddate) then
                raise_application_error(-20000, 'A policy for a property cannot be implemented if the previous policy has not expired');
            END IF;
        END IF;    
        dbms_output.put_line('Policy has been created');
END;

/

-- PLACE REQUIRED TRIGGER TEST HARNESS HERE
-- test harness
-- test case 1
SELECT * FROM POLICY;

-- executing trigger 
-- fail
-- insert policy where property is not furnished
insert into POLICY values (11111,5990,to_date('01-Jan-2021','DD-MON-yyyy'),'C',to_date('02-FEB-2021','DD-MON-yyyy'),'LAS');

--after
SELECT * FROM POLICY;
rollback;
--==================================================================================================--
-- test harness
-- test case 2
SELECT * FROM POLICY;

-- executing trigger 
-- pass
-- insert policy where property is furnished
insert into POLICY values (11111,1965,to_date('01-Jan-2021','DD-MON-yyyy'),'C',to_date('02-FEB-2021','DD-MON-yyyy'),'LAS');

--after
SELECT * FROM POLICY;
rollback;
--==================================================================================================--
-- test harness
-- test case 3
-- Insert a valid policy
insert into POLICY values (11111,1965,to_date('01-Jan-2021','DD-MON-yyyy'),'C',to_date('02-FEB-2021','DD-MON-yyyy'),'LAS');
SELECT * FROM POLICY;

-- executing trigger 
-- fail 
-- Insert 2nd policy where startdate of the new policy (with similar type and property number) is before the end date of the previous one
insert into POLICY values (11112,1965,to_date('21-Jan-2021','DD-MON-yyyy'),'C',to_date('02-FEB-2021','DD-MON-yyyy'),'LAS');

--after
SELECT * FROM POLICY;
rollback;

--==================================================================================================--
-- test harness
-- test case 4
SELECT * FROM POLICY;

-- executing trigger 
-- fail 
-- insert policy where property is furnished then insert 2nd policy where startdate of the new policy (with similar type and property number) is after the end date of the previous one
insert into POLICY values (11111,1965,to_date('01-Jan-2021','DD-MON-yyyy'),'C',to_date('02-FEB-2021','DD-MON-yyyy'),'LAS');
insert into POLICY values (11112,1965,to_date('3-Feb-2021','DD-MON-yyyy'),'C',to_date('02-March-2021','DD-MON-yyyy'),'LAS');

--after
SELECT * FROM POLICY;
rollback;

--Comment out SET ECHO, SET SERVEROUTPUT and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF