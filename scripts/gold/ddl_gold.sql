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


	SELECT TOP 20 * FROM gold.dim_customer_reviews;--To confirm/check the quality


-------------------------------------------------------------------------------------------

--i noticed i still had nulls in my silver_layer customers table
SELECT * from [dbo].[silver_cust_review] ----i ran this to confirm the null
	where full_name is null
	UPDATE [dbo].[silver_cust_review]--- ran this to replace the null with unknown
	SET full_name= 'Unknown'
	WHERE full_name IS NULL

	SELECT TOP 20 * FROM gold.dim_customer_reviews;--To confirm/check the quality

	SELECT * FROM gold.fact_transaction----To ccheck for the quality

	
	---Check if all the dimension tables can successfully join the fact table[Foreign key intergrity(dimensions)]
	SELECT *
	FROM [gold].[fact_transaction] f
	LEFT JOIN [gold].[dim_customers] ci
	ON ci.customer_key = f.customer_key
	LEFT JOIN [gold].[dim_customer_reviews] r
	ON r.customer_key = f.customer_key
	WHERE ci.customer_key IS NULL
	
----------------------------------------------------------------------------------------------

SELECT * FROM [dbo].[silver_cust]

SELECT * FROM [gold].[dim_customers]

