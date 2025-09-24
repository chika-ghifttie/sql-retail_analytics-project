/*
============================================================================
  Stored Procedure : Load Silver Layer (Bronze -> Silver)  
============================================================================
  Purpose          : Performs the ETL (Extract, Transform, Load) process to 
                     populate the 'silver' schema tables from the 'bronze' schema.  

  Actions Performed: 
      - Truncates Silver Tables  
      - Inserts transformed and cleaned data from Bronze into Silver tables  

  Parameters       : None  
                     This stored procedure does not accept any parameter or 
                     return any values.  

  Usage Example    : 
      EXEC silver.load_silver;  
============================================================================
*/

 CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
     DECLARE @start_time DATETIME, @end_time DATETIME;
 BEGIN TRY
	PRINT '===============================================================================';
	PRINT 'Loading Silver Layer'
	PRINT '===============================================================================';

	
	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading into silver_cust Table'
	PRINT '---------------------------------------------------------------------------------';

	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: [dbo].[silver_cust]';
	TRUNCATE TABLE [dbo].[silver_cust];
	PRINT '>> Truncating Table: [dbo].[silver_cust]';

	INSERT INTO silver_cust(
		customer_id,
		fullname,
		age,
		gender,
		email,
		phone,
		street_address,
		city,
		state,
		zip_code,
		registration_date,
		preferred_channel
	)
	SELECT 
		customer_id,
		CASE 
			WHEN fullname IS NULL OR TRIM(fullname) = '' THEN 'Unknown Name'
			ELSE TRIM(fullname)
		END AS fullname,
		ISNULL(TRY_CAST(CAST(age AS DECIMAL(5,2)) AS INT), 0) AS age,
		CASE 
			WHEN UPPER(TRIM(gender)) = 'FEMALE' THEN 'F'
			WHEN UPPER(TRIM(gender)) = 'MALE' THEN 'M'
			WHEN UPPER(TRIM(gender)) = 'NON-BINARY' THEN 'NB'
			WHEN UPPER(TRIM(gender)) = 'PREFER NOT TO SAY' THEN 'PNS'
			ELSE 'n/a'
		END AS gender,
		ISNULL(email, 'Not Provided') AS email,
		CASE
			WHEN phone LIKE '+1%' AND LEN(REPLACE(phone,'+','')) = 11 THEN phone
			WHEN phone NOT LIKE '%[^0-9]%' AND LEN(phone) = 10 THEN '+1' + phone
			ELSE 'Not Provided'
		END AS phone,
		ISNULL(TRIM(street_address), 'Not Provided') AS street_address,
		ISNULL(TRIM(city), 'Not Provided') AS city,
		ISNULL(TRIM(state), 'Not Provided') AS state,
		ISNULL(zip_code, 'Not Provided') AS zip_code,
		registration_date,
		ISNULL(TRIM(preferred_channel), 'Not Provided') AS preferred_channel
	FROM (
		SELECT *,
			   ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY registration_date DESC) AS flag_last
		FROM dbo.bronze_cust
		WHERE customer_id IS NOT NULL
	) AS t
	WHERE flag_last = 1;
	SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'

	

	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading silver_transaction Table'
	PRINT '---------------------------------------------------------------------------------';

	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze_cust'
	PRINT '>> Truncating Lable: [dbo].[silver_transactions]';
	TRUNCATE TABLE [dbo].[silver_transactions]
	PRINT '>> Truncating Lable: [dbo].[silver_transactions]'
	INSERT INTO [dbo].[silver_transactions](
		transaction_id,
		customer_id,
		product_name,
		product_category,
		quantity,
		price,
		transaction_date,
		store_location,
		payment_method,
		discount_applied
	)
	SELECT
	transaction_id,
	customer_id,
	CASE 
		WHEN product_name IS NULL THEN 'Unknown'
		ELSE product_name
	END AS product_name,
	TRIM(ISNULL(product_category, 'Uncategorized')) AS product_category,
	  ISNULL(
			 CAST (quantity AS DECIMAL (5,2)),0)AS quantity,
	  ISNULL(price,0) AS price,
	transaction_date,
		  REPLACE(TRIM(store_location), '"',' ') AS store_location,
	   CASE 
		   WHEN TRIM(REPLACE(payment_method,'"',' ')) IN 
		('Google Pay', 'Debit Card', 'Gift Card','Cash', 'Apple Pay','Credit Card','PayPal') 
	  THEN
	  TRIM(REPLACE(payment_method,'"',' '))
	  ELSE 'Not Provided'
	END AS payment_method,
	ISNULL(
		TRY_CAST(
			CASE 
				WHEN CHARINDEX(',', discount_applied) > 0 
					THEN LTRIM(RTRIM(SUBSTRING(discount_applied, CHARINDEX(',', discount_applied) + 1, LEN(discount_applied))))
				ELSE discount_applied
			END AS DECIMAL(10,2)
		), 0.0
	) AS discount_applied
	FROM(
			 SELECT *,
			 ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_date DESC) AS flag_last
			 FROM [dbo].[bronze_transactions]
			 WHERE customer_id IS NOT NULL
	)t
	WHERE flag_last = 1
	 SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'
	


	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading customer_review Table'
	PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze_cust_reviews'
	PRINT '>> Truncating Lable: [dbo].[silver_cust_review]';
	TRUNCATE TABLE [dbo].[silver_cust_review]
	PRINT '>> Truncating Lable: [dbo].[silver_cust_review]'
	INSERT INTO [dbo].[silver_cust_review](
	   review_id,
	   customer_id,product_name, 
	   product_category,
	   full_name,
	   transaction_date,
	   review_date,
	   rating,
	   review_title,
	   review_text
	)
	SELECT 
	review_id,
	customer_id,
	COALESCE(product_name,'Unknown') AS product_name,
	TRIM(ISNULL(product_category, 'Uncategorized')) AS product_category,
	TRIM(full_name) AS full_name,
	transaction_date,
	review_date,
	rating,
	TRIM(REPLACE(review_title,'"',' ')) AS review_title,
	TRIM(REPLACE(review_text,'"',' ')) AS review_text
	FROM (
					SELECT
					*,
					ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY review_date) AS flag_last
					FROM [dbo].[bronze_cust_reviews]
					WHERE customer_id IS NOT NULL
	)t
	WHERE flag_last = 1

	
SET @end_time = GETDATE();
	    PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	    PRINT '>> -------------'
	END TRY
	BEGIN CATCH 
		PRINT '======================================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '======================================================================='
	END CATCH
END


