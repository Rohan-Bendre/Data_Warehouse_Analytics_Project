--   IMPORTING DATA FROM SOURCE FILE BRONZE LAYER.

-------------------------------------------------------------------------------------------------
--    ***]If you want to go from easy importing method then use this method............[***
-------------------------------------------------------------------------------------------------

/*   i] Right Click on "bronze.src_cust_crm" table from your database which located in schema
	ii] Then Click on Import/Export option
   iii] Paste File Path (Check=> i] Header Option is on
   								ii] Column names are Correct)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

-- Do Same Process From Other Tables
	  i] 'bronze.src_prd_crm'
	 ii] 'bronze.src_sales_details_crm'
	iii] 'bronze.src_cust_erp'
	 iv] 'bronze.src_loc_erp'
	  v] 'bronze.src_ctg_erp'

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

-- If you want go from Writing Code(Query) 
{Use this code} */


/* Simple Syntax...

COPY "Table_name"
	FROM 'File_Path with file_extention ex .csv '
		DELIMITER  ',' 
		CSV HEADER ; 
*/ 
   -- DELIMITER  ',' -- {'-',' ',':',etc}
   -- CSV HEADER ; -- If Column Names Are Already Present
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

COPY bronze.src_cust_crm
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_crm\src_cust_crm.csv '
		DELIMITER  ',' 
		CSV HEADER;
		
COPY bronze.src_prd_crm
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_crm\src_prd_crm.csv '
		DELIMITER  ',' 
		CSV HEADER;

COPY bronze.src_sales_details_crm
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_crm\src_sales_details_crm.csv '
		DELIMITER  ',' 
		CSV HEADER;
		
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

COPY bronze.src_cust_erp
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_erp\src_cust_erp.csv '
		DELIMITER  ',' 
		CSV HEADER;
		
COPY bronze.src_ctg_erp
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_erp\src_ctg_erp.csv '
		DELIMITER  ',' 
		CSV HEADER;

COPY bronze.src_loc_erp
	FROM 'D:\Data_Analytics\SQL_Data\Data WareHouse Project\datasets\source_erp\src_loc_erp.csv '
		DELIMITER  ',' 
		CSV HEADER;
		
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

