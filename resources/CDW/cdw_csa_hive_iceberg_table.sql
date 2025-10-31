/* ==========================================
+.  Authors -      Fernando Cobo, Dongkai Yu
+.  Roles -       Cloud Solutions Architects
+.  Date created: 2025-10-28
+.  SQL Scripts for CSA Hands-on Lab 2025
========================================== */

-- Step 1. Drop the database before the Hands-On lab in case one with your alias already exists in the default-hive-az Virtual Warehouse.
DROP DATABASE IF EXISTS {CSA_ALIAS};

-- Step 2. Create the database with your name as the db name in the default-hive-az Virtual Warehouse. 
CREATE DATABASE {CSA_ALIAS};

-- Step 3. Create the Iceberg table in the default-hive-az Virtual Warehouse.
CREATE EXTERNAL TABLE {CSA_ALIAS}.telco_iceberg_kafka (
  `multiplelines` string,
  `paperlessbilling` string,
  `gender` string,
  `onlinesecurity` string,
  `internetservice` string,
  `techsupport` string,
  `contract` string,
  `churn` string,
  `seniorcitizen` string,
  `deviceprotection` string,
  `streamingtv` string,
  `streamingmovies` string,
  `totalcharges` string,
  `partner` string,
  `monthlycharges` string,
  `customerid` string,
  `dependents` string,
  `onlinebackup` string,
  `phoneservice` string,
  `tenure` string,
  `paymentmethod` string
)
STORED BY 'org.apache.iceberg.mr.hive.HiveIcebergStorageHandler'
TBLPROPERTIES (
  'table_type'='ICEBERG',
  'engine.hive.enabled'='true',
  'iceberg.catalog.type'='hive',
  'write.format.default'='parquet'  -- Or 'avro' or 'orc', depending on your choice
);