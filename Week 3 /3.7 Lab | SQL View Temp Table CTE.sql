# Creating a Customer Summary Report

# In this exercise, you will create a customer summary report that summarizes key information about customers in the Sakila database, including their rental history and payment details. The report will be generated using a combination of views, CTEs, and temporary tables.

# Step 1: Create a View
# First, create a view that summarizes rental information for each customer. 
# The view should include the customer's ID, name, email address, and total number of rentals (rental_count).

ALTER VIEW customer_rental_information AS  
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(r.rental_id) as rental_count 
FROM 
    customer c
INNER JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email;

SELECT * 
FROM customer_rental_information; 

# Step 2: Create a Temporary Table
# Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
# The Temporary Table should use the rental summary view created in Step 1 
# to join with the payment table and calculate the total amount paid by each customer.

CREATE TEMPORARY TABLE tppc AS 
SELECT 
    cri.customer_id,
    cri.first_name,
    cri.last_name,
    cri.email,
    cri.rental_count,
    SUM(p.amount) AS total_payment
FROM 
    customer_rental_information AS cri
INNER JOIN 
    payment AS p ON cri.customer_id = p.customer_id
GROUP BY 
    cri.customer_id, cri.first_name, cri.last_name, cri.email, cri.rental_count;

SELECT * 
FROM tppc; 

# Step 3: Create a CTE and the Customer Summary Report
# Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. 
# The CTE should include the customer's name, email address, rental count, and total amount paid.
# Next, using the CTE, create the query to generate the final customer summary report, which should include: 
# customer name, email, rental_count, total_paid and average_payment_per_rental, 
# this last column is a derived column from total_paid and rental_count.


SELECT
    cri.customer_id,
    cri.first_name,
    cri.last_name,
    cri.email,
    cri.rental_count,
    tppc.total_payment AS total_paid,
    tppc.total_payment / cri.rental_count AS average_payment_per_rental
FROM
    customer_rental_information cri
INNER JOIN
    tppc ON cri.customer_id = tppc.customer_id;