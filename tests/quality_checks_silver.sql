/*
============================================================================
  Quality Checks
============================================================================
 Script Purpose: 
        This script performs various quality checks for data consistency, accuracy, and standardization across 
        'silver' schema. It includes checks for:
           - Null or duplicate primary keys,
           - Data standardization and consistency,
           - Unwanted spaces in string fields.

  Usage: 
      - Run these checks after data loading Silver Layer
      - Find and resolve any discripancies found during the checks.
============================================================================
*/

--====================================================================
	--Checking silver_transaction
	--================================================================
	---Data Standardization & Consistency
		SELECT DISTINCT 
		discount_applied 
		FROM [dbo].[silver_transactions]
	
	--====================================================================
	--Checking silver_cust
	--================================================================
	---Data Standardization & Consistency
		SELECT DISTINCT 
		country
		FROM [dbo].[silver_cust]
	
	--====================================================================
	--Checking silver_cust_review
	--================================================================
	---Data Standardization & Consistency
		SELECT DISTINCT 
		product_name
		FROM [dbo].[silver_cust_review]
	
	--====================================================================
	--Checking silver_cust
	--================================================================
		--Check for where email column does not contain '@'
	SELECT * FROM [dbo].[bronze_cust]
	WHERE email NOT LIKE '%@%'


	--====================================================================
	--Checking silver_cust
	--================================================================
	--check for any character that is NOT a number (0–9).
	SELECT phone FROM [dbo].[silver_cust]
	WHERE phone LIKE '%[^0-9]%'


	--====================================================================
	--Checking silver_cust
	--================================================================
	--check for duplicate in customer_id
	SELECT
	customer_id,
	COUNT(*) AS No_count
	FROM [dbo].[silver_cust]
	GROUP BY customer_id
	HAVING COUNT(*) > 1 OR customer_id IS NULL

	--====================================================================
	--Checking silver_transaction
	--================================================================
	----To checkif my transaction_id has duplicate, or is null and it doesnt 
	SELECT transaction_id,
	COUNT(*)
	FROM [dbo].[silver_transactions]
	GROUP BY transaction_id 
	HAVING COUNT(*) > 1 OR transaction_id IS NULL


	--====================================================================
	--Checking silver_cust_review
	--================================================================
	---Checked if there are spaces in the product_category, i had to filter 
	SELECT product_category
	FROM [dbo].[silver_transactions]
	WHERE product_category !=TRIM(product_category)

	--====================================================================
	--Checking silver_transaction
	--================================================================
	----Check if my quantity has null(it does have nulls) and then i replaced
	SELECT quantity 
	FROM [dbo].[silver_transactions]
	WHERE quantity IS NULL


	--====================================================================
	--Checking silver_transaction
	--================================================================
----i wanted to check for negative numbers and nulls, but bcos its not a numeric as SQL recognizes it as a string(nvarchar) then i had to use TRY to make it look like a number to SQL.
SELECT  quantity
FROM [dbo].[bronze_transactions]
WHERE TRY_CAST(quantity AS FLOAT) < 0 OR quantity IS NULL



