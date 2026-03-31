---1. Viewing the entire table
SELECT*
FROM workspace.default.bshop_case_study;

---2. Counting the number of transactions (total of 149116 transactions)
SELECT COUNT(*)
FROM workspace.default.bshop_case_study;

---3 Checking the first and last transaction dates (first: 1 Jan 2023 and last: 30 June 2023)
SELECT MIN(transaction_date) AS first_transaction_date,
      MAX(transaction_date) AS last_transaction_date
FROM workspace.default.bshop_case_study;

---4. Checking the different store locations (3 different store locations)
SELECT DISTINCT store_location
FROM workspace.default.bshop_case_study;

---5. Checking the different products sold at the different stores (9 different products)
SELECT DISTINCT product_category
FROM workspace.default.bshop_case_study;

---6. Checking the different product types sold at the different stores (29 different product types)
SELECT DISTINCT product_type
FROM workspace.default.bshop_case_study;

---7. Checking the different product details sold at the different stores (80 different product details)
SELECT DISTINCT product_detail
FROM workspace.default.bshop_case_study;

---8. Checking for NULLS in the various columns
SELECT*
FROM workspace.default.bshop_case_study
WHERE unit_price IS NULL
OR transaction_qty IS NULL
OR transaction_date IS NULL
OR transaction_id IS NULL;

---9. Checking for the lowest and highest unit price
SELECT MIN(unit_price) AS cheapest_price,
       MAX(unit_price) AS most_expensive_price
FROM workspace.default.bshop_case_study;

---10. Extracting the day and month names
SELECT transaction_date,
       Dayname(transaction_date) AS day_name,
       Monthname(transaction_date) AS month_name
FROM workspace.default.bshop_case_study;

---11. Calculating the Revenue
SELECT transaction_qty,
       unit_price,
       transaction_qty*unit_price AS Revenue
FROM workspace.default.bshop_case_study;

---12. Big query to clean up the entire data set
SELECT transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
       Dayname(transaction_date) AS day_name,
       Monthname(transaction_date) AS month_name,
       Dayofmonth(transaction_date) AS day_of_month,
   CASE
       WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
       ELSE 'Weekday'
    END AS day_classification,
   CASE
       WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '08:59:59' THEN 'Early_Morning'
       WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN 'Late_Morning'
       WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
       WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00' AND '18:00:00' THEN 'Evening'
       ELSE 'Night'
    END AS time_classification,
   CASE
       WHEN (transaction_qty*unit_price) <= 50 THEN 'Low_Spend'
       WHEN (transaction_qty*unit_price) BETWEEN 51 AND 100 THEN 'Medium_Spend'
       WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN 'High_Spend'
       ELSE 'Very_High_Spend'
    END AS spend_bucket,
    transaction_qty*unit_price AS Revenue
FROM workspace.default.bshop_case_study;
