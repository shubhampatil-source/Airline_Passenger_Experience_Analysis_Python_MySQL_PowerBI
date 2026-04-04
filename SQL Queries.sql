CREATE DATABASE airline_project;
use airline_project;
CREATE TABLE airline_passenger_experience (
    id INT,
    gender VARCHAR(20),
    customer_type VARCHAR(50),
    age INT,
    type_of_travel VARCHAR(50),
    class VARCHAR(30),
    flight_distance INT,
    inflight_wifi_service INT,
    departure_arrival_time_convenient INT,
    ease_of_online_booking INT,
    gate_location INT,
    food_and_drink INT,
    online_boarding INT,
    seat_comfort INT,
    inflight_entertainment INT,
    on_board_service INT,
    leg_room_service INT,
	baggage_handling INT,
    checkin_service INT,
    inflight_service INT,
    cleanliness INT,
    avg_service_rating DECIMAL(4,2),
    departure_delay_in_minutes INT,
    arrival_delay_in_minutes INT,   
    satisfaction VARCHAR(50),
    age_group VARCHAR(20),
    delay_flag VARCHAR(20),
    distance_bucket VARCHAR(30)
);
select*from airline_passenger_experience;

-- Q1. What is the overall satisfaction rate?
select round(sum(case when satisfaction = 'satisfied' then 1 else 0 end)*100 / count(*), 2) as satisfaction_rate,
round(sum(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end)*100 / count(*), 2) as dissatisfaction_rate
from airline_passenger_experience;

-- Q2. What is the average departure delay and arrival delay?
select round(avg(departure_delay_in_minutes),1) as average_departure_delay, 
round(avg(arrival_delay_in_minutes),1) as average_arrival_delay
from airline_passenger_experience;

-- Q3. What is the average service rating across all passengers?
select round(avg(avg_service_rating),1) as average_service_rating
from airline_passenger_experience;

-- Q4. What percentage of flights are delayed?
select round(sum(case when delay_flag = 'Delayed' then 1 else 0 end) * 100 / count(*), 2) as percent_flight_delay,
round(sum(case when delay_flag = 'On Time' then 1 else 0 end) * 100 / count(*), 2) as percent_flight_on_time
from airline_passenger_experience;

-- Q5. Which class has the highest satisfaction rate?
select class, round(sum(case when satisfaction = 'satisfied' then 1 else 0 end)*100 / count(*),2) as satisfaction_rate,
round(sum(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end)*100 / count(*),2) as neutral_or_dissatisfaction_rate
from airline_passenger_experience
group by class;

-- Q6. Which class has the lowest average service rating?
select class, round(avg(avg_service_rating),2) as average_service_rating
from airline_passenger_experience
group by class;

-- Q7. which class has lowest service_rating?
select class, round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience
group by class;

-- Q8. What is the satisfaction rate of loyal vs disloyal customers?
select customer_type, satisfaction_rate, neutral_or_dissatisfaction_rate,
neutral_or_dissatisfaction_rate - satisfaction_rate as percent_gap
from
(select customer_type, round(sum(case when satisfaction = 'satisfied' then 1 else 0 end)*100 / count(*),2) as satisfaction_rate,
round(sum(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end)*100 / count(*),2) as neutral_or_dissatisfaction_rate
from airline_passenger_experience
group by customer_type ) a ;

-- Q9. What is the dissatisfaction gap between loyal and disloyal customers?
select loyal_customer_dissatisfied_percent, disloyal_customer_dissatisfied_percent,
round(loyal_customer_dissatisfied_percent - disloyal_customer_dissatisfied_percent,2) as percent_gap
from (
select round(sum(case when customer_type = 'Loyal Customer' then 1 else 0 end)*100 / count(*),2) as loyal_customer_dissatisfied_percent,
round(sum(case when customer_type = 'disloyal Customer' then 1 else 0 end)*100 / count(*),2) as disloyal_customer_dissatisfied_percent
from airline_passenger_experience
where satisfaction = 'neutral or dissatisfied' ) a;

-- Q10.Do loyal customers experience lower delays or just tolerate them better?
select customer_type, round(avg(arrival_delay_in_minutes),2) as average_arrival_delay, 
round(avg(departure_delay_in_minutes),2) as average_departure_delay
from airline_passenger_experience
group by customer_type;

