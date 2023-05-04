--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SET ECHO ON
--SPOOL sql_portfolio1_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio1.sql

--Student ID: 31862616
--Student Name: Garret Yong Shern Min
--Unit Code: FIT3171
--Tutorial Class No: 06


/*Task 1: CREATE table POLICY and non FK constraints*/

CREATE TABLE policy (
    policy_id           NUMBER(5) NOT NULL,
    prop_no             NUMBER(4) NOT NULL,
    policy_startdate    DATE NOT NULL,
    policy_type_code    CHAR(1) NOT NULL,
    policy_length       NUMBER(3) NOT NULL,
    insurer_code        CHAR(3) NOT NULL
);

COMMENT ON COLUMN policy.policy_id IS
    'Policy ID';

COMMENT ON COLUMN policy.prop_no IS
    'Property number';
    
COMMENT ON COLUMN policy.policy_startdate IS
    'Policy start date';    

COMMENT ON COLUMN policy.policy_type_code IS
    'Policy type code';

COMMENT ON COLUMN policy.policy_length IS
    'Policy length';

COMMENT ON COLUMN policy.insurer_code IS
    'Insurer code';
    
ALTER TABLE policy ADD CONSTRAINT policy_pk PRIMARY KEY (policy_id);    

/*Task 1: Add FK constraints*/

ALTER TABLE policy 
    ADD FOREIGN KEY (prop_no) 
    REFERENCES property(prop_no);
--  ON DELETE CASCADE RESTRICT ; /* help */
  
ALTER TABLE policy 
    ADD FOREIGN KEY (policy_type_code) 
    REFERENCES policy_type(policy_type_code);
--  ON DELETE CASCADE RESTRICT ; /* help */  

ALTER TABLE policy add UNIQUE (prop_no, policy_startdate, policy_type_code);
  
ALTER TABLE policy
  ADD FOREIGN KEY (insurer_code) 
  REFERENCES insurer(insurer_code);
--  ON DELETE RESTRICT ; /* help */ 
  
ALTER TABLE policy add CHECK (policy_length > 5);

/*Task 2*/
INSERT INTO policy VALUES (
    (policy_seq.nextval), 
    7145, 
    to_date( '21-Apr-2023', 'dd-Mon-yyyy'), 
    (SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Building')), 
    12, 
    (SELECT insurer_code FROM INSURER WHERE UPPER(insurer_name) = UPPER('Landlord Association')));
INSERT INTO policy VALUES (
    (policy_seq.nextval), 
    9346, 
    to_date( '21-Apr-2023', 'dd-Mon-yyyy'), 
    (SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Building')), 
    12, 
    (SELECT insurer_code FROM INSURER WHERE UPPER(insurer_name) = UPPER('Landlord Association')));
commit;

/*Task 3*/

UPDATE policy 
    SET policy_length = policy_length + 6 
        WHERE prop_no = 7145  and policy_startdate = to_date( '21-Apr-2023', 'dd-Mon-yyyy') and UPPER(policy_type_code) = UPPER((SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Building')));
INSERT INTO policy VALUES ((policy_seq.nextval), 7145, to_date( '21-Apr-2023', 'dd-Mon-yyyy') + 10, (SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Contents')), 12,(SELECT insurer_code FROM INSURER WHERE UPPER(insurer_name) = UPPER('Landlord Association')));
commit;

/*Task 4*/
UPDATE policy 
    SET policy_length = policy_length - 6 
        WHERE prop_no = 7145  and policy_startdate = to_date( '21-Apr-2023', 'dd-Mon-yyyy') and UPPER(policy_type_code) = UPPER((SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Building')));
DELETE FROM policy WHERE policy_id = (SELECT policy_id FROM policy WHERE prop_no = 7145 AND policy_startdate = (to_date( '21-Apr-2023', 'dd-Mon-yyyy')+10) AND UPPER(policy_type_code) = UPPER((SELECT policy_type_code FROM POLICY_TYPE WHERE UPPER(policy_type_desc) = UPPER('Contents'))));        
commit;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
--SPOOL OFF
--SET ECHO OFF