/*
============================================================================
  DDL Script    : Create Silver Tables
  Purpose       : Defines the DDL structure for all tables in the 'silver' schema.  
                  Existing tables are dropped (if present) and recreated to ensure  
                  consistency in the cleansed & standardized data storage layer.  

  Usage         : Execute this script whenever the silver schema needs to be  
                  reset or reinitialized before loading data from bronze.  

  Notes         : 
      - Silver layer stores cleaned, standardized, and deduplicated data.  
      - These tables serve as the foundation for analytics or Gold Layer.  
============================================================================
*/

IF OBJECT_ID('dbo.silver_campaign', 'U') IS NOT NULL
    DROP TABLE dbo.silver_campaign;
GO
CREATE TABLE silver_campaign (
    campaign_id NVARCHAR(50) NULL,
    campaign_name NVARCHAR(50) NULL,
	campaign_type NVARCHAR(50) NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    target_segment NVARCHAR(50) NULL,
    budget DECIMAL(10,2) NULL,
    impressions NVARCHAR(50) NULL,
    clicks NVARCHAR(50) NULL,
	conversions NVARCHAR(50) NULL,
	conversion_rate DECIMAL(5,2) NULL,
    roi DECIMAL(7,2) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.silver_cust', 'U') IS NOT NULL
    DROP TABLE dbo.silver_cust;
GO
CREATE TABLE silver_cust (
    customer_id NVARCHAR(50) NULL,
    fullname NVARCHAR(50) NULL,
    age NVARCHAR(50) NULL,
    gender NVARCHAR(50) NULL,
    email NVARCHAR(100) NULL,
    phone NVARCHAR(50) NULL,
    streetaddress NVARCHAR(150) NULL,
    city NVARCHAR(50) NULL,
    state NVARCHAR(50) NULL,
    zip_code NVARCHAR(50) NULL,
    registration_date NVARCHAR(50) NULL,
    preferred_channel NVARCHAR(20) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.silver_cust_review', 'U') IS NOT NULL
    DROP TABLE dbo.silver_cust_review;
GO
CREATE TABLE silver_cust_review (
    review_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    product_name NVARCHAR(50) NULL,
	product_category NVARCHAR(50) NULL,
    full_name NVARCHAR(50) NULL,
    transaction_date DATE NULL,
	review_date DATE NULL,
    rating SMALLINT NULL,
    review_title NVARCHAR(100) NULL,
    review_text NVARCHAR(MAX) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.silver_interactions', 'U') IS NOT NULL
    DROP TABLE dbo.silver_interactions;
GO
CREATE TABLE silver_interactions (
    interaction_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    channel NVARCHAR(50) NULL,
    interaction_type NVARCHAR(50) NULL,
    duration NVARCHAR(MAX) NULL,
    page_or_product NVARCHAR(50) NULL,
    session_id NVARCHAR(MAX) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.silver_support_ticket', 'U') IS NOT NULL
    DROP TABLE dbo.silver_support_ticket;
GO
CREATE TABLE silver_support_ticket (
    ticket_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    issue_category NVARCHAR(50) NULL,
    submission_date NVARCHAR(MAX) NULL,
    resolution_date NVARCHAR(MAX) NULL,
    resolution_status NVARCHAR(50) NULL,
    resolution_time_hours NVARCHAR(MAX) NULL,
    customer_satisfaction_score NVARCHAR(MAX) NULL,
    notes NVARCHAR(MAX) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.silver_transaction', 'U') IS NOT NULL
    DROP TABLE dbo.silver_transaction;
GO
CREATE TABLE silver_transaction (
    transaction_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    product_name NVARCHAR(50) NULL,
    product_category NVARCHAR(50) NULL,
    quantity NVARCHAR(50) NULL,
    price DECIMAL(12,2) NULL,
    transaction_date DATE NULL,
    store_location NVARCHAR(20) NULL,
    payment_method NVARCHAR(20) NULL,
    discount_applied NVARCHAR(50) NULL,
	dwh_create_date DAETIME2 DEFAULT GETDATE()
);
GO


