/*
============================================================================
  DDL Script    : Create Bronze Tables
  Purpose       : Defines the DDL structure for all tables in the 'bronze' schema.  
                 Existing tables are dropped (if present) and recreated to ensure  
                 consistency in the raw data storage layer.  

  Usage         : Execute this script whenever the bronze schema needs to be  
                 reset or reinitialized.  
============================================================================
*/

  IF OBJECT_ID('bronze.bronze_campaign', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_campaign;
GO

CREATE TABLE bronze.bronze_campaign (
    campaign_id NVARCHAR(50) NULL,
    campaign_name NVARCHAR(50) NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    target_segment NVARCHAR(50) NULL,
    budget DECIMAL(10,2) NULL,
    impressions NVARCHAR(50) NULL,
    clicks NVARCHAR(50) NULL,
    roi DECIMAL(7,2) NULL
);
GO


IF OBJECT_ID('bronze.bronze_cust', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_cust;
GO

CREATE TABLE bronze.bronze_cust (
    customer_id NVARCHAR(50) NULL,
    fullname NVARCHAR(50) NULL,
    age NVARCHAR(50) NULL,
    gender NVARCHAR(50) NULL,
    email NVARCHAR(100) NULL,
    phone NVARCHAR(50) NULL,
    streetaddress NVARCHAR(150) NULL,
    city NVARCHAR(50) NULL,
    state NVARCHAR(50) NULL,
    zipcode NVARCHAR(50) NULL,
    registrationdate NVARCHAR(50) NULL,
    preferredchannel NVARCHAR(50) NULL
);
GO


IF OBJECT_ID('bronze.bronze_cust_review', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_cust_review;
GO

CREATE TABLE bronze.bronze_cust_review (
    review_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    product_name NVARCHAR(50) NULL,
    full_name NVARCHAR(50) NULL,
    transaction_date DATE NULL,
    rating SMALLINT NULL,
    review_title NVARCHAR(100) NULL,
    review_text NVARCHAR(MAX) NULL
);
GO
 


IF OBJECT_ID('bronze.bronze_interactions', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_interactions;
GO

CREATE TABLE bronze.bronze_interactions (
    interaction_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    channel NVARCHAR(50) NULL,
    interactiontype NVARCHAR(50) NULL,
    duration NVARCHAR(MAX) NULL,
    page_or_product NVARCHAR(50) NULL,
    session_id NVARCHAR(MAX) NULL
);
GO


IF OBJECT_ID('bronze.bronze_support_ticket', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_support_ticket;
GO

CREATE TABLE bronze.bronze_support_ticket (
    ticket_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    issue_category NVARCHAR(50) NULL,
    submission_date NVARCHAR(MAX) NULL,
    resolution_date NVARCHAR(MAX) NULL,
    resolution_status NVARCHAR(50) NULL,
    resolution_time_hours NVARCHAR(MAX) NULL,
    customer_satisfaction_score NVARCHAR(MAX) NULL,
    notes NVARCHAR(MAX) NULL
);
GO


IF OBJECT_ID('bronze.bronze_transaction', 'U') IS NOT NULL
    DROP TABLE bronze.bronze_transaction;
GO

CREATE TABLE bronze.bronze_transaction (
    transaction_id NVARCHAR(50) NULL,
    customer_id NVARCHAR(50) NULL,
    product_name NVARCHAR(50) NULL,
    product_category NVARCHAR(50) NULL,
    quantity NVARCHAR(50) NULL,
    price DECIMAL(12,2) NULL,
    transaction_date DATE NULL,
    store_location NVARCHAR(20) NULL,
    payment_method NVARCHAR(20) NULL,
    discount_applied NVARCHAR(50) NULL
);
GO
