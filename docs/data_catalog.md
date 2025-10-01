# **Data Dictionary for Gold Layer**

## **Overview**

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. 
It consists of dimension tables and fact tables that store and organize data for specific business metrics.

---------------------------------------------------------------------------------------------------------

**1. gold.dim_customers**

- **Purpose:** Contains customer detils enriched with demographic and geographic information.
- **Columns:**

**|Column Name       | Data Type    | Description                                                                                 |**
|--------------------|--------------|------------------------------------------------------------------------------------------   |
| customer_key       | BIGINT       | Surrogate key uniquely identifying each customer record in the dimension table.             |
| customer_id        | NVARCHAR(50) | Unique numerical identitifier assigned to each customer.                                    |
| full_name          | NVARCHAR(50) | Customer fullname as recorded in the system.                                                |
| age                | INT          | Customer age as recorded
| gender             | NVARCHAR(50) | The gender of the customer (e.g 'Male', 'Female', 'Non Binary', 'Prefer not to Say', 'n/a') |
| email              | NVARCHAR(100)| Customer’s email address.                                                                   |
| phone_number       | NVARCHAR(50) | Customer’s contact phone number.                                                            |
| street_address     | NVARCHAR(150)| Customer’s street address.                                                                  |
| city               | NVARCHAR(50) | City where the customer resides.                                                            |
| state              | NVARCHAR(50) | State where the customer resides.                                                           |
| zip_code           | NVARCHAR(50) | Postal code of the customer’s address.                                                      |
| preferred_channel  | NVARCHAR(20) | Customer’s preferred communication channel (e.g., 'Online','Instore')                       |
| registration_date  | NVARCHAR(50) | Date when the customer registered                                                           |



| Column Name       | Data Type  | Description                                      |
|------------------|-----------|--------------------------------------------------|
| customer_id       | INT       | Unique identifier for each customer              |
| customer_name     | VARCHAR   | Full name of the customer                        |
| age               | INT       | Age of the customer                              |
| city              | VARCHAR   | City where the customer resides                  |
| country           | VARCHAR   | Country of the customer                          |



