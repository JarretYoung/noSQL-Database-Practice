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
CREATE OR REPLACE TRIGGER NEW_MEMBER_RECOMMENDATION_CHECK 
BEFORE INSERT ON MEMBER 
FOR EACH ROW 
DECLARE 
        existing_member number;
        resort_id_rec_mem number;
BEGIN
    IF (:new.member_id_recby IS NOT NULL) then
        SELECT count(*) into existing_member FROM member WHERE member_id = :new.member_id_recby;
        IF (existing_member = 0) then
            raise_application_error(-20000, 'Member does not exist');
        ELSE 
            SELECT resort_id into resort_id_rec_mem FROM MEMBER WHERE member_id = :new.member_id_recby;
            IF (resort_id_rec_mem != :new.resort_id) then
                raise_application_error(-20011, 'Member is not from the same resort');
            ELSE
                UPDATE MEMBER SET member_points = member_points + 10 WHERE member_id = :new.member_id_recby;
            END IF;    
        END IF;  
    END IF;    
END;
/


-- Write Test Harness for 4(b)
-- test harness
-- test case 1
--before
SELECT * from member;

-- executing trigger
-- pass
-- insert valid recommended id from the same resort 
insert into member VALUES (5,1,3,'Blaidd','Renala','21 Nokron Plex', 'gyon0004@student.monash.edu', 0123456789, to_date('24-Oct-2023', 'dd-Mon-yyyy'),500,1);

--after
SELECT * from member;
rollback;


-- test case 2
--before
SELECT * from member;

-- executing trigger
-- pass
-- insert null recommended id 
insert into member VALUES (5,1,3,'Blaidd','Renala','21 Nokron Plex', 'gyon0004@student.monash.edu', 0123456789, to_date('24-Oct-2023', 'dd-Mon-yyyy'),500, null);

--after
SELECT * from member;
rollback;


-- test case 3
--before
SELECT * from member;

-- executing trigger
-- fail
-- insert invalid recommended id 
insert into member VALUES (5,1,3,'Blaidd','Renala','21 Nokron Plex', 'gyon0004@student.monash.edu', 0123456789, to_date('24-Oct-2023', 'dd-Mon-yyyy'),500, 900);

--after
SELECT * from member;
rollback;


-- test case 4
--before
SELECT * from member;

-- executing trigger
-- fail
-- insert valid recommended id from a different resort
insert into member VALUES (5,1,3,'Blaidd','Renala','21 Nokron Plex', 'gyon0004@student.monash.edu', 0123456789, to_date('24-Oct-2023', 'dd-Mon-yyyy'),500, 2);

--after
SELECT * from member;
rollback;