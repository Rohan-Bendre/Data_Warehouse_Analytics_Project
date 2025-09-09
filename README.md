# Data Warehouse & Analytics Project

> Modern data warehouse implementation (Bronze → Silver → Gold) with SQL Server, ETL scripts, data modeling and analytics — a portfolio-ready project demonstrating data engineering and analytics best practices.

This repository contains an end-to-end example of building a data warehouse using a medallion (Bronze / Silver / Gold) architecture, loading data from CSV sources (ERP & CRM), cleaning and transforming the data, modeling it into analytical structures (star schema), and producing SQL-based analytics and reports.

---

## Table of contents

* [Why this project](#why-this-project)
* [Architecture](#architecture)
* [Features](#features)
* [Repository structure](#repository-structure)
* [Getting started](#getting-started)

  * [Prerequisites](#prerequisites)
* [How the pipeline works](#how-the-pipeline-works (step-by-step))
* [Key SQL scripts & examples](#key-sql-scripts--examples)
* [Testing & data quality](#testing--data-quality)

---

## Why this project

* Demonstrates a realistic data engineering pipeline using PostgreSQL Server and CSV source data (ERP & CRM).
* Shows layered medallion architecture to make pipelines robust and query-efficient.
* Includes ETL, cleansing, normalization, dimensional modeling (star schema) and analytics-ready datasets.

---

## Architecture

This project follows the **Medallion Architecture**:

* **Bronze** — raw ingestion: import CSVs and store source records as-is.
* **Silver** — cleansing & standardization: deduplication, normalized keys, data type corrections and basic enrichment.
* **Gold** — analytical models: star-schema dimension and fact tables optimized for reporting and analytics.

High-level flow:
`Source CSVs (ERP + CRM)` → **Bronze** → cleaning & transforms → **Silver** → dimensional modelling → **Gold** → `Reports / Dashboards`.

---

## Features

* Ingest ERP & CRM CSVs into a Bronze layer using SQL scripts.
* Data cleaning: null handling, datatype normalization, deduplication and trimming.
* Join and unify ERP + CRM entities (customers, products, locations, sales).
* Build analytic dimension & fact tables (product dimension, customer dimension, orders fact).
* SQL-based analytics and reporting queries (customer behavior, product performance, sales trends).
* Clear folder structure & modular SQL scripts for each medallion layer.

---

## Repository structure

```
data-warehouse-project/
│
├── raw_Dataset/                        # Raw CSV datasets (ERP, CRM)
├── Data_Structure/                            # Architecture, draw.io diagrams, data catalog, naming conventions
├── scripts/                         # SQL scripts for ETL and transformations
│   ├── bronze/                       # Bronze scripts (load raw CSVs)
│   ├── silver/                       # Silver scripts (cleaning & transform)
│   └── gold/                         # Gold scripts (dimensions & facts)
├── Updated_Dataset /
├── EDA /                              # Tests and QA scripts
├── Adv_EDA /                         # Tests and QA scripts
├── README.md
├── LICENSE
├── .gitignore
└── requirements.txt                  # Optional: tooling / client libraries
```

---

## Getting started

### Prerequisites

* **PostgreSQL** 
* CSV source files (place in `datasets/`).


### Install & Run (quick steps)

1. Clone the repo:

   ```bash
   git clone https://github.com/your-username/data-warehouse-project.git
   cd data-warehouse-project
   ```

2. Place source CSV files into the `datasets/` folder.

3. Create the database & schemas:

   * Run `scripts/bronze/1.Creating_Schemas.sql` to create the database and schemas.

4. Load Bronze (raw) data:

   * Execute the Bronze-layer scripts in order (`2.Bronze-Layer__Creating_Tables_For_Bronze-Layer.sql`, `3.Bronze-Layer__Importing_Source_data_into_Bronze-layer.sql`).

5. Run Silver layer transforms:

   * Execute scripts in `scripts/silver/` to clean and transform raw tables into silver tables.

6. Build Gold (analytical) models:

   * Run scripts in `scripts/gold/` to create dimensions & facts (customer, product, orders).

7. Run analytics & EDA queries:

   * Use `EDA_*` and `Adv_Analytsis_*` scripts for insights.

---

## How the pipeline works (step-by-step)

1. **Schema creation** — create databases, schemas and table definitions.
2. **Bronze ingestion** — import CSV files into Bronze tables without transformations (raw copies).
3. **Silver transformations** — apply cleansing: handle nulls, normalize data types, deduplicate and create surrogate keys where needed.
4. **Gold modeling** — build final star schema: dimension tables (customers, products, date, location) and fact tables for orders/sales.
5. **Analytics** — run SQL queries against gold tables to produce KPIs, charts and dashboards.

---

## Key SQL scripts & examples

**Bronze**

* `1.Creating_Schemas.sql`
* `2.Bronze-Layer__Creating_Tables_For_Bronze-Layer.sql`
* `3.Bronze-Layer__Importing_Source_data_into_Bronze-layer.sql`

**Silver**

* `4.Silver-Layer__Creating_Tables_Structure_For_Silver-Layer.sql`
* `5.Silver-Layer__Transfer_Clean-Data_bronze_cust_crm_TO_silver_cust_crm.sql`
* `6.Silver-Layer__Transfer_Clean-Data_bronze_prd_crm_TO_silver_prd_crm.sql`
* `7.Silver-Layer__Transfer_Clean-Data_bronze_sales_details_crm_TO_silver_sales_details_crm.sql`
* `8.Silver-Layer__Transfer_Clean-Data_bronze_cust_erp_TO_silver_cust_erp.sql`
* `9.Silver-Layer__Transfer_Clean-Data_bronze_cat_erp_TO_silver_cat_erp.sql`
* `10.Silver-Layer__Transfer_Clean-Data_bronze_loc_erp_TO_silver_loc_erp.sql`

**Gold**

* `11.Gold-Layer_Dimention__Transfer_Clean-Data_silver_into_gold_customer.sql`
* `12.Gold-Layer_Dimention__Transfer_Clean-Data_silver_TO_gold_product.sql`
* `13.Gold-Layer_FACT__Transfer_Clean-Data_silver_TO_gold_orders.sql`

**Exploratory & Advanced Analysis (EDA)**

* `1. EDA_Database Exploration.sql`
* `2. EDA_Dimension Exploration.sql`
* `3. EDA_Data Exploratio.sql`
* `4 EDA_Magnitude.sql`
* `5. EDA_Ranking.sql`
* `Adv_Analytsis_*` scripts for cumulative, change-over-time, segmentation, performance, reporting.

---

## Testing & data quality

* Row count validation between raw files and Bronze.
* Duplicate checks & null handling in Silver.
* Referential integrity checks in Gold (FK consistency).

---

## License

This project is licensed under the **MIT License**. See `LICENSE` for details.

---

## About the author / Contact

**Rohan Sanjay Bendre** — Computer Science student passionate about data engineering and analytics.

