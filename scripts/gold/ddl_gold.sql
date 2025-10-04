/*
==========================================================================================
DDL Script: Gold Layer View Creation
==========================================================================================

Purpose:
    This script builds the **Gold Layer** views within the data warehouse architecture.  
    The Gold Layer serves as the presentation tier, containing the finalized **dimension**
    and **fact** tables arranged in a Star Schema for business analytics.

    Each view refines and integrates data from the **Silver Layer**, ensuring it is 
    clean, enriched, and optimized for reporting and data visualization.

Usage Notes:
    - These views can be queried directly for analytics and reporting.
==========================================================================================
*/




----======================================================================================
--Create Dimension: gold.dim_customers
--==========================================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
      DROP VIEW gold.dim_customers;
	  GO

CREATE VIEW gold.dim_customers AS
	SELECT 
	ROW_NUMBER()OVER(ORDER BY customer_id) AS customer_key,
	ci.customer_id AS customer_id,
	ci.fullname AS full_name,
	ci.age AS age,
	ci.gender AS gender,
	ci.email AS email,
	ci.phone AS phone_number,
	ci.street_address AS street_address,
	ci.city AS city,
	ci.state AS state,
	ci.zip_code AS zip_code,
	ci.preferred_channel AS preferred_channel,
	ci.registration_date AS registration_date
	FROM [dbo].[silver_cust] ci

      
----======================================================================================
--Create Dimension: gold.dim_customer_reviews
--==========================================================================================
IF OBJECT_ID('gold.dim_customer_reviews', 'V') IS NOT NULL
      DROP VIEW gold.dim_customer_reviews;
	  GO

CREATE VIEW gold.dim_customer_reviews AS
	SELECT 
	ROW_NUMBER() OVER(ORDER BY review_date,review_id) AS review_key,
	r.review_id AS review_id,
	ci.customer_key AS customer_key,
	r.full_name AS full_name,
	r.product_name AS product_name,
	r.product_category AS product_category,
	r.rating AS rating,
	r.review_title AS review_title,
	r.review_text AS review_text,
	r.transaction_date AS transaction_date,
	r.review_date AS review_date
	FROM [dbo].[silver_cust_review]r
	JOIN [gold].[dim_customers]ci
	ON r.customer_id=ci.customer_id


----=======================================================================================
--Create Dimension: gold.fact_transaction
--==========================================================================================
IF OBJECT_ID('gold.fact_transaction', 'V') IS NOT NULL
      DROP VIEW gold.fact_transaction
	  GO

CREATE VIEW gold.fact_transaction AS 
	SELECT 
	t.transaction_id AS transaction_id,
	ci.customer_key,
	t.product_name AS product_name,
	t.product_category AS product_category,
	t.store_location AS store_location,
	t.payment_method AS payment_method,
	t.transaction_date AS transaction_date,
	t.quantity AS quantity,
	t.price AS price,
	t.discount_applied AS discount_applied
	FROM [dbo].[silver_transactions]t
	LEFT JOIN [gold].[dim_customers]ci
	ON t.customer_id=ci.customer_id



	
