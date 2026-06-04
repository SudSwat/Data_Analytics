#Sakila:
use sakila;
-- 📈 Challenge 1: High-Value Inventory
-- The inventory manager wants to look at our movie catalog to understand replacement costs. We need to identify our high-value assets.
-- Your Task:Write a query that retrieves the title, description, and replacement_cost for all films in the film table that have a 
-- replacement_cost greater than 25.00. Sort the results so that the most expensive movies to replace appear at the very top.

SELECT title, description, replacement_cost FROM film WHERE replacement_cost > 25 ORDER BY replacement_cost DESC;

-- 🏪 Challenge 2: Target Marketing for Store 1
-- Our marketing team wants to run a local email campaign specifically targeting customers who belong to Store 1. 
-- They need a clean list of names and contact details to load into the email software.
-- Your Task:
-- Write a query to retrieve the first_name, last_name, and email of all customers from the customer table who are registered at store_id equal to 1.

SELECT first_name,last_name,email FROM customer WHERE store_id = 1;

-- 🕵️ Challenge 3: Tracking Down a Film
-- A customer came in looking for a specific movie, but they only remember part of the title. They know it starts with the word "AMADEUS". 
-- The front-desk clerk needs to find the full title and how long the movie is to see if it fits the customer's schedule.
-- Your Task:
-- Write a query to find the title and length (duration in minutes) from the film table for all movies where the title starts with "AMADEUS.