-- Q11.Which customer segment has lower service ratings?
select customer_type, round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience
group by customer_type;

-- Q12. What is the satisfaction rate for business travel vs personal travel?
select type_of_travel, satisfaction_rate, neutral_or_dissatisfaction_rate,
neutral_or_dissatisfaction_rate - satisfaction_rate as percent_gap
from
(select type_of_travel, round(sum(case when satisfaction = 'satisfied' then 1 else 0 end)*100 / count(*),2) as satisfaction_rate,
round(sum(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end)*100 / count(*),2) as neutral_or_dissatisfaction_rate
from airline_passenger_experience
group by type_of_travel ) a ;

-- Q13. Which travel type has worse average delays?
select type_of_travel, round(avg(arrival_delay_in_minutes),2) as average_arrival_delay, 
round(avg(departure_delay_in_minutes),2) as average_departure_delay
from airline_passenger_experience
group by type_of_travel;

-- Q14. Which travel type gives lower average service ratings?
select type_of_travel, round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience
group by type_of_travel;

-- Q15. What is satisfaction rate for delayed vs on-time flights?
select delay_flag, satisfaction_rate, neutral_or_dissatisfaction_rate,
neutral_or_dissatisfaction_rate - satisfaction_rate as percent_gap
from
(select delay_flag, round(sum(case when satisfaction = 'satisfied' then 1 else 0 end)*100 / count(*),2) as satisfaction_rate,
round(sum(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end)*100 / count(*),2) as neutral_or_dissatisfaction_rate
from airline_passenger_experience
group by delay_flag ) a ;

-- Q16. What is the average service rating for delayed vs on-time passengers?
select delay_flag, round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience
group by delay_flag;

