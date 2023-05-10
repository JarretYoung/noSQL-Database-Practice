SET Serveroutput on;
CREATE OR REPLACE TRIGGER CHECK_STUDENT_NAME 
BEFORE INSERT ON STUDENT 
FOR EACH ROW 
BEGIN
    IF(:new.stu_lname is null and :new.stu_fname is null) then
        raise_application_error(-20000, 'First and last name is required');
    END IF;    
END;
/

-- test harness
-- test case 1
SELECT count(*) FROM student;

-- executing trigger 
-- fail
-- insert student with no firstname and lastname
insert into STUDENT values (11111126,null,null,to_date('01-FEB-91','DD-MON-YY'),46);

--after
SELECT count(*) FROM student;
--=====================================================================================
-- test harness
-- test case 2
SELECT count(*) FROM student;

-- executing trigger 
-- pass
-- insert student with no lastname
insert into STUDENT values (11111126,'John',null,to_date('01-FEB-91','DD-MON-YY'),46);

--after
SELECT count(*) FROM student;
--======================================================================================
-- test harness
-- test case 3
SELECT count(*) FROM student;

-- executing trigger 
-- pass
-- insert student with no firstname 
insert into STUDENT values (11111127,null,'Papa',to_date('01-FEB-91','DD-MON-YY'),46);

--after
SELECT count(*) FROM student;
--======================================================================================
-- test harness
-- test case 4
SELECT count(*) FROM student;

-- executing trigger 
-- pass
-- insert student with first name and last name 
insert into STUDENT values (11111128,'Joe','Mama',to_date('01-FEB-91','DD-MON-YY'),46);

--after
SELECT count(*) FROM student;

rollback;









/*Question 1*/
CREATE OR REPLACE TRIGGER UNIT_UPD_CASCADE 
AFTER UPDATE ON UNIT
FOR EACH ROW 
BEGIN
    UPDATE ENROLMENT SET UNIT_CODE = :NEW.unit_code
    WHERE unit_code = :OLD.unit_code;
    dbms_output.put_line('Enrolment has been updated');
END;
/

-- test harness
-- test case 1
--before
SELECT count(*) FROM ENROLMENT WHERE unit_code =  'FIT9131';

-- executing trigger
-- update FIT9131 to FIT9999
UPDATE UNIT SET unit_code = 'FIT9999' WHERE unit_code = 'FIT9131';

--after
SELECT * FROM UNIT;

rollback;


/*Question 2*/
CREATE OR REPLACE TRIGGER MAINTAIN_ENROLMENT 
AFTER INSERT OR DELETE ON ENROLMENT
FOR EACH ROW 
BEGIN
    IF INSERTING then
        UPDATE UNIT SET unit_no_student = unit_no_student + 1
            WHERE unit_code = :old.unit_code;
    END IF;    
    IF DELETING then 
        UPDATE UNIT SET unit_no_student = unit_no_student - 1
            WHERE unit_code = :old.unit_code;
        
        INSERT INTO audit_log VALUES (audit_seq.nextval, sysdate, user, :old.stu_nbr, :old.unit_code);
    END IF;    
END;
/
-- test harness
-- test case 1
--before
SELECT unit_code, unit_no_student FROM UNIT;

-- executing trigger
-- pass
-- update delete enrolment 
delete from enrolment where stu_nbr = '11111121' and unit_code = 'FIT9131' and enrol_year = 2020 and enrol_semester = '1';

--after
SELECT unit_code, unit_no_student FROM UNIT;
SELECT * FROM audit_log;
--==================================================================================
-- test harness
-- test case 2
--before
SELECT unit_code, unit_no_student FROM UNIT;

-- executing trigger
-- pass
-- update delete enrolment 
insert into ENROLMENT values ('11111121','FIT9131',2020,'1',35,'N ');

--after
SELECT unit_code, unit_no_student FROM UNIT;








/*Part B*/
/*Question 1*/
create or replace PROCEDURE PRC_NEW_ENROLMENT (p_stu_nbr in number, p_unit_code in char, p_enrol_year in number, p_enrol_sem in char, p_output out varchar2)
AS
student_found number;
unit_found number;
enrol_found number;

BEGIN
    SELECT count(*) into student_found FROM student WHERE stu_nbr = p_stu_nbr;
    SELECT count(*) into unit_found FROM unit WHERE unit_code = p_unit_code;
    SELECT count(*) into enrol_found FROM enrolment WHERE stu_nbr = p_stu_nbr and unit_code = p_unit_code and enrol_year = p_enrol_year and enrol_semester = p_enrol_sem;

    if (student_found = 0) then
        p_output := 'invalid student number';
    else
        if (unit_found = 0) then
            p_output := 'invalid unit code';
        else
            if (enrol_found > 0) then
                p_output := 'Student has been registered';
            else
                insert into enrolment VALUES (p_stu_nbr, p_unit_code, p_enrol_year, p_enrol_sem, null, null);
                p_output := 'Student been inserted';
            END IF;
        END IF;
    END IF;    
END PRC_NEW_ENROLMENT;
/

-- test harness
-- test case 1
--before
SELECT count(*) from ENROLMENT;

-- executing trigger
-- fail
-- insert invalid student number 
DECLARE output varchar2(50);
Begin
    prc_new_enrolment('11111131','FIT9135',2020,'2', output);
    dbms_output.put_line(output);
end;    
/
-- test harness
-- test case 2
--before
SELECT count(*) from ENROLMENT;

-- executing trigger
-- fail
-- insert invalid unit number 
DECLARE output varchar2(50);
Begin
    prc_new_enrolment('11111121','FIT9000',2020,'2', output);
    dbms_output.put_line(output);
end;    
/

-- test harness
-- test case 3
--before
SELECT count(*) from ENROLMENT;

-- executing trigger
-- pass
-- insert invalid student number 
DECLARE output varchar2(50);
Begin
    prc_new_enrolment('11111121','FIT9135',2020,'2', output);
    dbms_output.put_line(output);
end;    
/

-- test harness
-- test case 4
--before
SELECT count(*) from ENROLMENT;
insert into STUDENT VALUES ('11111131', 'John', 'Day', to_date('01-Feb-2020', 'dd-Mon-yy'), 46);

-- executing trigger
-- fail
-- insert invalid student number 
DECLARE output varchar2(50);
Begin
    prc_new_enrolment('11111131','FIT9135',2020,'2', output);
    dbms_output.put_line(output);
end;    
/
rollback;