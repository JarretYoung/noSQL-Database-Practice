DROP TABLE drone CASCADE CONSTRAINTS;

DROP TABLE drone_type CASCADE CONSTRAINTS;

DROP TABLE rental CASCADE CONSTRAINTS;

CREATE TABLE drone (
    drone_id          NUMBER(5) NOT NULL,
    drone_pur_date    DATE NOT NULL,
    drone_pur_price   NUMBER(7, 2) NOT NULL,
    drone_flight_time NUMBER(6, 1) NOT NULL,
    drone_cost_hr     NUMBER(6, 2) NOT NULL,
    drone_rent_count  NUMBER(3) NOT NULL,
    dt_code           CHAR(4) NOT NULL
);

COMMENT ON COLUMN drone.drone_id IS
    'drone id (unique for each drone)';

COMMENT ON COLUMN drone.drone_pur_date IS
    'drone purchase date';

COMMENT ON COLUMN drone.drone_pur_price IS
    'drone purchase price';

COMMENT ON COLUMN drone.drone_flight_time IS
    'drone flight time completed since purchase - initially 0';

COMMENT ON COLUMN drone.drone_cost_hr IS
    'drone rate per hour';

COMMENT ON COLUMN drone.drone_rent_count IS
    'number of times a drone rented';

COMMENT ON COLUMN drone.dt_code IS
    'drone type code (identifier';

ALTER TABLE drone ADD CONSTRAINT drone_pk PRIMARY KEY ( drone_id );

CREATE TABLE drone_type (
    dt_code     CHAR(4) NOT NULL,
    dt_model    VARCHAR2(50) NOT NULL,
    dt_carry_kg NUMBER(3) NOT NULL
);

COMMENT ON COLUMN drone_type.dt_code IS
    'drone type code (identifier';

COMMENT ON COLUMN drone_type.dt_model IS
    'drone type model';

COMMENT ON COLUMN drone_type.dt_carry_kg IS
    'drone type carrying capacity in kg';

ALTER TABLE drone_type ADD CONSTRAINT drone_type_pk PRIMARY KEY ( dt_code );

CREATE TABLE rental (
    rent_no      NUMBER(8) NOT NULL,
    rent_bond    NUMBER(6, 2) NOT NULL,
    rent_out     DATE NOT NULL,
    rent_duedate DATE NOT NULL,
    rent_in      DATE,
    drone_id     NUMBER(5) NOT NULL
);

COMMENT ON COLUMN rental.rent_no IS
    'rental number';

COMMENT ON COLUMN rental.rent_bond IS
    'rental bond';

COMMENT ON COLUMN rental.rent_out IS
    'date/time that the drone leaves';

COMMENT ON COLUMN rental.rent_duedate IS
    'date that the drone due to be returned';

COMMENT ON COLUMN rental.rent_in IS
    'drone actual return date/time';

COMMENT ON COLUMN rental.drone_id IS
    'drone id (unique for each drone)';

ALTER TABLE rental ADD CONSTRAINT rental_pk PRIMARY KEY ( rent_no );

ALTER TABLE rental
    ADD CONSTRAINT drone_rental FOREIGN KEY ( drone_id )
        REFERENCES drone ( drone_id );

ALTER TABLE drone
    ADD CONSTRAINT dronetype_drone FOREIGN KEY ( dt_code )
        REFERENCES drone_type ( dt_code );


CREATE OR REPLACE TRIGGER check_drone_type_code BEFORE
    INSERT ON drone_type
    FOR EACH ROW
BEGIN
    IF  :new.dt_code NOT LIKE 'D%' THEN
        raise_application_error(-20001, 'Drone type code must start with D');
    END IF;
END;
/

SELECT * FROM drone_type;
DESC drone_type;

INSERT INTO drone_type VALUES ('D123','Testing', 3);
INSERT INTO drone_type VALUES ('d123','Testing', 3);


