/*
********************************************************************************************
*                                                                                          *
*   DATA WAREHOUSE DATABASE SETUP                                                          *
*                                                                                          *
*   This script sets up the basic structure for the DataWarehouse project.                 *
*                                                                                          *
*   What happens in this script:                                                          *
*                                                                                          *
*   1. Switches to the master database.                                                   *
*   2. Checks if the DataWarehouse database already exists.                               *
*   3. If it exists, sets it to SINGLE_USER mode and drops the database.                  *
*   4. Creates the DataWarehouse database.                                                 *
*   5. Switches to the DataWarehouse database.                                             *
*   6. Creates three schemas:                                                             *
*                                                                                          *
*      - bronze : Raw data layer                                                          *
*      - silver : Cleaned and transformed data layer                                      *
*      - gold   : Business-ready data layer                                               *
*                                                                                          *
*   This provides the basic layered structure for the Data Warehouse.                     *
*                                                                                          *
********************************************************************************************
*/

USE master
GO 

--Drop and recreate the 'DataWarehouse' database

IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

--Create DataBase DataWarehouse

CREATE DataWarehouse;

USE DataWarehouse;

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO