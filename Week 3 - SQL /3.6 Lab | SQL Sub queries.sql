USE sakila; 

# 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(rental_id) 
FROM rental 
WHERE inventory_id IN (SELECT inventory_id 
						FROM inventory 
						WHERE film_id = (SELECT film_id
							FROM film 
							WHERE title = "Hunchback Impossible"));  

# 2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title 
FROM film
GROUP BY title 
HAVING  AVG(length) >= (SELECT AVG(length)
							FROM film); 

# 3 Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name
FROM actor
WHERE actor_id IN ( SELECT actor_id 
						FROM film_actor
						WHERE film_id =(SELECT film_id 
											FROM film 
											WHERE title = "Alone Trip")); 

# BONUS # 
                                            
# 4 Sales have been lagging among young families, and you want to target family movies for a promotion. 
# Identify all movies categorized as family films.

SELECT title
FROM film 
WHERE film_id IN (SELECT film_id 
						FROM film_category 
						WHERE category_id = (SELECT category_id
											FROM category
											WHERE name = "family"));  

# 5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT first_name, last_name, email 
FROM customer AS c
INNER JOIN address AS a 
ON c.address_id = a.address_id 
WHERE a.city_id IN (SELECT city_id 
						FROM city
							WHERE country_id = (SELECT country_id 
													FROM country 
                                                    WHERE country = "Canada")); 

# 7 Find the films rented by the most profitable customer in the Sakila database. 
# You can use the customer and payment tables to find the most profitable customer
# i.e. the customer who has made the largest sum of payments.

SELECT title
FROM film 
INNER JOIN inventory 
USING(film_id)
INNER JOIN rental 
USING(inventory_id)
INNER JOIN(payment) 
USING(customer_id) 
WHERE customer_id = (SELECT customer_id
					FROM payment
					GROUP BY customer_id
					ORDER BY SUM(amount) DESC
					LIMIT 1)
GROUP BY title; 

# Can we refactor this to use subqueries? Yes, as below. 

SELECT title 
FROM film 
WHERE film_id IN (SELECT film_id # In, not =, because this will return many results 
				FROM inventory
                WHERE inventory_id IN (SELECT inventory_id # In, not =, because this will return many results 
										FROM rental 
                                        WHERE customer_id = (SELECT customer_id
																FROM payment
																GROUP BY customer_id
																ORDER BY SUM(amount) DESC
																LIMIT 1)))
GROUP BY title; 

# 8 Retrieve the client_id and the total_amount_spent of those clients 
# who spent more than the average of the total_amount spent by each client. 
# You can use subqueries to accomplish this.

USE sakila; 

# Hint: Breaking down the problem: 
# We need to understand the average total spend per customer (i.e. grouped by customer_id) as opposed to average amount per spend
 

SELECT customer_id, SUM(amount) 
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > i # Here we need a subquery to find i, where i. is average sum amount 

# Now we build the 'child' query for i. 

	SELECT AVG(total_spent)			
	FROM (SELECT customer_id, SUM(amount) AS total_spent
		FROM payment 
		GROUP BY customer_id) AS t;  # When you use a subquery in a 'from', it needs to be named, hence 'as t' 

# Now we just need to join the 2 queries together as below: 

SELECT customer_id, SUM(amount) AS total_spent_p_c
FROM payment 
GROUP BY customer_id
HAVING total_spent_p_c > (SELECT AVG(total_spent)			
						FROM (SELECT customer_id, SUM(amount) AS total_spent
								FROM payment 
								GROUP BY customer_id) AS t)
ORDER BY total_spent_p_c DESC;
 
 

