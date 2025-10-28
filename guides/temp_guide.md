


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