-- Q17. Which class is most sensitive to delay in terms of satisfaction drop?
select class, 
round(sum(case when delay_flag = 'On Time' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when delay_flag = 'On Time' then 1 else 0 end),2) as on_time_satisfaction_rate,
round(sum(case when delay_flag = 'Delayed' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when delay_flag = 'Delayed' then 1 else 0 end),2) as delayed_satisfaction_rate,
round((sum(case when delay_flag = 'On Time' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when delay_flag = 'On Time' then 1 else 0 end)) 
- (sum(case when delay_flag = 'Delayed' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0 
/ sum(case when delay_flag = 'Delayed' then 1 else 0 end)),2) as satisfaction_drop
from airline_passenger_experience
group by class
order by satisfaction_drop desc;

-- Q18. Among delayed passengers, which segment has the worst satisfaction rate?
select class, round(sum(case when distance_bucket = 'Short Haul' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Short Haul' then 1 else 0 end),2) as short_haul_satisfaction_rate,
round(sum(case when distance_bucket = 'Medium Haul' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Medium Haul' then 1 else 0 end),2) as medium_haul_satisfaction_rate,
round(sum(case when distance_bucket = 'Long Haul' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Long Haul' then 1 else 0 end),2) as long_haul_satisfaction_rate,
round(sum(case when type_of_travel = 'Business travel' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when type_of_travel = 'Business travel' then 1 else 0 end),2) as business_travel_satisfaction_rate,
round(sum(case when type_of_travel = 'Personal travel' and satisfaction = 'satisfied' then 1 else 0 end) * 100.0
/ sum(case when type_of_travel = 'Personal travel' then 1 else 0 end),2) as personal_travel_satisfaction_rate
from airline_passenger_experience
where delay_flag = 'Delayed'
group by class;

-- Q19. Which service attribute has the lowest average rating overall?
select round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience;

-- Q20. Which service attribute shows the biggest rating gap between satisfied and dissatisfied passengers?
select satisfaction, round(avg(inflight_wifi_service), 2) as inflight_wifi_service, 
round(avg(departure_arrival_time_convenient), 2) as departure_arrival_time_convenient,
round(avg(ease_of_online_booking), 2) as ease_of_online_booking,
round(avg(gate_location), 2) as gate_location,
round(avg(food_and_drink), 2) as food_and_drink,
round(avg(online_boarding), 2) as online_boarding,
round(avg(seat_comfort), 2) as seat_comfort,
round(avg(inflight_entertainment), 2) as inflight_entertainment,
round(avg(on_board_service), 2) as on_board_service,
round(avg(leg_room_service), 2) as leg_room_service,
round(avg(baggage_handling), 2) as baggage_handling,
round(avg(checkin_service), 2) as checkin_service,
round(avg(inflight_service), 2) as inflight_service,
round(avg(cleanliness), 2) as cleanliness
from airline_passenger_experience
group by satisfaction;

-- Q21. Which class has the weakest online boarding rating?
select class, round(avg(online_boarding), 2) as online_boarding
from airline_passenger_experience
group by class;

-- Q22. Which segment has high dissatisfaction despite being on-time?
select class, round(sum(case when distance_bucket = 'Short Haul' and satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Short Haul' then 1 else 0 end),2) as short_haul_dissatisfaction_rate,
round(sum(case when distance_bucket = 'Medium Haul' and satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Medium Haul' then 1 else 0 end),2) as medium_haul_dissatisfaction_rate,
round(sum(case when distance_bucket = 'Long Haul' and satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100.0
/ sum(case when distance_bucket = 'Long Haul' then 1 else 0 end),2) as long_haul_dissatisfaction_rate,
round(sum(case when type_of_travel = 'Business travel' and satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100.0
/ sum(case when type_of_travel = 'Business travel' then 1 else 0 end),2) as business_travel_dissatisfaction_rate,
round(sum(case when type_of_travel = 'Personal travel' and satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100.0
/ sum(case when type_of_travel = 'Personal travel' then 1 else 0 end),2) as personal_travel_dissatisfaction_rate
from airline_passenger_experience
where delay_flag = 'On Time'
group by class;

-- Q23. Track passenger volume, dissatisfaction rate, avg arrival delay, avg service rating for each class, type of travel and customer type
select class, type_of_travel, customer_type, count(*) as passenger_volume,
round(avg(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100, 2) as dissatisfaction_rate,
round(avg(arrival_delay_in_minutes), 2) as avg_arrival_delay,
round(avg(avg_service_rating), 2) as avg_service_rating
from airline_passenger_experience
group by class, type_of_travel, customer_type
having count(*) >= 100
order by dissatisfaction_rate desc, avg_service_rating asc, passenger_volume desc;

-- Q24. Find passenger volume for each class
select class, count(id) as passanger_volume
from airline_passenger_experience
group by class;

-- Q25. Find passenger volume for each distance bucket
select distance_bucket, count(id) as passenger_volume
from airline_passenger_experience
group by distance_bucket;

-- Q26. Find passenger volume for personal and business travel
select type_of_travel, count(id) as passenger_volume
from airline_passenger_experience
group by type_of_travel;

-- Q27. For each class, type of travel and customer type find passenger volume, dissatisfaction rate, avg arrival delay, avg service rating
select class, type_of_travel, customer_type, count(*) as passenger_volume, 
round(avg(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100, 2) as dissatisfaction_rate, 
round(avg(avg_service_rating), 2) as avg_service_rating, round(avg(arrival_delay_in_minutes), 2) as avg_arrival_delay
from airline_passenger_experience
group by class, type_of_travel, customer_type
having count(*) >= 100
order by dissatisfaction_rate desc, passenger_volume desc;

-- Q28. On-time dissatisfaction segments
Select class, type_of_travel, customer_type, count(*) as passenger_volume,
round(avg(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100, 2) as dissatisfaction_rate, 
round(avg(avg_service_rating), 2) as avg_service_rating, round(avg(arrival_delay_in_minutes), 2) as avg_arrival_delay
from airline_passenger_experience
where delay_flag = 'on time'
group by class, type_of_travel, customer_type
having count(*) >= 100
order by dissatisfaction_rate desc, passenger_volume desc;


-- Q29. delayed dissatisfaction segments
select class, type_of_travel,  customer_type, count(*) as passenger_volume, round(avg(case when satisfaction = 'neutral or dissatisfied' then 1 else 0 end) * 100, 2) as dissatisfaction_rate, round(avg(avg_service_rating), 2) as avg_service_rating, round(avg(arrival_delay_in_minutes), 2) as avg_arrival_delay
from airline_passenger_experience
where delay_flag = 'delayed'
group by class, type_of_travel, customer_type
having count(*) >= 100
order by dissatisfaction_rate desc, passenger_volume desc;








