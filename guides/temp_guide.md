# Cloudera Data Platform and pre-requisites
For this hands-on experience, you will be using the Cloudera Data Platform. Ensure these steps are met before you start the Hands-On experience:
Make sure you have access to the Cloudera VPN. You can check this directly in Okta and on your own laptop. 
For Okta under MyApps: 
Search for “Global Protect VPN

On your laptop:
Ensure you’re connected to cloudera.gpcloudservice.com

Hit connect and an Okta challenge will pop up. Complete the challenge and get connected. 
Once you’re connected to VPN, please make sure you check in Okta for Cloudera Public Cloud Demos under MyApps:

The tile should show “CDP Demos”. Click on it, and ensure you’re able to access it. 
Once you are inside the CDP Demos tile and authenticated correctly, please verify you are able to view all the UIs. To ensure the VPN is working properly, try opening up the Cloudera Manager in the Azure Data Lake. To reach this, please go to “Management Console > Environments > go01-demo-azure > Data Lake > CM-UI (Cloudera Manager User Interface).”

If you’re not able to view this image, click here.
A new tab should appear in your browser. Ensure you can see something similar to this: 

If you’re not able to see this image, click here.
This concludes this section of the Hands-On lab prerequisites.
Getting familiar with the Cloudera Home Page
When you sign in into the Cloudera CDP Demos tenant, you will be greeted by this home page. Feel free to scroll and click around it for a few minutes to get familiar with it. Once you’re done, please go back to the home page and expect instructions from the presenters. 


This is the landing page for all the services Cloudera offers. Here, you will have a few key elements to inspect: 
Favorites (1)
All Services (2)
Data Hub Clusters (3)
Data Engineering (4)
Data Warehouse (5)

Please note that all of these sections are like a high level overview for the services deployed for each of the services. For this hands-on, you will only focus on the All Services (2) section and get familiar with the services listed here. 
Cloudera Data Flow - Consume ADLS CSV and transform to Kafka Topic
Configuring your first CDF Flow and getting familiar with Kafka
Cloudera DataFlow (CDF) is a hybrid data movement and streaming service offered as part of Cloudera Data Platform (CDP), available both on-premises and in the public cloud. It provides a fully managed, scalable, and secure platform for real-time and batch data ingestion, transformation, and distribution across diverse systems.

For this lab, you will be learning how to configure a Cloudera Data Flow flow that consumes a CSV file in Azure ADLs storage, moves it to CDF, analyzes the CSV files, transforms it into a JSON file and sends it off to a Kafka broker to share the messages to be later consumed by another flow that will insert them into your Cloudera Data Warehouse database.
Finding the flow names and resources
From the home page, please click on the Data Flow (purple) icon. If you can’t see the image, click here.

Once you’re here, expect to get a tour from your presenters. You’ll be explained what to do next. 

To configure the flow, please check the “Projects > Filter by Projects CSA_AMER_HOL_CDF. 
Click the three dots at the end of the tile.
Select “View Project Resources”
This will take you to a screen that shows two deployments.
CSA_AMER_HOL_ADLS_TO_KF
 CSA_AMER_HOL_KFK_TO_DL
Take note of the names (copy them to a notepad or text editor).

Configuring your Kafka schema in Schema Registry
Before you start the Cloudera Data Flow configuration, one prerequisite is to pre-create the schema for the Kafka topic. Follow the next steps to complete this section. 
Step 1 - Finding the Kafka Data Hub cluster
From your Cloudera Home Page, go to All Services > Management Console. 

