--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-tsa-dm.sql

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

--3(a)
DROP SEQUENCE booking_seq;
CREATE SEQUENCE booking_seq START WITH 100 INCREMENT BY 10;

--3(b) 
INSERT INTO CABIN values (
    (SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') ),
    4,4,10,'I',25,'Underground Cabin');

--3(c)
INSERT INTO BOOKING values ((booking_seq.nextVal), 
    (SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') ), 
    4, 
    to_date('26-May-2023', 'dd-Mon-yyyy'), 
    to_date('28-May 2023','dd-Mon-yyyy'),
    4,
    4, 
    (SELECT(cabin_points_cost_day*(to_date('28-May 2023','dd-Mon-yyyy')-to_date('26-May-2023', 'dd-Mon-yyyy'))) FROM CABIN WHERE resort_id = ((SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') )) AND cabin_no = '4'),
    (SELECT member_id FROM MEMBER WHERE resort_id = '9' AND member_no = '2'),
    (SELECT staff_id FROM STAFF WHERE staff_gname = 'Reeba' AND staff_fname = 'Wildman' AND staff_phone = '0493427245' AND resort_id = ((SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') ))));
commit; -- ask how many commits there needs to be

--3(d)
UPDATE BOOKING 
    SET booking_to = booking_to+1,
        booking_total_points_cost = booking_total_points_cost + (SELECT(cabin_points_cost_day) FROM CABIN WHERE resort_id = ((SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') )) AND cabin_no = '4')
        WHERE booking_id = (SELECT(booking_id) FROM BOOKING WHERE resort_id = (SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') ) AND cabin_no = 4 and to_date(booking_from) = to_date('26-May-2023', 'dd-Mon-yyyy'));
commit;
--3(e)
DELETE FROM BOOKING 
    WHERE resort_id = (SELECT(resort_id) FROM RESORT WHERE UPPER(resort_name) = UPPER('Awesome Resort') AND town_id = (SELECT town_id FROM TOWN WHERE UPPER(town_name) = UPPER('Broome') AND town_lat = '-17.9644' AND town_long = '122.2304') ) AND
            cabin_no = '4' AND
            to_date(booking_from) > to_date('4-May-2023', 'dd-Mon-yyyy');
commit;                        
            
