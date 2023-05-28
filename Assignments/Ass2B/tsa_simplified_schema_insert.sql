/*
  Databases 2023 S1 Assignment 2B
  --TimeShare Australia PL/SQL File and Initial Data--
  --tsa_simplified_schema_insert.sql
  
  Description: 
  This file creates and populates a few of TimeShare Australia tables 
  for PL/SQL Tasks. 
  You should read this schema file carefully 
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
  
*/

DROP TABLE member CASCADE CONSTRAINTS PURGE;

DROP TABLE point_of_interest CASCADE CONSTRAINTS PURGE;

DROP TABLE resort CASCADE CONSTRAINTS PURGE;

DROP TABLE review CASCADE CONSTRAINTS PURGE;

DROP TABLE town CASCADE CONSTRAINTS PURGE;

CREATE TABLE member (
    member_id          NUMBER(6) NOT NULL,
    resort_id          NUMBER(4) NOT NULL,
    member_no          NUMBER(2) NOT NULL,
    member_gname       VARCHAR2(30),
    member_fname       VARCHAR2(30),
    member_haddress    VARCHAR2(50) NOT NULL,
    member_email       VARCHAR2(30) NOT NULL,
    member_phone       CHAR(10) NOT NULL,
    member_date_joined DATE NOT NULL,
    member_points      NUMBER(4) NOT NULL,
    member_id_recby    NUMBER(6)
);

COMMENT ON COLUMN member.member_id IS
    'Unique member id across TSA';

COMMENT ON COLUMN member.resort_id IS
    'Resort identifier';

COMMENT ON COLUMN member.member_no IS
    'Member number within home resort';

COMMENT ON COLUMN member.member_gname IS
    'Members given name';

COMMENT ON COLUMN member.member_fname IS
    'Members family name';

COMMENT ON COLUMN member.member_haddress IS
    'Members home address';

COMMENT ON COLUMN member.member_email IS
    'Member email address';

COMMENT ON COLUMN member.member_phone IS
    'Member contact phone number';

COMMENT ON COLUMN member.member_date_joined IS
    'Date member joined resort';

COMMENT ON COLUMN member.member_points IS
    'The number of points the member purchased on joining the resort';

COMMENT ON COLUMN member.member_id_recby IS
    'Unique member id across TSA';

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( member_id );

ALTER TABLE member ADD CONSTRAINT member_nk UNIQUE ( member_no,
                                                     resort_id );

CREATE TABLE point_of_interest (
    poi_id             NUMBER(5) NOT NULL,
    town_id            NUMBER(4) NOT NULL,
    poi_street_address VARCHAR2(50) NOT NULL,
    poi_name           VARCHAR2(50) NOT NULL,
    poi_description    VARCHAR2(250) NOT NULL,
    poi_open_time      DATE,
    poi_close_time     DATE,
    poi_review_rating  NUMBER(2, 1)
);

COMMENT ON COLUMN point_of_interest.poi_id IS
    'POI identifer';

COMMENT ON COLUMN point_of_interest.town_id IS
    'Identifier for a town (surrogate)';

COMMENT ON COLUMN point_of_interest.poi_street_address IS
    'POI street address';

COMMENT ON COLUMN point_of_interest.poi_name IS
    'Name of POI';

COMMENT ON COLUMN point_of_interest.poi_description IS
    'Description of POI';

COMMENT ON COLUMN point_of_interest.poi_open_time IS
    'POI opening time';

COMMENT ON COLUMN point_of_interest.poi_close_time IS
    'POI close time';

COMMENT ON COLUMN point_of_interest.poi_review_rating IS
    'Combined member reviews';

ALTER TABLE point_of_interest ADD CONSTRAINT point_of_interest_pk PRIMARY KEY ( poi_id
);

ALTER TABLE point_of_interest
    ADD CONSTRAINT point_of_interest_nk UNIQUE ( poi_street_address,
                                                 poi_name,
                                                 town_id );

CREATE TABLE resort (
    resort_id               NUMBER(4) NOT NULL,
    resort_name             VARCHAR2(50) NOT NULL,
    resort_street_address   VARCHAR2(50) NOT NULL,
    resort_phone            CHAR(10) NOT NULL,
    resort_yr_built_purch   DATE NOT NULL,
    resort_points_base_cost NUMBER(4) NOT NULL,
    resort_member_numbers   NUMBER(3) DEFAULT 0 NOT NULL,
    town_id                 NUMBER(4) NOT NULL
);

COMMENT ON COLUMN resort.resort_id IS
    'Resort identifier';

COMMENT ON COLUMN resort.resort_name IS
    'Resort Name';

COMMENT ON COLUMN resort.resort_street_address IS
    'Resort street address';

COMMENT ON COLUMN resort.resort_phone IS
    'Contact number for resort';

COMMENT ON COLUMN resort.resort_yr_built_purch IS
    'Date the resort was built or purchased';

COMMENT ON COLUMN resort.resort_points_base_cost IS
    'The base points member cost for joining this resort';

COMMENT ON COLUMN resort.resort_member_numbers IS
    'The total number of members belong to this resort';

