## 00_Lab_Prerequisites_and_IAM_Setup.md

### Creating IAM User

1. Go to AWS and select the account `aws-fs-taikun-test` from the list.
1. Navigate to the search bar and look for _IAM_.
1. Go to **IAM Users** and select the option **Create User**.
    - You will need to add the tag `owner` and a value. Otherwise, attempting to create the user will fail with an exception.
    - For the `owner` tag example: `key:owner | value:{your-user}@cloudera.com`
1. Select the new user and go to **Security Credentials**.
1. Generate a new Access Key.
1. Save your **AWS IAM Credentials**, you will need them later on.
    - **AWS ACCESS ID:** xxxxxx
    - **AWS SECRET:** xxxxx/xxxxxx+xxxxxx
1. Attach to your new IAM User the following policies:
    - `ccf-backup-policy`
    - `ccf-deploy-policy`
    - `ccf-route53`

### Creating Robot User in Cloudera Cloud Factory (CCF)

1. Navigate to https://app.ccf-preprod.internal.cloudera.com/ (VPN REQUIRED).
1. Select your org `se-sales-cloud`.
1. Navigate to Configuration on the left-hand side pane.
1. Select **Robot Users**.
1. Select **+Add Robot User**.
1. Give the Robot Use the following attributes:
    - **Name**: {your-user}-robo-usr (fcobo-robo-user).
    - **Organization**: `sales-se-cloud`
    - **Expiration Date**: Make it expire the same day of the following week.
    - **Description**: Robot user created by {your-user}.
1. You will be taken to a new modal to select the **Scopes**.
1. Select _Select All_ followed by the **Continue** button at the bottom of the same modal.
1. Make sure your save the credentials.
1. **Taikun Robot User Credentials**
    - **Access Key:** xxxx
    - **Secret Key:** xxxxx+xxxx/xxxxx=

### Creating S3 backup account and Backup Credential

1. In AWS, create an S3 account named awc-{your-user}-backup
1. In CCF, go to Backup Credentials and select **+Add Credentials**.
1. Give it the following configuration:
    - **S3 Name**: awc-{your-user}-backup-cred
    - **S3 Access Key**: you can reuse the previously created one.
    - **S3 Secret Key**: you can reuse the previously created one.
    - **S3 Endpoint**: `https://awc-{your-user}-backup.s3.us-west-2.amazonaws.com`
    - **S3 Region**: `us-west-2`
