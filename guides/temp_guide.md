


Cloudera Data Warehouse - Database and Table Creation
For the next step in the Hand-On lab, we will prepare a database and a table, where our Kafka topics will be stored. This Virtual Warehouse will work as our data landing spot. 
Reaching the Cloudera Data Warehouse Hive Virtual Warehouse for Azure
From your Cloudera Home Page, select from the All Services section, Data Warehouse.

If you are unable to see this image, click here. 
This previous step will result in a pop-up blade showing up on the right side of the screen. 
From this blade, look at the upper right corner and click on “Manage Data Warehouse”. This will take you to the Cloudera Data Warehouse services and you’ll be able to interact with the Virtual Warehouse services directly. 
Step 1 - Opening Hue in the Hive Virtual Warehouse
For this next step, we will require you to open a Hue session in the Virtual Warehouse. This session will be used to create the database that will be consumed by one of our upcoming CDF flows and where we will create our Iceberg table to land the Kafka messages inside the topic we created earlier. Follow these steps to locate the Hive Virtual Warehouse:
Inside the Cloudera Virtual Warehouse page, look for the one called default-hive-az. 
Look at the right inside this Virtual Warehouse section and you will see an icon with the name of “Hue”. Click on that icon and you will be redirected to the Hue interface. In this scenario, Hue will use your SSO credentials and use that to log in automatically. You don’t have to give Hue user and password.
In the scripts below, replace the {CSA_ALIAS} placeholder with your alias.

Step 2 - Creating your database
Once you are inside Hue, you will be presented with a SQL like text editor. Inside this text editor run the following code: 

-- CREATE DATABASE {CSA_ALIAS}

CREATE DATABASE {CSA_ALIAS};




Step 3 - Creating your Iceberg table

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


Once you have created the database and the table, you should be ready to deploy the next CDF flow, which will consume the Kafka messages and insert them into the Iceberg table. 
Cloudera Data Flow - Consuming Kafka Topic messages and inserting them into Iceberg table
Once you have created your database and Iceberg table, you should be ready to deploy the final flow, which will consist of consuming the Kafka Topic messages and storing them into the Iceberg table. 
Create your second CDF Catalog deployment
Go to Catalog in the left-hand navigation bar inside the CDF data service UI. 

In here, make sure you filter by collection “CSA_AMER_HOL_COLLECTION”.
Once you have filtered out the collection you should see two definitions here: 
CSA_AMER_HOL_ADLS_KFK
CSA_AMER_HOL_KAFKA_TO_DL
The two above flow files will be the ones you will be using to deploy your CDF flows.

Select “CSA_AMER_HOL_KFK_TO_DL” and click the blue “Deploy” button in the popup blade that shows up.
Configuring your CSA_AMER_HOL_KFK_TO_DL deployment
Once you have hit the blue Deploy button, follow the steps below: 
Step 1 - Overview
Deployment Name. This should be CSA-{CSA_ALIAS}-KFK-TO-DL.
For example: CSA-FCOBO-KFK-TO-DL.
For Target Workspace, select the Azure environment go01-demo-azure.
For Target Project select CSA_AMER_HOL_CDF.
Click the Next button.
Step 2 - NiFi configuration
Leave all values in this screen as default.
Click the Next button.
Step 3 - Parameters
In this step, you will be required to change a few parameters. You will change them by clicking on the pencil looking icon at the far right side of the parameter’s name.  Change the following parameters:
Database: should be your alias and what you used to create the database in the previous step in Hue.
Kafka Consumer Group Id: set the value to {CSA_ALIAS}001.
Be sure to replace {CSA_ALIAS} for your alias.
Kafka Topic, Topic Name: set to telco_data_{CSA_ALIAS}.
Kerberos Password: set your Cloudera Workload Password.
Kerberos Principal: set your Cloudera Workload Username.
The rest of the parameters should be left untouched. 
Click the Next button.
Step 4 - Sizing & Scaling
For NiFi Node Sizing choose Extra Small.
For Number of NiFi Nodes leave 1 as default.
Leave Autoscaling unchecked.
For Storage Selection select Standard.
Click the Next button.
Step 5 - Key Performance Indicators
Leave this section empty and do not configure any KPIs. Add some if you feel curious but this is not mandatory for this Hands-On lab.
Step 6 - Review
Take a minute to review the configuration.
Click the Deploy button. This will redirect you to the deployment status page.

Configuring your Flow processors, controllers and services
At this point, you have passed in all of the required values in the previous step, but we will be doing an overview to explain where those values are being used and why they are necessary. This will be presented by Fernando Cobo during the Hands-On laboratory. 

Cloudera Data Engineering - Enriching data and moving to AI
Configuring your first Airflow job
Mapping Python scripts
Execute the Airflow pipeline
Check results

Cloudera AI (?)
asjhasfhkjashdj