COMMENT ON COLUMN resort.town_id IS
    'Identifier for a town (surrogate)';

ALTER TABLE resort ADD CONSTRAINT resort_pk PRIMARY KEY ( resort_id );

CREATE TABLE review (
    review_id        NUMBER(8) NOT NULL,
    member_id        NUMBER(6) NOT NULL,
    review_date_time DATE NOT NULL,
    review_comment   VARCHAR2(500),
    review_rating    NUMBER(1) NOT NULL,
    poi_id           NUMBER(5) NOT NULL
);

ALTER TABLE review
    ADD CONSTRAINT ch_review_rating CHECK ( review_rating IN ( 1, 2, 3, 4, 5 ) );

COMMENT ON COLUMN review.review_id IS
    'Review identifier';

COMMENT ON COLUMN review.member_id IS
    'Unique member id across TSA';

COMMENT ON COLUMN review.review_date_time IS
    'Date time review was entered to the system';

COMMENT ON COLUMN review.review_comment IS
    'Review comment';

COMMENT ON COLUMN review.review_rating IS
    'Review rating ( 1.. 5)';

COMMENT ON COLUMN review.poi_id IS
    'POI identifer';

ALTER TABLE review ADD CONSTRAINT review_pk PRIMARY KEY ( review_id );

ALTER TABLE review ADD CONSTRAINT review_nk UNIQUE ( review_date_time,
                                                     member_id );

CREATE TABLE town (
    town_id              NUMBER(4) NOT NULL,
    town_lat             NUMBER(9, 6) NOT NULL,
    town_long            NUMBER(9, 6) NOT NULL,
    town_name            VARCHAR2(50) NOT NULL,
    town_state           CHAR(3) NOT NULL,
    town_avg_summer_temp NUMBER(3, 1) NOT NULL,
    town_avg_winter_temp NUMBER(3, 1) NOT NULL,
    town_population      NUMBER(7) NOT NULL
);

COMMENT ON COLUMN town.town_id IS
    'Identifier for a town (surrogate)';

COMMENT ON COLUMN town.town_lat IS
    'Lattitude of the center of the town';

COMMENT ON COLUMN town.town_long IS
    'Longtitude of the town centre';

COMMENT ON COLUMN town.town_name IS
    'Town Name';

COMMENT ON COLUMN town.town_state IS
    'Town state';

COMMENT ON COLUMN town.town_avg_summer_temp IS
    'Town average sumnmer temperature';

COMMENT ON COLUMN town.town_avg_winter_temp IS
    'Town average winter temperature';

COMMENT ON COLUMN town.town_population IS
    'Population of town';

ALTER TABLE town ADD CONSTRAINT town_pk PRIMARY KEY ( town_id );

ALTER TABLE town ADD CONSTRAINT town_nk UNIQUE ( town_lat,
                                                 town_long );

ALTER TABLE member
    ADD CONSTRAINT member_recommends FOREIGN KEY ( member_id_recby )
        REFERENCES member ( member_id );

ALTER TABLE review
    ADD CONSTRAINT member_review FOREIGN KEY ( member_id )
        REFERENCES member ( member_id );

ALTER TABLE review
    ADD CONSTRAINT poi_review FOREIGN KEY ( poi_id )
        REFERENCES point_of_interest ( poi_id );

ALTER TABLE member
    ADD CONSTRAINT resort_member FOREIGN KEY ( resort_id )
        REFERENCES resort ( resort_id );

ALTER TABLE point_of_interest
    ADD CONSTRAINT town_poi FOREIGN KEY ( town_id )
        REFERENCES town ( town_id );

ALTER TABLE resort
    ADD CONSTRAINT town_resort FOREIGN KEY ( town_id )
        REFERENCES town ( town_id );
        
--------------------------------------
--INSERT INTO town
--------------------------------------
INSERT INTO town VALUES (
    1,
    - 28.6474,
    153.6020,
    'Byron Bay',
    'NSW',
    23.5,
    16.9,
    9483
);

INSERT INTO town VALUES (
    2,
    - 32.6145,
    149.5733,
    'Mudgee',
    'NSW',
    23.0,
    8.3,
    11634
);

INSERT INTO town VALUES (
    3,
    - 26.5309,
    151.8400,
    'Kingaroy',
    'QLD',
    24.8,
    11.5,
    10398
);

INSERT INTO town VALUES (
    4,
    - 26.1834,
    152.6657,
    'Gympie',
    'QLD',
    27.1,
    13.6,
    21599
);

INSERT INTO town VALUES (
    5,
    - 23.6980,
    133.8807,
    'Alice Springs',
    'NT',
    29,
    13,
    26534
);

INSERT INTO town VALUES (
    6,
    - 17.9644,
    122.2304,
    'Broome',
    'WA',
    32,
    21,
    14445
);

INSERT INTO town VALUES (
    7,
    - 20.7256,
    139.4927,
    'Mount Isa',
    'QLD',
    31.9,
    17.3,
    21998
);

INSERT INTO town VALUES (
    8,
    - 31.8895,
    152.4444,
    'Taree',
    'NSW',
    24.3,
    12.0,
    25852
);