SELECT title,description,length FROM film WHERE title LIKE "amadeus%";
-- There is just one tiny detail regarding standard SQL syntax rules. While some database systems accept double quotes (") for text literals, 
-- standard SQL uses single quotes (') for text values, like 'AMADEUS%'. 
-- Double quotes are typically reserved for system identifiers, like table or column names with spaces

-- 🔍 Challenge 4: Auditing Unique Ratings
-- The store wants to review the target audience categories for our inventory. The inventory team needs a clean, quick list of all the different age ratings 
-- (such as PG, R, etc.) that exist in our film table. They do not want any duplicate values in the final list.
-- Your Task:
-- Write a query to retrieve a list of all unique values from the rating column in the film table.

SELECT DISTINCT rating FROM film;

-- (Note: In SQL, DISTINCT is a keyword that modifies the entire row rather than a function, so you do not even need the parentheses around the column name!
--  Writing it as SELECT DISTINCT rating works beautifully.)


-- 💵 Challenge 5: Analyzing Rental Terms
-- The store management is reviewing its pricing models. They need to analyze the standard rental durations we offer. The team wants to see a list of all unique 
-- rental durations (the number of days a customer can keep a movie) present in our catalog,and they want the list sorted from the shortest rental duration to the longest.
-- Your Task:
-- Write a query to retrieve the unique values from the rental_duration column in the film table, sorted in ascending order.

SELECT  DISTINCT rental_duration FROM film ORDER BY rental_duration;

-- 📉 Challenge 6: Managing Cheap Rentals
-- The store manager wants to create a special promotion for budget-friendly movies. We need to find all films that have a rental_rate of exactly 0.99 
-- and a duration (length) of less than 60 minutes.
-- Your Task:
-- Write a query to retrieve the title, rental_rate, and length from the film table that meet both of these conditions.

SELECT title,rental_rate,rental_duration FROM film WHERE rental_rate = 0.99 AND length < 60;


-- 📅 Challenge 7: Unreturned Rentals Tracking
-- The operations team wants to optimize inventory tracking. They need a list of recent rentals that do not have a recorded return date yet, 
-- indicating the movies are still out with customers.
-- Your Task:
-- Write a query to retrieve the rental_id, rental_date, and customer_id from the rental table where the return_date is missing or unknown.
select * from rental;
SELECT rental_id,rental_date,customer_id FROM rental WHERE return_date is null;

-- 🧮 Challenge 8: Price List Sorting
-- The store manager wants to look at our rental pricing tiers. They want a list of all films, but they need the results organized in a very specific way 
-- to analyze pricing structures.
-- Your Task:
-- Write a query to retrieve the title, rental_rate, and replacement_cost from the film table. Sort the results first by rental_rate in ascending 
-- order (cheapest to most expensive), and then for movies 
-- with the same rental rate, sort them by replacement_cost in descending order (highest asset value first).

select * from payment;
SELECT title,rental_rate,replacement_cost FROM film ORDER BY rental_rate,replacement_cost desc;


-- 🎬 Challenge 9: The Short Film Showcase
-- The store is planning a "Short Film Festival" to promote movies that customers can watch quickly. 
-- The event coordinator needs a list of the 5 shortest movies in our entire collection to feature on the promotional poster.
-- Your Task:
-- Write a query to retrieve the title and length from the film table. Sort the results so that the shortest movies appear first, 
-- and restrict the output to return only the first 5 movies.


-- -----------------------------------------------Session 1-------------------------------------------
-- List all columns for the film table (use SELECT *). Hint: return every row and column from film.
select * from film;

-- Select the film_id, title, and release_year for films released in 2006. Hint: use WHERE on release_year.
select film_id,title, release_year from film where release_year = 2006;

-- Show the first and last name of actors whose last_name is 'PALTROW' (case-insensitive if needed). Hint: use WHERE with last_name and SELECT specific columns.
select * from actor;
select first_name, last_name from actor where last_name = 'PALTROW';

-- Retrieve distinct film ratings that exist in the film table (no duplicates). Hint: use DISTINCT on rating.
select * from film;
select distinct(rating) from film;

-- List the top 5 longest films by length, showing film_id, title, and length. Hint: ORDER BY length DESC and LIMIT 5.
select * from film;
select film_id, title, length from film order by length desc limit 5;

-- Find all customers from city_id = 300 (or pick a valid city_id from your data) showing customer_id, first_name AS fname, last_name AS lname, and email. Hint: use aliases for first_name and last_name.
select * from address;
select c.customer_id,c.first_name as fname,c.last_name as lname,c.email 
from customer c join address a on c.address_id = a.address_id 
where a.city_id in (463,300,23);

select * from customer;
-- Show film_id, title, rental_rate for films where rental_rate > 2.99 and rental_duration = 3. Hint: combine multiple filters in WHERE.

select film_id,title,rental_rate,rental_duration from film where rental_rate > 2.99 and rental_duration =3;
select * from film;

-- Return the number of payments per customer_id for customer_id 1 through 10 (inclusive); show customer_id and payment_count. Hint: use SELECT customer_id, COUNT(*) AS payment_count FROM payment WHERE customer_id BETWEEN 1 AND 10 GROUP BY customer_id. (GROUP BY is allowed as basic aggregation.)
select c.customer_id, count(p.payment_id) 
from customer c 
join payment p on c.customer_id = p.payment_id where c.customer_id >= 1 and c.customer_id <= 10
group by c.customer_id;
# never do the group by customer_id if we are fetching the result from the same table since it is the primary key in the table

select customer_id, count(*) as payment_count from payment 
where customer_id >= 1 and customer_id <= 10
group by customer_id;


select * from payment;

-- Show inventory_id, film_id for inventory rows where store_id = 2, ordered by inventory_id ascending, but limit results to 20 rows. Hint: WHERE store_id = 2, ORDER BY inventory_id, LIMIT 20.
select * from inventory;

select inventory_id, film_id from inventory where store_id = 2 order by inventory_id asc limit 20;

-- Select DISTINCT city names from the city table where city name starts with 'S' (case-sensitive depends on collation); show city and country_id. Hint: use WHERE city LIKE 'S%' and DISTINCT if needed.
select * from city;

select distinct(city),country_id from city where city like "S%";

-- __________________________________________________________________________________________________________________________________________________________________
-- The Scenario: The marketing team wants to find all films that have a rental rate higher than the average rental rate of all movies in our inventory.
use sakila;

select title,rental_rate from film where rental_rate > (
select avg(rental_rate) avg_rental from film);

-- The store owner wants a high-level performance report for our staff. They want to see a list of our employees, how many total rentals each employee processed,
-- and they want this list sorted by the employee who processed the most rentals
with staff_performance as(
select st.first_name,st.last_name,count(r.inventory_id) as rental_count  from rental r
join staff st on st.staff_id = r.staff_id
group by st.first_name,st.last_name,r.staff_id
)
select first_name, last_name,rental_count
from staff_performance order by rental_count desc;

use sakila;
-- Write a query that selects customer_id, payment_id, and amount from the payment table. Add a fourth column that calculates the maximum (MAX) amount 
-- for each customer using the OVER() clause with a PARTITION BY on customer_id
select customer_id,payment_id,amount,max(amount) over( partition by customer_id) overall_max
from payment;


-- Category A: Subqueries & Derived Tables (Intermediate)
-- The Inactive List: "We need a list of all customer email addresses for customers who are currently marked as active in our system but haven't rented a 
-- single movie in the last 30 days."
select * from customer where active = 1 and customer_id not in
(
select customer_id from rental 
where rental_date >= date_sub((select max(rental_date) from rental),interval 30 day)
);


select * from rental where customer_id in (1,2,3,4,6,8,10) order by rental_date desc, customer_id;

-- Above Average Spend: "Show me the first and last names of customers whose total lifetime spending is strictly greater than the average lifetime spending 
-- of all customers."
select cust.first_name, cust.last_name,spending_greater_avg.total_spending from customer cust
join (
select customer_id,sum(amount)total_spending from payment
where amount > (select  avg(amount) avg_customer from payment)
group by customer_id
)spending_greater_avg on cust.customer_id = spending_greater_avg.customer_id;

select cust.first_name, cust.last_name,spending_greater_avg.total_spending from customer cust
join (
select customer_id,sum(amount)total_spending from payment
group by customer_id
having total_spending > (select  avg(total_lifetime_spend.total_payment) total_avg from 
(select sum(amount) as total_payment from payment group by customer_id) as total_lifetime_spend)
)spending_greater_avg on cust.customer_id = spending_greater_avg.customer_id; 

-- The Executive's Film Check: "Find the titles of all films that have a rental rate higher than the average rental rate of films specifically categorized under
-- 'Action'."
select f.film_id,f.title,f.rental_rate from film f
where f.rental_rate >(
select avg(rental_rate)action_avg_rental_rate from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
group by c.name having c.name = "Action");
-- Underperforming Inventory: "Identify the film_id and title of movies that exist in our inventory but have never been rented out even once."










-- Staff Milestone Tracking: "Provide the names of staff members who have processed more payment transactions than the average number of transactions processed 
-- per staff member."


-- The Heavy Renter Filter: "We want to target our top users. Give me a list of customers who have rented more movies than every single customer living in 'Canada'."



select * from customer custe
join address addr on addr.address_id = cust.address_id
join city cty on cty.city_id = addr.city_id
join country cntr on cntr.country_id = cty.country_id
where cntr.country = 'Canada';

select customer_id,count(rental_id) rent_count from rental group by customer_id order by rent_count desc; 






