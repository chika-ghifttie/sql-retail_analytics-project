# **Data Dictionary for Gold Layer**

## **Overview**

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. 
It consists of dimension tables and fact tables that store and organize data for specific business metrics.

---------------------------------------------------------------------------------------------------------

**1. gold.dim_customers**

- **Purpose:** Contains customer detils enriched with demographic and geographic information.
- **Columns:**

| Column Name        | Data Type       | Short Description                                                                                  |
|-------------------|----------------|---------------------------------------------------------------------------------------------------|
| customer_key       | BIGINT         | Surrogate key uniquely identifying each customer record in the dimension table.                   |
| customer_id        | NVARCHAR(50)   | Unique numerical identifier assigned to each customer.                                             |
| full_name          | NVARCHAR(50)   | Customer full name as recorded in the system.                                                     |
| age                | INT            | Customer age as recorded.                                                                         |
| gender             | NVARCHAR(50)   | Customer gender (e.g., 'Male', 'Female', 'Non Binary', 'Prefer not to Say', 'N/A').             |
| email              | NVARCHAR(100)  | Customer’s email address.                                                                         |
| phone_number       | NVARCHAR(50)   | Customer’s contact phone number.                                                                  |
| street_address     | NVARCHAR(150)  | Customer’s street address.                                                                        |
| city               | NVARCHAR(50)   | City where the customer resides.                                                                  |
| state              | NVARCHAR(50)   | State where the customer resides.                                                                 |
| zip_code           | NVARCHAR(50)   | Postal code of the customer’s address.                                                           |
| preferred_channel  | NVARCHAR(20)   | Customer’s preferred communication channel (e.g., 'Online', 'Instore').                          |
| registration_date  | NVARCHAR(50)   | Date when the customer registered.                                                               |

-------------------------------------------------------------------------------------------------------------------------------------------------

**2. gold.dim_customers_reviews**

- **Purpose:** The Customer Review dimension in the Gold Layer captures customer feedback, structured to support analytics and reporting.
                It stores review details and links to the customer dimension for business metrics.

| Column Name         | Data Type       | Short Description                                                                                  |
|--------------------|----------------|---------------------------------------------------------------------------------------------------|
| review_key          | BIGINT         | Surrogate key uniquely identifying each review record.                                             |
| review_id           | NVARCHAR(50)   | Unique identifier assigned to each review.                                                        |
| customer_key        | BIGINT         | Foreign key linking to the customer in the customer dimension table.                              |
| full_name           | NVARCHAR(50)   | Name of the customer who submitted the review.                                                    |
| product_name        | NVARCHAR(50)   | Name of the product being reviewed.                                                               |
| product_category    | NVARCHAR(50)   | Category or type of the product.                                                                  |
| rating              | SMALLINT       | Rating given by the customer, typically on a scale (e.g., 1-5).                                   |
| review_title        | NVARCHAR(100)  | Short title or headline of the customer’s review.                                                |
| review_text         | NVARCHAR(MAX)  | Full text content of the review.                                                                  |
| transaction_date    | DATE           | Date when the purchase/transaction occurred.                                                     |
| review_date         | NVARCHAR(50)   | Date when the customer submitted the review.                                                     |



**3. gold.fact_transaction**

- **Purpose:** The Transaction fact table in the Gold Layer records business transactions, structured to support analytics and reporting.

| Column Name        | Data Type       | Short Description                                                                                  |
|-------------------|----------------|---------------------------------------------------------------------------------------------------|
| transaction_id     | BIGINT         | Surrogate key uniquely identifying each transaction record.                                        |
| customer_key       | BIGINT         | Foreign key linking to the customer who made the transaction.                                     |
| product_name       | NVARCHAR(50)   | Name of the product purchased.                                                                    |
| product_category   | NVARCHAR(50)   | Category or type of the product purchased.                                                       |
| store_location     | NVARCHAR(100)  | Physical or online store location where the transaction occurred.                                 |
| payment_method     | NVARCHAR(100)  | Method of payment used for the transaction (e.g., Cash, Credit Card).                             |
| transaction_date   | DATE           | Date when the transaction took place.                                                            |
| quantity           | DECIMAL(10,2)  | Number of units purchased in the transaction.                                                    |
| price              | DECIMAL(10,2)  | Price per unit of the product at the time of the transaction.                                     |
| discount_applied   | DECIMAL(10,2)  | Discount amount applied to the transaction, if any.                                              |








