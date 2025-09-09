/* SQL tables are help us to storing structured data. In this script we structure silver layer tables 
which help us to import data easily from bronze layer to Clean , Well Organize silver layer.
Here we use Same Data Table Structure, like Bronze Layer Here we Just Add One Column which Hepl us when 
we update Data. That Column Name is "dwh_create_data DATE DEFAULT CURRENT_DATE" to help us to display
Date when we Update data.
*/

-- 1. This Table[" silver.src_cust_crm "] Allocated in Silver layer From "CRM" Source.


TRUNCATE TABLE silver.src_cust_crm;
CREATE TABLE silver.src_cust_crm (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gndr            VARCHAR(50),
    cst_create_date     DATE,
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 2. This Table[" silver.src_prd_crm "] Allocated in Silver layer From "CRM" Source.

TRUNCATE TABLE silver.src_prd_crm;
CREATE TABLE silver.src_prd_crm (
    prd_id       INT,
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 3. This Table[" silver.src_sales_details_crm "] Allocated in Silver layer From "CRM" Source.

TRUNCATE TABLE silver.src_sales_details_crm;
CREATE TABLE silver.src_sales_details_crm (
    sls_ord_num  VARCHAR(50),
    sls_prd_key  VARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
------------------------------------------------------------------
-------------------------------------------------------------------

-- 4. This Table[" silver.src_loc_erp  "] Allocated in Silver layer From "ERP" Source.

TRUNCATE TABLE silver.src_loc_erp;
CREATE TABLE silver.src_loc_erp (
    cid     VARCHAR(50),
    contry  VARCHAR(50),
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 5. This Table[" silver.src_cust_erp  "] Allocated in Silver layer From "ERP" Source.

TRUNCATE TABLE silver.src_cust_erp ;
CREATE TABLE silver.src_cust_erp (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(50),
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 6. This Table[" silver.src_ctg_erp  "] Allocated in Silver layer From "ERP" Source.

TRUNCATE TABLE silver.src_ctg_erp;
CREATE TABLE silver.src_ctg_erp (
    id_          VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50),
	dwh_create_data     DATE DEFAULT CURRENT_DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------
