SELECT * FROM RENTAL;
DESC rental;

SELECT * FROM DRONE;
DESC drone;

INSERT INTO drone VALUES (999, TO_DATE ('25-Jun-2021', 'dd-Mon-yyyy'), 2000, 100, 10, 0, 'D123');


INSERT INTO rental VALUES
(200, 20,  TO_DATE ('25-Oct-2021', 'dd-Mon-yyyy'), SYSDATE, SYSDATE, 999);

DELETE FROM rental
WHERE rent_no = 100;

CREATE SEQUENCE rental_seq start with 1;
CREATE OR REPLACE PROCEDURE prc_insert_rental 
    ( p_drone_id IN NUMBER) AS
        p_drone_bond NUMBER;
BEGIN
    SELECT drone_pur_price * 10 / 100 INTO p_drone_bond
    FROM drone
    WHERE drone_id = p_drone_id;

    INSERT INTO rental VALUES (rental_seq.NEXTVAL,p_drone_bond, sysdate, sysdate+7, NULL, p_drone_id);
    dbms_output.put_line('A new rental for drone ' || p_drone_id || ' has been inserted');
END;
/
exec prc_insert_rental(100);

CREATE OR REPLACE PROCEDURE prc_insert_rental_output (p_drone_id IN NUMBER,p_output OUT VARCHAR2) AS
    p_drone_found NUMBER;
    p_drone_bond NUMBER;
BEGIN
    SELECT count(*) into p_drone_found FROM drone WHERE drone_id = p_drone_id;
    
    IF (p_drone_found = 0) THEN
        p_output := 'Invalid drone id, rental cannot be added';
    ELSE
        SELECT drone_pur_price * 10 / 100 INTO p_drone_bond FROM drone WHERE drone_id = p_drone_id;
    
        INSERT INTO rental VALUES (rental_seq.NEXTVAL, p_drone_bond,sysdate,sysdate+7,NULL, p_drone_id);

        p_output := 'A new rental for drone ' || p_drone_id || ' has been inserted';
    END IF;
END;
/

--execute the procedure
DECLARE
    output VARCHAR2(200);
BEGIN
    --call the procedure - success
    prc_insert_rental_output(100,output);
    dbms_output.put_line(output);
END;
/
DECLARE
    output VARCHAR2(200);
BEGIN
    --call the procedure - error
    prc_insert_rental_output(101,output);
    dbms_output.put_line(output);
END;
/
--initial data
insert into drone_type values ('DIN2','DJI Inspire 2',5);
insert into drone values (100,to_date('21-02-2021','dd-mm-yyyy'),4200,0,35,0,'DIN2');


