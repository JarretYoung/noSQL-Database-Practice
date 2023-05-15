/*
  Databases 2023 S1 Assignment 2A
  --TimeShare Australia File and Initial Data--
  --tsa_schema_insert.sql
  
  Description: 
  This file creates the TimeShare Australia tables 
  and populates several of the tables (those shown in purple on the supplied model). 
  You should read this schema file carefully 
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
  
*/

DROP TABLE booking CASCADE CONSTRAINTS PURGE;

DROP TABLE cabin CASCADE CONSTRAINTS PURGE;

DROP TABLE company CASCADE CONSTRAINTS PURGE;

DROP TABLE member CASCADE CONSTRAINTS PURGE;

DROP TABLE member_charge CASCADE CONSTRAINTS PURGE;

DROP TABLE resort CASCADE CONSTRAINTS PURGE;

DROP TABLE staff CASCADE CONSTRAINTS PURGE;

DROP TABLE town CASCADE CONSTRAINTS PURGE;

CREATE TABLE company (
    company_abn        CHAR(11) NOT NULL,
    company_name       VARCHAR2(80) NOT NULL,
    company_ceo        VARCHAR2(40) NOT NULL,
    company_reg_office VARCHAR2(80) NOT NULL,
    company_phone      CHAR(10) NOT NULL
);

COMMENT ON COLUMN company.company_abn IS
    'Company ABN';

COMMENT ON COLUMN company.company_name IS
    'Company name';

COMMENT ON COLUMN company.company_ceo IS
    'Name of company CEO ';

COMMENT ON COLUMN company.company_reg_office IS
    'Registered office address of company';

COMMENT ON COLUMN company.company_phone IS
    'Contact number for company';

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( company_abn );

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

CREATE TABLE member_charge (
    member_id      NUMBER(6) NOT NULL,
    mc_year        DATE NOT NULL,
    mc_maintenance NUMBER(5) NOT NULL,
    mc_management  NUMBER(4) NOT NULL,
    mc_total       NUMBER(5) NOT NULL,
    mc_paid_date   DATE
);

COMMENT ON COLUMN member_charge.member_id IS
    'Unique member id across TSA';

COMMENT ON COLUMN member_charge.mc_year IS
    'Year charge is for';

COMMENT ON COLUMN member_charge.mc_maintenance IS
    'Maintenace charge for this member for this year';

COMMENT ON COLUMN member_charge.mc_management IS
    'Management charge for this member for this year';

COMMENT ON COLUMN member_charge.mc_total IS
    'Total charges to this member for this year';

COMMENT ON COLUMN member_charge.mc_paid_date IS
    'Date this years charge is paid';

ALTER TABLE member_charge ADD CONSTRAINT member_charge_pk PRIMARY KEY ( member_id,
                                                                        mc_year );

CREATE TABLE resort (
    resort_id               NUMBER(4) NOT NULL,
    resort_name             VARCHAR2(50) NOT NULL,
    resort_street_address   VARCHAR2(50) NOT NULL,
    resort_phone            VARCHAR2(10) NOT NULL,
    resort_yr_built_purch   DATE NOT NULL,
    resort_points_base_cost NUMBER(4) NOT NULL,
    town_id                 NUMBER(4) NOT NULL,
    company_abn             CHAR(11) NOT NULL
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

COMMENT ON COLUMN resort.town_id IS
    'Identifier for a town (surrogate)';

COMMENT ON COLUMN resort.company_abn IS
    'Company ABN';

ALTER TABLE resort ADD CONSTRAINT resort_pk PRIMARY KEY ( resort_id );

CREATE TABLE staff (
    staff_id    NUMBER(5) NOT NULL,
    staff_gname VARCHAR2(25),
    staff_fname VARCHAR2(25),
    staff_phone CHAR(10) NOT NULL,
    resort_id   NUMBER(4) NOT NULL
);

COMMENT ON COLUMN staff.staff_id IS
    'Staff identifier';

COMMENT ON COLUMN staff.staff_gname IS
    'Staff given name';

COMMENT ON COLUMN staff.staff_fname IS
    'Staff family name';

COMMENT ON COLUMN staff.staff_phone IS
    'Staff phone number';

COMMENT ON COLUMN staff.resort_id IS
    'Resort identifier';

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_id );

ALTER TABLE staff ADD CONSTRAINT staff_uq UNIQUE ( staff_phone );

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

ALTER TABLE resort
    ADD CONSTRAINT company_resort FOREIGN KEY ( company_abn )
        REFERENCES company ( company_abn );

