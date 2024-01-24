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

# Retrieve the name and email of customers from Canada using both subqueries and joins. 
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



