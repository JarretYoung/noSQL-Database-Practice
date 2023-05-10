--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SET ECHO ON
SPOOL sql_portfolio2_basic_intermediate_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio2_basic_intermediate.sql

--Student ID:
--Student Name:
--Unit Code:
--Tutorial Class No:


/*1*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT maint_id, to_char(maint_datetime, 'dd-Mon-yyyy HH24:MI') AS maintainence_datetime, prop_address, owner_givname || ' ' || owner_famname as "Owner Name", maint_desc, maint_cost
    FROM RENT.MAINTENANCE NATURAL JOIN RENT.PROPERTY NATURAL JOIN RENT.OWNER
    WHERE maint_cost BETWEEN 1000 AND 3000 AND UPPER(maint_assigned) = UPPER('Y')
    ORDER BY maint_cost DESC, to_date(maint_datetime, 'dd-Mon-yyyy HH24:MI') DESC;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT R.rent_agreement_no, 
    T.tenant_no, T.tenant_title || ' ' || T.tenant_givname || ' ' || T.tenant_famname as "Tenant Name", 
    P.prop_address, O.owner_givname || ' ' || O.owner_famname as "Owner Name", 
    R.rent_lease_period || ' months' as "Rent Lease Period"
    FROM RENT.OWNER O JOIN RENT.PROPERTY P ON O.owner_no = P.owner_no JOIN RENT.RENT R ON P.prop_no = R.prop_no JOIN RENT.TENANT T ON R.tenant_no = T.tenant_no
    WHERE to_char(rent_lease_start,'yyyy') = 2022 AND rent_weekly_rate <425 AND rent_lease_period >= 6
    ORDER BY rent_lease_period DESC, tenant_no;

/*3*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
                                                                            
SELECT  tenant_no, 
        tenant_title || '. ' || tenant_givname || ' ' || tenant_famname as "Tenant Name",
        count(*) as num_of_damages, 
        to_char(sum(dam_cost), '$9990.99') as total_dam_cost 
    FROM RENT.TENANT JOIN RENT.RENT USING (tenant_no) JOIN RENT.DAMAGE USING (rent_agreement_no)
    WHERE to_char(dam_datetime,'yyyy') = 2022
    GROUP BY tenant_no, tenant_title, tenant_givname, tenant_famname
    ORDER BY total_dam_cost DESC, tenant_no;

/*4*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT tenant_no, tenant_title || '. ' || tenant_givname || ' ' || tenant_famname as tenant_name, prop_no, prop_address, count(prop_no) as "number_of_rental_agreements"
    FROM RENT.TENANT JOIN RENT.RENT USING (tenant_no) JOIN RENT.PROPERTY USING (prop_no)  
    WHERE UPPER(prop_address) LIKE UPPER('%Tasmania') 
    GROUP BY tenant_no, tenant_title, tenant_givname, tenant_famname, prop_no, prop_address HAVING count(prop_no) > 1
    ORDER BY tenant_no;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF