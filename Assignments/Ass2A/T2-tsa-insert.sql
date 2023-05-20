/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-tsa-insert.sql

--Student ID:       31862616
--Student Name:     Garret Yong Shern Min
--Unit Code:        FIT3171
--Applied Class No: 06

/* Comments for your marker:




*/

---**This command shows the outputs of triggers**---
---**Run the command before running the insert statements.**---
---**Do not remove**---
SET SERVEROUTPUT ON
---**end**---

--------------------------------------
--INSERT INTO cabin
--------------------------------------
INSERT INTO CABIN values (1,1,4,1,'I',200,'Lakeside Cabin'); -- 1
INSERT INTO CABIN values (1,2,3,2,'I',300,'Lakeside Cabin');
INSERT INTO CABIN values (1,3,2,3,'I',400,'Lakeside Cabin');
INSERT INTO CABIN values (1,4,1,4,'C',500,'Lakeside Cabin');
INSERT INTO CABIN values (1,5,4,1,'C',600,'Lakeside Cabin'); -- 5

INSERT INTO CABIN values (2,1,4,1,'I',200,'Campsite Cabin'); -- 6
INSERT INTO CABIN values (2,2,3,2,'I',300,'Campsite Cabin');
INSERT INTO CABIN values (2,3,2,3,'I',400,'Campsite Cabin');
INSERT INTO CABIN values (2,4,1,4,'C',500,'Campsite Cabin');
INSERT INTO CABIN values (2,5,4,1,'C',600,'Campsite Cabin'); -- 10

INSERT INTO CABIN values (3,1,4,1,'I',200,'Cabin in the woods'); -- 11
INSERT INTO CABIN values (3,2,3,2,'I',300,'Cabin in the woods');
INSERT INTO CABIN values (3,3,2,3,'I',400,'Cabin in the woods'); -- 13

INSERT INTO CABIN values (4,1,4,1,'I',200,'Treetop Cabin'); -- 14
INSERT INTO CABIN values (4,2,3,2,'I',300,'Treetop Cabin');
INSERT INTO CABIN values (4,3,2,3,'I',400,'Treetop Cabin'); -- 16

INSERT INTO CABIN values (5,1,4,1,'I',200,'Farmstay Cabin'); -- 17
INSERT INTO CABIN values (5,2,3,2,'I',300,'Farmstay Cabin');
INSERT INTO CABIN values (5,3,2,3,'I',400,'Farmstay Cabin'); -- 19

INSERT INTO CABIN values (6,1,2,3,'C',900,'Urban Cabin'); -- 20

commit; --check again if need many or one commit
--------------------------------------
--INSERT INTO booking
--------------------------------------
-- ? Involved at least 10 cabins in 5 different resorts
    --? at least 3 of these cabins must be booked at least three times
--? Involve at least 10 different members
    --? at least 3 of these members have more than one booking

-- at least 3 of these members have more than one booking
-- at least 3 of these cabins must be booked at least three times
    -- Resort 1 | Cabin 1 | Member 2 | Staff 1
INSERT INTO BOOKING values (1,1,1,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,0,400,2,1); -- 1             
INSERT INTO BOOKING values (2,1,1,to_date( '4-Mar-2023', 'dd-Mon-yyyy'), to_date( '6-Mar-2023', 'dd-Mon-yyyy'),1,0,400,2,1); -- 2  
    -- Resort 2 | Cabin 2 | Member 4 | Staff  3
INSERT INTO BOOKING values (3,2,2,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,1,600,4,3); -- 3             
INSERT INTO BOOKING values (4,2,2,to_date( '4-Mar-2023', 'dd-Mon-yyyy'), to_date( '6-Mar-2023', 'dd-Mon-yyyy'),2,0,600,4,3); -- 4 
    -- Resort 3 | Cabin 3 | Member 10 | Staff  5
INSERT INTO BOOKING values (5,3,3,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),2,1,800,10,5); -- 5             
INSERT INTO BOOKING values (6,3,3,to_date( '4-Mar-2023', 'dd-Mon-yyyy'), to_date( '6-Mar-2023', 'dd-Mon-yyyy'),1,2,800,10,5); -- 6 
    
    -- at least 3 of these cabins must be booked at least three times
    -- Members 8,7,11 to fill up above to make 3 bookings
INSERT INTO BOOKING values (7,1,1,to_date( '7-Apr-2023', 'dd-Mon-yyyy'), to_date( '9-Apr-2023', 'dd-Mon-yyyy'),1,0,400,8,1); -- 7 
INSERT INTO BOOKING values (8,2,2,to_date( '7-Apr-2023', 'dd-Mon-yyyy'), to_date( '9-Apr-2023', 'dd-Mon-yyyy'),1,1,600,7,3);
INSERT INTO BOOKING values (9,3,3,to_date( '7-Apr-2023', 'dd-Mon-yyyy'), to_date( '9-Apr-2023', 'dd-Mon-yyyy'),1,2,800,11,5); -- 9 

    -- Resort 5 | Cabin 1 | Member 13 | Staff  10
INSERT INTO BOOKING values (10,5,1,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,0,400,13,10); -- 10

    -- Resort 6 | Cabin 1 | Member 20 | Staff  12
INSERT INTO BOOKING values (11,6,1,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,0,1800,20,12); -- 11

    -- Resort 1 | Cabin 2-5 | Member 9 | Staff  1
INSERT INTO BOOKING values (12,1,2,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,0,600,9,1); -- 12
INSERT INTO BOOKING values (13,1,3,to_date( '4-Mar-2023', 'dd-Mon-yyyy'), to_date( '6-Mar-2023', 'dd-Mon-yyyy'),1,0,800,9,1); -- 13
INSERT INTO BOOKING values (14,1,4,to_date( '7-Mar-2023', 'dd-Mon-yyyy'), to_date( '9-Mar-2023', 'dd-Mon-yyyy'),1,0,1000,9,1); -- 14
INSERT INTO BOOKING values (15,1,5,to_date( '10-Mar-2023', 'dd-Mon-yyyy'), to_date( '12-Mar-2023', 'dd-Mon-yyyy'),1,0,1200,9,1); -- 15

    -- Resort 2 | Cabin 1,3,4,5 | Member 7 | Staff  3
INSERT INTO BOOKING values (16,2,1,to_date( '1-Mar-2023', 'dd-Mon-yyyy'), to_date( '3-Mar-2023', 'dd-Mon-yyyy'),1,0,400,7,3); -- 16
INSERT INTO BOOKING values (17,2,3,to_date( '4-Mar-2023', 'dd-Mon-yyyy'), to_date( '6-Mar-2023', 'dd-Mon-yyyy'),1,0,800,7,3); -- 17
INSERT INTO BOOKING values (18,2,4,to_date( '7-Mar-2023', 'dd-Mon-yyyy'), to_date( '9-Mar-2023', 'dd-Mon-yyyy'),1,0,1000,7,3); -- 18
INSERT INTO BOOKING values (19,2,5,to_date( '10-Mar-2023', 'dd-Mon-yyyy'), to_date( '12-Mar-2023', 'dd-Mon-yyyy'),1,0,1200,7,3); -- 19

    -- Resort 6 | Cabin 1 | Member 21 | Staff  12
INSERT INTO BOOKING values (20,6,1,to_date( '1-Apr-2023', 'dd-Mon-yyyy'), to_date( '3-Apr-2023', 'dd-Mon-yyyy'),1,0,1800,21,12); -- 20

commit; --check again if need many or one commit











