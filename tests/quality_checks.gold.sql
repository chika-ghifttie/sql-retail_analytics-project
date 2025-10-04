/*
====================================================================================
Quality Checks
====================================================================================
Script Purpose:
          This script performs quality checks to validate the integrity, consistency,
           and accuracy of the Gold Layer. These checks ensure:
          - Uniqueness of surrogate keys in dimension tables.
          - Referential Integrity between fact and dimension tables.
          - Validation of relationships in the data model for analytical purposes.

Usage Notes:
       -Run these checks after data loading Silver Layer.
      - Investigate and resolve any discrepancies dound during the checks.
================================================================================
*/

----======================================================================================
--Checking 'gold.dim_customers'
--==========================================================================================
-- Check for uniqueness of Customer Key in gold.dim_customers, 
-- Checked for Nulls too
-Expectation: No results

  SELECT
        customer_key,
        COUNT(*) AS duplicate_count 
  FROM gold.dim_customers

  -----------------------------------------------------------------------------------------------
 --- I ran this to confirm the NULL
  ------------------------------------------------------------------------------------------------
SELECT * from [dbo].[silver_cust_review] ----i ran this to confirm the null
	where full_name is null

  ---------------------------------------------------------------------------------------------
 --Ran this to replace the null with unknown
  ---------------------------------------------------------------------------------------------
	UPDATE [dbo].[silver_cust_review]
	SET full_name= 'Unknown'
	WHERE full_name IS NULL

----======================================================================================
--Checking 'gold.dim_customer_reviews'
--==========================================================================================
  -- To confirm/check the quality
 - Expectation: Preview (sample) of 20 records from the customer_review dimension 

  SELECT 
      TOP 20 * 
  FROM gold.dim_customer_reviews;

----======================================================================================
--Checking both dimension links correctly with the fact table
--==========================================================================================
- Expectation: No rows returned.

	SELECT *
	FROM [gold].[fact_transaction] f
	LEFT JOIN [gold].[dim_customers] ci
	ON ci.customer_key = f.customer_key
	LEFT JOIN [gold].[dim_customer_reviews] r
	ON r.customer_key = f.customer_key
	WHERE ci.customer_key IS NULL
	







