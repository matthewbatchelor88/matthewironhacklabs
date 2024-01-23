USE sakila; 

# 1 Display all tables from the Sakila database 

SHOW tables 
FROM sakila; 

# 2 Retrieve all the data from the tables actor, film, customer 

SELECT * 
FROM actor, film, customer;  

# 3 Retrieve the following columns from their respective tables

# 3.1. Titles of all films from the film table 

SELECT DISTINCT title
FROM film 

#3.2. List of languages used in films, with the column aliased as language from the language table

SELECT DISTINCT original_language_id AS language 
FROM film;  

#3.3. List of first names of all employes from the staff table 

SELECT first_name  
FROM staff; 

# 4 Retrieve unique release years 

SELECT DISTINCT release_year
FROM film; 

# 5 Counting records for database insights 

# 5.1. Determine the number of stores the company has

SELECT DISTINCT store_id
FROM store; 

# 5.2. Determine the number of employees the company has 

SELECT DISTINCT staff_id 
FROM staff; 

# 5.3. Determine how many films are available for rent and how many have been rented 

SELECT COUNT(DISTINCT film_id) 
FROM film; 

SELECT COUNT(DISTINCT film_id)
FROM film
WHERE rental_duration > 0;

# 5.4 Determine the number of distinct last names of the actors in the database 

SELECT COUNT(DISTINCT last_name) 
FROM actor; 

# 6 Retrieve the 10 longest films 

SELECT length, title, film_id
FROM film 
ORDER BY length DESC
LIMIT 10; 

# 7 Retrieve all actors with the first name "SCARLETT"

SELECT first_name, last_name 
FROM actor 
WHERE first_name = "SCARLETT"