/*
============================================================
Purpose of Script
============================================================
This script is designed to set up a clean environment for 
database and schema creation. 

Steps performed:
                1. Checks if the target database already exists.
                2. If it exists, the database is dropped and recreated 
                   (⚠️ proceed with caution — this action permanently 
                   deletes the database and all data within it).
                3. Creates the new database.
                4. Defines schemas within the database, following the 
                   Bronze, Silver, and Gold layered architecture.

Caution:
        Dropping the database will permanently remove all existing 
        data and objects. Ensure that you have backups or that 
        the database can safely be reset before running this script.
------------------------------------------------------------
*/


USE master;
GO


--Drop And Recreate The Datawarehouse Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN 
  ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWareHouse
  END;
  GO


---Create The DataWarHouse Database
  CREATE DATABASE DataWareHouse;
  GO

  USE DataWareHouse;
  GO

  ----Create Schemas
  CREATE SCHEMA bronze;
  GO

  CREATE SCHEMA silver;
  GO

  CREATE SCHEMA gold;
  GO
