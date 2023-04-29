/*
Databases SQL Portfolio 1 2022 Nov12
propinspect_schema_insert.sql

Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.
*/

-- DROP all PROPINSURANCE tables

DROP TABLE insurer CASCADE CONSTRAINTS PURGE;

DROP TABLE owner CASCADE CONSTRAINTS PURGE;

DROP TABLE policy CASCADE CONSTRAINTS PURGE;

DROP TABLE policy_type CASCADE CONSTRAINTS PURGE;

DROP TABLE property CASCADE CONSTRAINTS PURGE;

-- CREATING table INSURER

CREATE TABLE insurer (
    insurer_code CHAR(3) NOT NULL,
    insurer_name VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN insurer.insurer_code IS
    'Insurance company unique identifier';

COMMENT ON COLUMN insurer.insurer_name IS
    'Insurance company name';

ALTER TABLE insurer ADD CONSTRAINT insurer_pk PRIMARY KEY ( insurer_code );

-- CREATING table OWNER

CREATE TABLE owner (
    owner_no      NUMBER(4) NOT NULL,
    owner_givname VARCHAR2(20),
    owner_famname VARCHAR2(20),
    owner_address VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN owner.owner_no IS
    'Unique identifier for owner';

COMMENT ON COLUMN owner.owner_givname IS
    'Given name of property owner';

COMMENT ON COLUMN owner.owner_famname IS
    'Family name of property owner';

COMMENT ON COLUMN owner.owner_address IS
    'Address of property owner';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_no );

-- CREATING table POLICY_TYPE

CREATE TABLE policy_type (
    policy_type_code CHAR(1) NOT NULL,
    policy_type_desc VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN policy_type.policy_type_code IS
    'Policy type unique identifier';

COMMENT ON COLUMN policy_type.policy_type_desc IS
    'Policy type description';

ALTER TABLE policy_type ADD CONSTRAINT policy_type_pk PRIMARY KEY ( policy_type_code )
;

ALTER TABLE policy_type ADD CONSTRAINT policy_type_uq UNIQUE ( policy_type_desc );

-- CREATING table PROPERTY

CREATE TABLE property (
    prop_no              NUMBER(4) NOT NULL,
    prop_address         VARCHAR2(80) NOT NULL,
    prop_value           NUMBER(10, 2) NOT NULL,
    prop_yearbuilt       DATE NOT NULL,
    prop_fully_furnished CHAR(1) NOT NULL,
    owner_no             NUMBER(4) NOT NULL
);

COMMENT ON COLUMN property.prop_no IS
    'Unique property identifier';

COMMENT ON COLUMN property.prop_address IS
    'Address of property';

COMMENT ON COLUMN property.prop_value IS
    'Value of property';

COMMENT ON COLUMN property.prop_yearbuilt IS
    'The year when the property was built';

COMMENT ON COLUMN property.prop_fully_furnished IS
    'Property furnish type (Y-Yes, N-No)';

COMMENT ON COLUMN property.owner_no IS
    'Unique identifier for owner';

ALTER TABLE property ADD CONSTRAINT property_pk PRIMARY KEY ( prop_no );

-- ADDING FK Constraints

ALTER TABLE property
    ADD CONSTRAINT owner_property FOREIGN KEY ( owner_no )
        REFERENCES owner ( owner_no );
        
-- CREATING sequence for policy_id
DROP SEQUENCE policy_seq;
CREATE SEQUENCE policy_seq START WITH 1;

-- INSERTING into OWNER
INSERT INTO owner (
    owner_no,
    owner_givname,
    owner_famname,
    owner_address
) VALUES (
    9321,
    'Lilian',
    'Potter',
    '85 Shields Station St, Apt. 273, 8149, D''amoreburgh, Tasmania'
);

INSERT INTO owner (
    owner_no,
    owner_givname,
    owner_famname,
    owner_address
) VALUES (
    564,
    'Ronald',
    'Meere',
    '219 Mikayla View Rd, Suite 632, 1463, Port Jacobtown, Victoria'
);

INSERT INTO owner (
    owner_no,
    owner_givname,
    owner_famname,
    owner_address
) VALUES (
    852,
    'Ludovika',
    'Wiggins',
    '623 Audrey Avenue, Suite 778, 2350, New Lucytown, Queensland'
);

INSERT INTO owner (
    owner_no,
    owner_givname,
    owner_famname,
    owner_address
) VALUES (
    9762,
    'Jasun',
    'Clitsome',
    '2443 Reynolds Road, Suite 925, 1770, Lake Levi, New South Wales'
);

-- INSERTING into PROPERTY
INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    1965,
    '4633 Leannon Crescent, Suite 962, 1791, Lake Evaside, Tasmania',
    610000,
    to_date('1995','YYYY'),
    'Y',
    9321
);

INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    5990,
    '9454 Ebert Crest, Suite 183, 4027, Trompview, New South Wales',
    686000,
    to_date('1998','YYYY'),
    'N',
    9762
);

INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    6123,
    '26 Hackett Knoll, Apt. 615, 6856, South Annashire, Victoria',
    640000,
    to_date('2007','YYYY'),
    'Y',
    564
);

INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    7145,
    '928 Olivia Crest, Apt. 293, 4328, Connellymouth, Queensland',
    460000,
    to_date('2008','YYYY'),
    'N',
    852
);

INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    9346,
    '531 Sienna Run, Suite 991, 6792, Boscoburgh, Queensland',
    500000,
    to_date('2011','YYYY'),
    'Y',
    852
);

INSERT INTO property (
    prop_no,
    prop_address,
    prop_value,
    prop_yearbuilt,
    prop_fully_furnished,
    owner_no
) VALUES (
    9412,
    '282 Princes Highway, Unit 1, 6856, South Annashire, Victoria',
    660000,
    to_date('2012','YYYY'),
    'N',
    564
);

-- INSERTING into INSURER
INSERT INTO insurer (
    insurer_code,
    insurer_name
) VALUES (
    'LAS',
    'Landlord Association'
);

INSERT INTO insurer (
    insurer_code,
    insurer_name
) VALUES (
    'PIG',
    'Property Investor Group'
);

INSERT INTO insurer (
    insurer_code,
    insurer_name
) VALUES (
    'VAI',
    'Victorian Insurance'
);

-- INSERTING into POLICY_TYPE
INSERT INTO policy_type (
    policy_type_code,
    policy_type_desc
) VALUES (
    'B',
    'Building'
);

INSERT INTO policy_type (
    policy_type_code,
    policy_type_desc
) VALUES (
    'C',
    'Contents'
);

COMMIT;