INSERT INTO town VALUES (
    9,
    - 36.1460,
    144.7448,
    'Echuca',
    'VIC',
    22.2,
    9.3,
    12906
);

INSERT INTO town VALUES (
    10,
    - 19.9564,
    129.6970,
    'Tanami',
    'NT',
    30.4,
    15.4,
    73
);

INSERT INTO town VALUES (
    11,
    - 26.5936,
    151.8292,
    'Taabinga',
    'QLD',
    23.5,
    13,
    930
);

INSERT INTO town VALUES (
    12,
    - 26.2476,
    152.7677,
    'Mothar Mountain',
    'QLD',
    25,
    15.5,
    612
);

INSERT INTO town VALUES (
    13,
    - 23.6765,
    133.8816,
    'Stuart',
    'NT',
    27.5,
    14,
    8034
);

INSERT INTO town VALUES (
    14,
    - 20.7354,
    139.4962,
    'Mornington',
    'QLD',
    29.5,
    22.5,
    1087
);

INSERT INTO town VALUES (
    15,
    - 27.4439,
    152.9531,
    'The Gap',
    'QLD',
    25,
    17,
    17865
);

INSERT INTO town VALUES (
    16,
    - 19.3496,
    127.7837,
    'Sturt Creek',
    'WA',
    32.5,
    21.5,
    789
);

INSERT INTO town VALUES (
    17,
    - 26.8845,
    151.5972,
    'Bunya Mountains',
    'QLD',
    32.4,
    18.6,
    198
);

INSERT INTO town VALUES (
    18,
    - 18.2229,
    127.6701,
    'Halls Creek',
    'WA',
    31,
    20,
    1756
);
--------------------------------------
--INSERT INTO resort
--------------------------------------
INSERT INTO resort VALUES (
    1,
    'Byron Bay Exclusive Resort',
    '1 Karma Road',
    '0212429423',
    TO_DATE('2012', 'yyyy'),
    5000,
    2,
    1
);

INSERT INTO resort VALUES (
    2,
    'Amazing Resort',
    '5B Lincoln Way',
    '0326415234',
    TO_DATE('2014', 'yyyy'),
    3000,
    2,
    9
);

INSERT INTO resort VALUES (
    3,
    'Alice Springs Resort',
    '1 Wonderland Road',
    '0870003111',
    TO_DATE('2011', 'yyyy'),
    4000,
    0,
    5
);
--------------------------------------
--INSERT INTO member
--------------------------------------
INSERT INTO member VALUES (
    1,
    1,
    1,
    'Florida',
    'Goldhawk',
    '904 Talmadge Lane, Belgrave, VIC',
    'f.goldhawk@msn.com',
    '0454762942',
    TO_DATE('23/04/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    2,
    2,
    1,
    'Marina',
    'Clements',
    '4632 Monica Plaza, Oakleigh,VIC',
    'clements@kys.com',
    '0425271315',
    TO_DATE('10/05/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    3,
    2,
    2,
    'Stefanie',
    'Wilstead',
    '1723 Dottie Parkway, Pakenham, VIC',
    'stef_w@msn.com',
    '0452272267',
    TO_DATE('16/05/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    4,
    1,
    2,
    'Henry',
    '',
    '32 Narrow Lane, Parramatta, NSW',
    'thegreathenry@abc.com',
    '0454312423',
    TO_DATE('02/06/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

--------------------------------------
--INSERT INTO POI
--------------------------------------

INSERT INTO point_of_interest VALUES (
    1,
    1,
    'Cape Byron Walking Track',
    'Cape Byron Lighthouse',
    'Cape Byron Light is an active lighthouse located at Cape Byron, New South Wales, Australia. It is Australias most powerful lighthouse. (wikipedia.org)'
    ,
    TO_DATE('08:00', 'HH24:MI'),
    TO_DATE('18:00', 'HH24:MI'),
    NULL
);

INSERT INTO point_of_interest VALUES (
    2,
    11,
    '45 Geoff Raph Dr',
    'Kingaroy Observatory',
    'Located at the Kingaroy Airport, the delightfully eccentric James takes guests on a galactic journey through the cosmos, with a little help from his green laser pointer, and three 35cm telescopes. (brisbanekids.com.au)'
    ,
    TO_DATE('07:00', 'HH24:MI'),
    TO_DATE('19:00', 'HH24:MI'),
    NULL
);

INSERT INTO point_of_interest VALUES (
    3,
    3,
    '124 Haly St',
    'Kingaroy Heritage Museum',
    'Kingaroy''s fascinating Heritage Museum is part of the Kingaroy Information, Art and Heritage Precinct. The history of the local peanut industry is a main focus of the collection. (southernqueenslandcountry.com.au)'
    ,
    TO_DATE('09:00', 'HH24:MI'),
    TO_DATE('16:00', 'HH24:MI'),
    NULL
);

INSERT INTO point_of_interest VALUES (
    4,
    12,
    '281 Hill Rd',
    'Woondum National Park',
    'Woondum National Park offers many nature-based opportunities for the visitor to explore and enjoy the natural surrounds. (parks.des.qld.gov.au)'
    ,
    NULL,
    NULL,
    NULL
);

COMMIT;