If you’re unable to see this image, click here.
From your Management Console, check the Environments section and select the Azure environment called go01-demo-azure.
Once you are  here, you will need to locate the “Data Hubs” section and click on it. 
Once you are in the Data Hub section, find the Data Hub cluster called go01-kafka-azure. Click on the name. 
Once you are redirected to the Kafka data hub cluster page, look for the Services section and select the Schema Registry option. This will redirect you to another page and will require VPN connection. If you’re not connected to the VPN, this will not open up. Ensure you are connected to the VPN or follow this guide’s prerequisites section above.
Step 2 - Creating the Kafka Schema for your topic  in Schema Registry
Once you are inside the Schema Registry home page, search for the  button on the far top right corner. Click the button and register the follow schema with the following properties: 
Name: telco_data_{csa_alias}
Description: CSA HOL Schema Registration for CDF Flow.
Type: Leave the default “Avro schema provider” value.
Schema Group: Leave the default “Kafka” value.
Compatibility: Backward.
Evolve checkbox should be blue (selected).
Schema Text: Replace what’s highlighted before creating the schema. 
Click on Save to register the schema.
Schema for Kafka Schema Registry:

{
   "type" : "record",
   "namespace" : "telco",
   "name" : "telco_data_{CSA_ALIAS}",
   "fields" : [
      { "name" : "multiplelines" , "type" : "string" },
      { "name" : "paperlessbilling" , "type" : "string" },
      { "name" : "gender" , "type" : "string" },
      { "name" : "onlinesecurity" , "type" : "string" },
      { "name" : "internetservice" , "type" : "string" },
      { "name" : "techsupport" , "type" : "string" },
      { "name" : "contract" , "type" : "string" },
      { "name" : "churn" , "type" : "string" },
      { "name" : "seniorcitizen" , "type" : "string" },
      { "name" : "deviceprotection" , "type" : "string" },
      { "name" : "streamingtv" , "type" : "string" },
      { "name" : "streamingmovies" , "type" : "string" },
      { "name" : "totalcharges" , "type" : "string" },
      { "name" : "partner" , "type" : "string" },
      { "name" : "monthlycharges" , "type" : "string" },
      { "name" : "customerid" , "type" : "string" },
      { "name" : "dependents" , "type" : "string" },
      { "name" : "onlinebackup" , "type" : "string" },
      { "name" : "phoneservice" , "type" : "string" },
      { "name" : "tenure" , "type" : "string" },
      { "name" : "paymentmethod" , "type" : "string" }
   ]
}



Create your first CDF Catalog deployment
Go to Catalog in the left-hand navigation bar inside the CDF data service UI. 

In here, make sure you filter by collection “CSA_AMER_HOL_COLLECTION”.
Once you have filtered out the collection you should see two definitions here: 
CSA_AMER_HOL_ADLS_KFK
CSA_AMER_HOL_KAFKA_TO_DL
The two above flow files will be the ones you will be using to deploy your CDF flows.

Select “CSA_AMER_HOL_ADLS_KFK” and click the blue “Deploy” button in the popup blade that shows up.
Configuring your CSA_AMER_HOL_ADLS_KFK deployment
Once you have hit the blue Deploy button, follow the steps below: 
Step 1 - Overview
Deployment Name. This should be CSA-{CSA_ALIAS}-ADLS-TO_KFK.
For example: CSA-FCOBO-ADLS-TO-KFK.
For Target Workspace, select the Azure environment go01-demo-azure.
For Target Project select CSA_AMER_HOL_CDF.
Click the Next button.
Step 2 - NiFi configuration
Leave all values in this screen as default.
Click the Next button.
Step 3 - Parameters
In this step, you will be required to change a few parameters. You will change them by clicking on the pencil looking icon at the far right side of the parameter’s name.  Change the following parameters:
Kafka Producer ID: {CSA_ALIAS}-producer. 
Replace the CSA_ALIAS with your alias.
For example: fcobo-producer
Kerberos Password: Set your Cloudera Workload Password here.
Kerberos Principal: Set your Cloudera Workload Username here.
Topic Name: telco_data_{CSA_ALIAS}.
Replace the CSA_ALIAS with your alias. 
schema.name: Add the same value as Topic Name (above in #4).
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

