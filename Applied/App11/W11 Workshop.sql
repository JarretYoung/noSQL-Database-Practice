set pagesize 300

SELECT
    JSON_OBJECT(
     'drone_id' VALUE drone_id,
     'type' VALUE JSON_OBJECT (
        'code' VALUE dt_code,
        'model' VALUE dt_model,
        'manufacturer' VALUE manuf_name
     ),
     'carrying_capacity' VALUE dt_carry_kg,
     'pur_date' VALUE to_char(drone_pur_date,'YYYY-MM-DD'),
     'pur_price' VALUE drone_pur_price,
     'total_flighttime' VALUE drone_flight_time,
     'cost_per_hour' VALUE drone_cost_hr,
     'RentalInfo' VALUE JSON_ARRAYAGG (
          JSON_OBJECT (
            'rent_no' VALUE rent_no,
            'bond' VALUE rent_bond,
            'rent_out' VALUE to_char(rent_out_dt,'YYYY-MM-DD'),
            'rent_in' VALUE to_char(rent_in_dt ,'YYYY-MM-DD'),
            'custtrain_id' VALUE ct_id
            )
            ORDER BY rent_no
         ) FORMAT JSON )
    || ','
FROM
    drone.rental
    NATURAL JOIN drone.drone
    NATURAL JOIN drone.drone_type
    NATURAL JOIN drone.manufacturer
GROUP BY
    drone_id,
    dt_code,
    dt_model,
    manuf_name,
    dt_carry_kg,
    drone_pur_date,
    drone_pur_price,
    drone_flight_time,
    drone_cost_hr
ORDER BY
    drone_id;