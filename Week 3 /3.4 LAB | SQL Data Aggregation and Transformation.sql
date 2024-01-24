
# CHALLENGE 1 

# You need to use SQL built-in functions to gain insights relating to the duration of movies:

USE sakila;

# 1.1 Determine the shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM 
    film;

# 1.2 Express the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, #FLOOR takes any decimal and drops it to the nearest integer; it rounds down. e.g. 2.6 would become 2 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM 
    film;

# You need to gain insights related to rental dates:

# 2.1 Calculate the number of days that the company has been operating.
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
    MIN(rental_date) AS earliest_rental_date, 
    MAX(rental_date) AS latest_rental_date,
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS date_difference
FROM rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental_date,
    MONTH(rental_date) AS rental_month,
    CASE 
        WHEN MONTH(rental_date) = 1 THEN 'JANUARY'
        WHEN MONTH(rental_date) = 2 THEN 'FEBRUARY'
        WHEN MONTH(rental_date) = 3 THEN 'MARCH'
        WHEN MONTH(rental_date) = 4 THEN 'APRIL'
        WHEN MONTH(rental_date) = 5 THEN 'MAY'
        WHEN MONTH(rental_date) = 6 THEN 'JUNE'
        WHEN MONTH(rental_date) = 7 THEN 'JULY'
        WHEN MONTH(rental_date) = 8 THEN 'AUGUST'
        WHEN MONTH(rental_date) = 9 THEN 'SEPTEMBER'
        WHEN MONTH(rental_date) = 10 THEN 'OCTOBER'
        WHEN MONTH(rental_date) = 11 THEN 'NOVEMBER'
        WHEN MONTH(rental_date) = 12 THEN 'DECEMBER'
    END AS month_name,
    DAYNAME(rental_date) AS rental_weekday
FROM rental 
LIMIT 20;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
# Hint: use a conditional expression.

SELECT 
    rental_date,
    MONTH(rental_date) AS rental_month,
    CASE 
        WHEN MONTH(rental_date) = 1 THEN 'JANUARY'
        WHEN MONTH(rental_date) = 2 THEN 'FEBRUARY'
        WHEN MONTH(rental_date) = 3 THEN 'MARCH'
        WHEN MONTH(rental_date) = 4 THEN 'APRIL'
        WHEN MONTH(rental_date) = 5 THEN 'MAY'
        WHEN MONTH(rental_date) = 6 THEN 'JUNE'
        WHEN MONTH(rental_date) = 7 THEN 'JULY'
        WHEN MONTH(rental_date) = 8 THEN 'AUGUST'
        WHEN MONTH(rental_date) = 9 THEN 'SEPTEMBER'
        WHEN MONTH(rental_date) = 10 THEN 'OCTOBER'
        WHEN MONTH(rental_date) = 11 THEN 'NOVEMBER'
        WHEN MONTH(rental_date) = 12 THEN 'DECEMBER'
    END AS month_name,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental 
LIMIT 20;

# 3 You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. 
# Sort the results of the film title in ascending order.

SELECT title,
IFNULL(length, 'Not available') AS length
FROM film
ORDER BY title; 

# CHALLENGE 2 

# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.

SELECT COUNT(distinct film_id) 
FROM film;  

# 1.2 The number of films for each rating.

SELECT COUNT(distinct rating)
FROM film;  

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY count(film_id) DESC; 

# 2 Using the film table, determine:

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT 
    FORMAT(AVG(ROUND(length, 2)), 2) AS average_length,
    rating
FROM film
GROUP BY rating
ORDER BY average_length DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
    FORMAT(AVG(ROUND(length, 2)), 2) AS average_length,
    rating
FROM film
GROUP BY rating
HAVING average_length > 120 
ORDER BY average_length DESC

#3 Bonus: determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
