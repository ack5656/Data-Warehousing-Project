/******************************************************************************
 * What This Script Does:
 * 1. Selects the DataWarehouse database.
 * 2. Checks whether Bronze layer tables already exist.
 * 3. Drops existing tables to avoid duplication.
 * 4. Creates CRM customer, sales, and product tables.
 * 5. Creates ERP customer, location, and product category tables.
 * 6. Defines columns and data types for each table.
 ******************************************************************************/

--creating tables bronze.crm_cust_info,bronze.crm_sales_details,bronze.crm_prd_info
--for each csv files inside the bronze layer

--creating table bronze.crm_cust_info
USE DataWarehouse;

PRINT '=========================================================================================';
PRINT '>>Creating tables';
PRINT '=========================================================================================';

IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.crm_cust_info';
PRINT '-----------------------------------------------------------------------------------------';

CREATE TABLE bronze.crm_cust_info(
    cust_id INT,
    cust_key VARCHAR(50),
    cust_firstname VARCHAR(50),
    cust_lastname VARCHAR(50),
    cust_marital_status VARCHAR(50),
    cust_gndr VARCHAR(50),
    cust_create_date DATE
);

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.crm_sales_details';
PRINT '-----------------------------------------------------------------------------------------';

IF OBJECT_ID ('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt VARCHAR(10),
    sls_ship_dt VARCHAR(10),
    sls_due_dt VARCHAR(10),
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.crm_prd_info';
PRINT '-----------------------------------------------------------------------------------------';

IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt VARCHAR(50),
    prd_end_dt VARCHAR(50)
);

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.erp_cust_AZ12';
PRINT '-----------------------------------------------------------------------------------------';

IF OBJECT_ID ('bronze.erp_cust_AZ12','U') IS NOT NULL
    DROP TABLE bronze.erp_cust_AZ12;

CREATE TABLE bronze.erp_cust_AZ12(
    cid VARCHAR(50),
    bdate VARCHAR(50),
    gen VARCHAR(50)
);

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.erp_loc_A101';
PRINT '-----------------------------------------------------------------------------------------';

IF OBJECT_ID ('bronze.erp_loc_A101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_A101;

CREATE TABLE bronze.erp_loc_A101(
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

PRINT '-----------------------------------------------------------------------------------------';
PRINT '>>Checking and Creating table bronze.erp_px_cat_G1V2';
PRINT '-----------------------------------------------------------------------------------------';

IF OBJECT_ID ('bronze.erp_px_cat_G1V2','U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_G1V2;

CREATE TABLE bronze.erp_px_cat_G1V2(
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
