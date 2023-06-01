--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-plsql.sql

--Student ID:       31862616
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:

*/

SET SERVEROUTPUT ON

--4(a) 
-- Create a sequence for REVIEW PK
DROP SEQUENCE review_seq;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;

-- Complete the procedure below
CREATE OR REPLACE PROCEDURE prc_insert_review (
    p_member_id      IN NUMBER,
    p_poi_id         IN NUMBER,
    p_review_comment IN VARCHAR2,
    p_review_rating  IN NUMBER,
    p_output         OUT VARCHAR2
) AS
    ided_mem_id number;
    ided_poi_id number;
BEGIN
    SELECT count(*) into ided_mem_id FROM member WHERE member_id = p_member_id;
    SELECT count(*) into ided_poi_id FROM point_of_interest WHERE poi_id = p_poi_id;
    
    if (ided_mem_id = 0) then
        p_output := 'invalid member id';
    else
        if (ided_poi_id = 0) then
            p_output := 'invalid poi id';
        else
            insert into review VALUES ((review_seq.nextVal), p_member_id, SYSDATE, p_review_comment, p_review_rating, p_poi_id);
            p_output := 'Review has been submitted';
        END IF;
    END IF;   
END;
/

-- Write Test Harness for 4(a)
-- test harness
-- test case 1
--before
SELECT * from review;

-- executing trigger
-- pass
-- insert valid member id and poi id
DECLARE output varchar2(50);
Begin
    prc_insert_review('4','2','I like the apples there','2', output);
    dbms_output.put_line(output);
end;    
/
--after
SELECT * from review;
rollback;

-- test harness
-- test case 2
--before
SELECT * from review;

-- executing trigger
-- fail
-- insert invalid member id and valid poi id
DECLARE output varchar2(50);
Begin
    prc_insert_review('999','2','I like the apples there','2', output);
    dbms_output.put_line(output);
end;    
/
--after
SELECT * from review;
rollback;

-- test harness
-- test case 3
--before
SELECT * from review;

-- executing trigger
-- pass
-- insert valid member id and invalid poi id
DECLARE output varchar2(50);
Begin
    prc_insert_review('4','20000','I like the apples there','2', output);
    dbms_output.put_line(output);
end;    
/
--after
SELECT * from review;
rollback;


--4(b) 
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line

-- Write Test Harness for 4(b)
