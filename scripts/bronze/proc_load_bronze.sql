/******************************************************************************
 * What This Script Does:
 * 1. Creates the DataWarehouse database if it does not exist.
 * 2. Creates a stored procedure to load the Bronze layer.
 * 3. Truncates existing data from CRM and ERP tables.
 * 4. Loads data from CSV files into the respective Bronze tables.
 * 5. Measures and displays individual table loading durations.
 * 6. Tracks the total batch loading duration.
 * 7. Handles errors and displays error details if loading fails.
 ******************************************************************************/

--creating tables bronze.crm_cust_info,bronze.crm_sales_details,bronze.crm_prd_info
--for each csv files inside the bronze layer
--creating table bronze.crm_cust_info
CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
    BEGIN TRY
        DECLARE @start_time DATETIME,@end_time DATETIME;
        DECLARE @batch_start_time DATETIME,@batch_end_time DATETIME;
        SET @batch_start_time = GETDATE();


        --************************************************************************************************
        --******************* loading data into tables from csv files ************************************

        PRINT '=========================================================================================';
        PRINT '>>LOADING bronze LAYER';
        PRINT '=========================================================================================';

        PRINT '========================================================================================';
        PRINT '>>LOADING crm TABLES';
        PRINT '========================================================================================';

        PRINT '>>loading data into bronze.crm_cust_info';

        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

        PRINT '----------------------------------------------------------------------------------------';
        PRINT '>>loading data into bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';


        PRINT '----------------------------------------------------------------------------------------';
        PRINT '>>loading data into bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';


        PRINT '========================================================================================';
        PRINT '>>LOADING erp TABLES';
        PRINT '========================================================================================';

        PRINT '>>loading data into bronze.erp_cust_AZ12';

        SET @end_time = GETDATE();

        TRUNCATE TABLE bronze.erp_cust_AZ12;
        BULK INSERT bronze.erp_cust_AZ12
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

        PRINT '----------------------------------------------------------------------------------------';
        PRINT '>>loading data into bronze.erp_loc_A101';

        SET @end_time = GETDATE();

        TRUNCATE TABLE bronze.erp_loc_A101;
        BULK INSERT bronze.erp_loc_A101
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

        PRINT '----------------------------------------------------------------------------------------';
        PRINT '>>loading data into bronze.erp_px_cat_G1V2';


        SET @end_time = GETDATE();

        TRUNCATE TABLE bronze.erp_px_cat_G1V2;
        BULK INSERT bronze.erp_px_cat_G1V2
        FROM 'C:\Users\DELL\Desktop\New folder\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------------------------------------------';
        PRINT '';

        SET @batch_end_time = GETDATE();

        PRINT '>> The batch is loaded successfully'
        PRINT '>> whole batch Loading Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';

    END TRY
    BEGIN CATCH
        PRINT '=======================================================================================';
        PRINT '>>ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'error message' + ERROR_MESSAGE();
        PRINT 'error number' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'error state' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=======================================================================================';
    END CATCH
END