ALTER TABLE resort
    ADD CONSTRAINT town_resort FOREIGN KEY ( town_id )
        REFERENCES town ( town_id );

ALTER TABLE staff
    ADD CONSTRAINT resort_staff FOREIGN KEY ( resort_id )
        REFERENCES resort ( resort_id );

ALTER TABLE member
    ADD CONSTRAINT resort_member FOREIGN KEY ( resort_id )
        REFERENCES resort ( resort_id );

ALTER TABLE member
    ADD CONSTRAINT member_recommends FOREIGN KEY ( member_id_recby )
        REFERENCES member ( member_id );

ALTER TABLE member_charge
    ADD CONSTRAINT member_member_charge FOREIGN KEY ( member_id )
        REFERENCES member ( member_id );

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
--INSERT INTO company
--------------------------------------
INSERT INTO company VALUES (
    77938124766,
    'Byron Holiday',
    'Lueilwitz Rempel',
    '151 Great Hwy, Byron, NSW',
    '0251204242'
);

INSERT INTO company VALUES (
    77108260455,
    'Wonderful Dessert Accommodation',
    'Osinski Schinner',
    '12 Alpaca Rd, Adelaide, SA',
    '0840001000'
);

INSERT INTO company VALUES (
    77863953491,
    'Australia Experience',
    'Schulist',
    '1 River Pde, Yarrawonga, VIC',
    '0325018001'
);

INSERT INTO company VALUES (
    77112675263,
    'Tropical Dream',
    'Borer Hill',
    '1 Puffin St, Townsville, QLD',
    '0841233000'
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
    1,
    77938124766
);

INSERT INTO resort VALUES (
    2,
    'Amazing Resort',
    '5B Lincoln Way',
    '0326415234',
    TO_DATE('2014', 'yyyy'),
    3000,
    9,
    77863953491
);

INSERT INTO resort VALUES (
    3,
    'Alice Springs Resort',
    '1 Wonderland Road',
    '0870003111',
    TO_DATE('2011', 'yyyy'),
    4000,
    5,
    77108260455
);

INSERT INTO resort VALUES (
    4,
    'Awesome Resort',
    '1 Crystal Clear Road',
    '0853246725',
    TO_DATE('2008', 'yyyy'),
    4000,
    6,
    77108260455
);

INSERT INTO resort VALUES (
    5,
    'Byron Bay Super Resort',
    '675 Lennon Street',
    '0224811234',
    TO_DATE('2016', 'yyyy'),
    4000,
    1,
    77938124766
);

INSERT INTO resort VALUES (
    6,
    'Gympie Luxury Resort',
    '1234 Gympie Hwy',
    '0745703124',
    TO_DATE('2014', 'yyyy'),
    6000,
    4,
    77112675263
);

INSERT INTO resort VALUES (
    7,
    'Taree Exclusive Resort',
    '78 Station Road',
    '0243012123',
    TO_DATE('2014', 'yyyy'),
    5000,
    8,
    77863953491
);

INSERT INTO resort VALUES (
    8,
    'King Resort at Kingaroy',
    '23A Town Road',
    '0746101231',
    TO_DATE('2018', 'yyyy'),
    6000,
    3,
    77112675263
);

INSERT INTO resort VALUES (
    9,
    'Queen Resort',
    '45 Mount Isa Road',
    '0748253123',
    TO_DATE('2017', 'yyyy'),
    4000,
    7,
    77112675263
);

INSERT INTO resort VALUES (
    10,
    'Awesome Resort',
    '40 Moonlight Road',
    '0228503123',
    TO_DATE('2018', 'yyyy'),
    6000,
    2,
    77108260455
);

--------------------------------------
--INSERT INTO member
--------------------------------------

INSERT INTO member VALUES (
    1,
    7,
    1,
    'Indiana',
    'Perrier',
    '62 Cornish Street, Deer Park East, VIC',
    'Indiana.Perrier@rhyta.com',
    '0397320999',
    TO_DATE('03/04/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    2,
    1,
    1,
    'Florida',
    'Goldhawk',
    '904 Talmadge Lane, Belgrave, VIC',
    'f.goldhawk@msn.com',
    '0454762942',
    TO_DATE('23/04/2022', 'dd/mm/yyyy'),
    2000,
    NULL
);

INSERT INTO member VALUES (
    3,
    4,
    1,
    'Lois',
    'Hawkshaw',
    '7480 Center Crossing, Auldana, SA',
    'LHawkshaw@abc.com',
    '0458708402',
    TO_DATE('04/05/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    4,
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
    5,
    7,
    2,
    'Haleigh',
    'Bonifacio',
    '1 Del Mar Avenue, Malvern East, VIC',
    'bonifacio@klok.com',
    '0483204123',
    TO_DATE('15/05/2022', 'dd/mm/yyyy'),
    2000,
    2
);

INSERT INTO member VALUES (
    6,
    7,
    3,
    'Rose',
    '',
    '10 Eurack Court, Murringo, NSW',
    'rosey@hotmail.com',
    '0400123124',
    TO_DATE('15/05/2022', 'dd/mm/yyyy'),
    1000,
    2
);

INSERT INTO member VALUES (
    7,
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
    8,
    1,
    2,
    'Henry',
    '',
    '32 Narrow Lane, Parramatta, NSW',
    'thegreathenry@abc.com',
    '0454312423',
    TO_DATE('02/06/2022', 'dd/mm/yyyy'),
    1000,
    1
);

INSERT INTO member VALUES (
    9,
    1,
    3,
    'Clarisa',
    'Pens',
    '4 Kumara St, Goulburn, NSW',
    'cl_pens@hotmail.com',
    '0431175134',
    TO_DATE('02/06/2022', 'dd/mm/yyyy'),
    1000,
    1
);

INSERT INTO member VALUES (
    10,
    3,
    1,
    'Claire',
    'Busby',
    '1 Kinsman Terrace, Kalgoorlie WA',
    'ClaireBusby@teleworm.us',
    '0737920423',
    TO_DATE('03/06/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    11,
    3,
    2,
    '',
    'Dalley',
    '328 Forest Pass, Melbourne,VIC',
    'Dalley@rhyta.com',
    '0393090563',
    TO_DATE('02/07/2022', 'dd/mm/yyyy'),
    1000,
    10
);

INSERT INTO member VALUES (
    12,
    4,
    2,
    'Reinald',
    'Sedwick',
    '2422 Calypso Circle, Leongatha, VIC',
    'Reinald.Sedwick@jlmonth.com',
    '0489832003',
    TO_DATE('02/07/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    13,
    5,
    1,
    'Jobie',
    '',
    '03 New Castle Center, Castle Hill, NSW',
    'jo_b@xyz.com',
    '0475732154',
    TO_DATE('07/07/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    14,
    3,
    3,
    'Sofia',
    'Dobie',
    '3 Brown Street, Greenwich, NSW',
    'SofiaDobie@teleworm.us',
    '0449670746',
    TO_DATE('09/07/2022', 'dd/mm/yyyy'),
    1000,
    11
);

INSERT INTO member VALUES (
    15,
    8,
    1,
    'Zac',
    'Somers',
    '58 Sunnyside Road, Lowbank, SA',
    'ZacSomers@armyspy.com',
    '0487765061',
    TO_DATE('17/08/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    16,
    8,
    2,
    'Bella',
    'Hagelthorn',
    '68 Yarra Street, Strathlea, VIC',
    'BellaHagelthorn@jourrapide.com',
    '0453220241',
    TO_DATE('17/08/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    17,
    9,
    1,
    'Samantha',
    'Glenny',
    '57 Ghost Hill Road. Nelson, NSW',
    'SamanthaGlenny@dayrep.com',
    '0447965426',
    TO_DATE('03/09/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    18,
    9,
    2,
    'Noah',
    'Garrard',
    '3 Insignia Way, Kalgoorlie, WA',
    'NoahGarrard@armyspy.com',
    '0490144199',
    TO_DATE('03/09/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    19,
    9,
    3,
    'Ella',
    'Walling',
    '86 William Road, Borroloola, NT',
    'EllaWalling@rhyta.com',
    '0489110274',
    TO_DATE('10/09/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    20,
    6,
    1,
    '',
    'Rochelle',
    '10 Forest Dale Terrace, Melbourne, VIC',
    'rochelle@pphy.com',
    '0409646679',
    TO_DATE('10/09/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    21,
    6,
    2,
    'Danila',
    'Geraldo',
    '9 Londonderry Parkway, Chatswood, NSW',
    'Danila.G@msn.com',
    '0464179129',
    TO_DATE('11/09/2022', 'dd/mm/yyyy'),
    1000,
    20
);

INSERT INTO member VALUES (
    22,
    3,
    4,
    'Oscar',
    'Lassetter',
    '91 Cornish Street, Altona East, VIC',
    'OscarLassetter@jourrapide.com',
    '0267125638',
    TO_DATE('16/09/2022', 'dd/mm/yyyy'),
    1000,
    NULL
);

INSERT INTO member VALUES (
    23,
    9,
    4,
    'Dylan',
    'Hargrave',
    '19 Glenpark Road, Sawtell, NSW',
    'DylanHargrave@rhyta.com',
    '0467824832',
    TO_DATE('02/10/2022', 'dd/mm/yyyy'),
    1000,
    17
);

INSERT INTO member VALUES (
    24,
    5,
    2,
    'Margaret',
    'Pheazey',
    '64201 Carey Circle, Mascot, NSW',
    'maggie@rhyta.com',
    '047551231',
    TO_DATE('04/10/2022', 'dd/mm/yyyy'),
    1000,
    13
);

--------------------------------------
--INSERT INTO member_charge
--------------------------------------
INSERT INTO member_charge VALUES (
    1,
    TO_DATE('2022', 'yyyy'),
    4000,
    1500,
    5500,
    TO_DATE('01/03/2023', 'DD/MM/YYYY')
);

INSERT INTO member_charge VALUES (
    8,
    TO_DATE('2022', 'yyyy'),
    2000,
    1500,
    5500,
    TO_DATE('28/02/2023', 'DD/MM/YYYY')
);

INSERT INTO member_charge VALUES (
    9,
    TO_DATE('2022', 'yyyy'),
    2000,
    1500,
    5500,
    NULL
);

INSERT INTO member_charge VALUES (
    4,
    TO_DATE('2022', 'yyyy'),
    2500,
    1800,
    4300,
    TO_DATE('03/04/2023', 'DD/MM/YYYY')
);

INSERT INTO member_charge VALUES (
    7,
    TO_DATE('2022', 'yyyy'),
    2500,
    1800,
    4300,
    TO_DATE('04/04/2023', 'DD/MM/YYYY')
);

INSERT INTO member_charge VALUES (
    2,
    TO_DATE('2022', 'yyyy'),
    4500,
    1650,
    5150,
    NULL
);

INSERT INTO member_charge VALUES (
    5,
    TO_DATE('2022', 'yyyy'),
    2250,
    1650,
    3900,
    NULL
);

INSERT INTO member_charge VALUES (
    6,
    TO_DATE('2022', 'yyyy'),
    2500,
    1650,
    3900,
    NULL
);

--------------------------------------
--INSERT INTO staff
--------------------------------------
INSERT INTO staff VALUES (
    1,
    'Martainn',
    'Jenteau',
    '0495300384',
    1
);

INSERT INTO staff VALUES (
    2,
    'Kipp',
    '',
    '0468858093',
    1
);

INSERT INTO staff VALUES (
    3,
    'Jessi',
    'Allward',
    '0438843662',
    2
);

INSERT INTO staff VALUES (
    4,
    'Rosalinda',
    'Zavattiero',
    '0423163212',
    2
);

INSERT INTO staff VALUES (
    5,
    'Neda',
    'Mylchreest',
    '0409562816',
    3
);

INSERT INTO staff VALUES (
    6,
    '',
    'Yakolev',
    '0496667027',
    3
);

INSERT INTO staff VALUES (
    7,
    'Weston',
    'Stearndale',
    '0417905216',
    3
);

INSERT INTO staff VALUES (
    8,
    'Reeba',
    'Wildman',
    '0493427245',
    4
);

INSERT INTO staff VALUES (
    9,
    'Marlee',
    'Champerlen',
    '0427832032',
    4
);

INSERT INTO staff VALUES (
    10,
    'Dorette',
    '',
    '0487345845',
    5
);

INSERT INTO staff VALUES (
    11,
    'Westley',
    'Oakenford',
    '0418289108',
    6
);

INSERT INTO staff VALUES (
    12,
    '',
    'Moisey',
    '0429418600',
    6
);

INSERT INTO staff VALUES (
    13,
    'Jordan',
    'Woodful',
    '0432371918',
    7
);

INSERT INTO staff VALUES (
    14,
    'Archer',
    'Rylah',
    '0461987248',
    7
);

INSERT INTO staff VALUES (
    15,
    'Brodie',
    'Townsend',
    '0449543875',
    8
);

INSERT INTO staff VALUES (
    16,
    'Ella',
    '',
    '0430090563',
    8
);

INSERT INTO staff VALUES (
    17,
    'Hunter',
    'Beach',
    '0440163890',
    9
);

INSERT INTO staff VALUES (
    18,
    'Georgia',
    'Brazier',
    '0440942117',
    10
);

COMMIT;