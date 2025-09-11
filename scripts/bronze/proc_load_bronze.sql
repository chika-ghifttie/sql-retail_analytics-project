/*
*******************************************************************************************
 Stored Procedure:   Load Bronze Layer (Source -> Bronze)

 Purpose:     This stored procedure loads data into the 'bronze' schema from external CSV files. 
              It truncates the target tables before each load and then reloads data 
              using the BULK INSERT command.
 Parameters:  None

 Usage:       EXEC bronze.load_bronze;
*******************************************************************************************
*/

EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
     DECLARE @start_time DATETIME, @end_time DATETIME;
 BEGIN TRY
	PRINT '===============================================================================';
	PRINT 'Loading Bronze Layer'
	PRINT '===============================================================================';

	
	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading campaigns.csv into bronze_campaign table'
	PRINT '---------------------------------------------------------------------------------';

	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze_campaign'
	TRUNCATE TABLE [dbo].[bronze_campaign]

	PRINT '>> Inserting Data Into: bronze_campaign'
	BULK INSERT [dbo].[bronze_campaign]
	FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\campaigns.csv' 
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001',
		TABLOCK,
		KEEPNULLS
	);
    SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'


	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading customers.csv into dbo.bronze_cust table'
	PRINT '---------------------------------------------------------------------------------';

	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze_cust'
	TRUNCATE TABLE [dbo].[bronze_cust]

	PRINT '>> Inserting Data Into: bronze_cust'
	BULK INSERT [dbo].[bronze_cust]
	FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\customers.csv' 
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001',
		TABLOCK,
		KEEPNULLS
	);
	   SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'

	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading customer_reviews_complete.csv into bronze_cust_reviews table'
	PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze_cust_reviews'
	TRUNCATE TABLE [dbo].[bronze_cust_reviews]

	PRINT '>> Inserting Data Into: bronze_cust_reviews'
	BULK INSERT[dbo].[bronze_cust_reviews] 
	FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\customer_reviews_complete.csv' 
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001',
		TABLOCK,
		KEEPNULLS
	);
	 
	   SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'

	PRINT '--------------------------------------------------------------------------------';
	PRINT 'Loading interactions.csv into bronze_interactions table'
	PRINT '---------------------------------------------------------------------------------';

	SET @start_time = GETDATE()
	TRUNCATE TABLE [dbo].[bronze_interactions]
	PRINT '>> Truncating Table: bronze_interactions'

	PRINT '>> Inserting Data Into: bronze_interactions'
	BULK INSERT [dbo].[bronze_interactions]
	FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\interactions.csv' 
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001',
		TABLOCK,
		KEEPNULLS
	);
	     SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'

		PRINT '--------------------------------------------------------------------------------';
		PRINT 'Loading support_tickets.csv into bronze_support_ticket table'
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze_support_ticket'
		TRUNCATE TABLE [dbo].[bronze_support_ticket]

		PRINT '>> Inserting Data Into: bronze_support_tickets'
		BULK INSERT [dbo].[bronze_support_ticket]
		FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\support_tickets.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			CODEPAGE = '65001',
			TABLOCK,
			KEEPNULLS
		);
       SET @end_time = GETDATE();
	PRINT '>> Load Duration:' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
	PRINT '>> -------------'

		PRINT '--------------------------------------------------------------------------------';
		PRINT 'Loading transactions.csv into bronze_transactions table'
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze_transactions'
		TRUNCATE TABLE [dbo].[bronze_transactions]

		PRINT '>> Inserting Data Into: bronze_transactions'
		BULK INSERT [dbo].[bronze_transactions]
		FROM 'C:\Users\USER\Documents\SQL Server Management Studio\archive (3)\transactions.csv' 
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			CODEPAGE = '65001',
			TABLOCK,
			KEEPNULLS
		);
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
