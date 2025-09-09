/* SQL tables are help us to storing structured data. In this script we structure bronze layer tables 
which help us to import data easily from source file to bronze layer.Without Any Data Trasforming Method.
Here we Just Extract the Raw_Data In the form of ROW and COLUMN.
*/

-- 1. This Table[" bronze.src_cust_crm "] Allocated in Bronze layer From "CRM" Source.
CREATE TABLE bronze.src_cust_crm (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gndr            VARCHAR(50),
    cst_create_date     DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 2. This Table[" bronze.src_prd_crm "] Allocated in Bronze layer From "CRM" Source.

CREATE TABLE bronze.src_prd_crm (
    prd_id       INT,
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 3. This Table[" bronze.src_sales_details_crm  "] Allocated in Bronze layer From "CRM" Source.

CREATE TABLE bronze.src_sales_details_crm (
    sls_ord_num  VARCHAR(50),
    sls_prd_key  VARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 4. This Table[" bronze.src_loc_erp  "] Allocated in Bronze layer From "ERP" Source.

CREATE TABLE bronze.src_loc_erp (
    cid     VARCHAR(50),
    contry  VARCHAR(50)
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 5. This Table[" bronze.src_cust_erp "] Allocated in Bronze layer From "ERP" Source.

CREATE TABLE bronze.src_cust_erp (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(50)
);
-------------------------------------------------------------------
-------------------------------------------------------------------

-- 6. This Table[" bronze.src_ctg_erp "] Allocated in Bronze layer From "ERP" Source.

CREATE TABLE bronze.src_ctg_erp (
    id_          VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50)
);
-------------------------------------------------------------------
-------------------------------------------------------------------
