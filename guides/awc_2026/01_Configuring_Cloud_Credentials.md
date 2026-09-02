## 01_Configuring_Cloud_Credentials.md

1. Navigate to the **Cloudera Cloud Factory (CCF) UI**.
1. Locate the **Credentials** section on the left-hand side of the screen.
1. Go to **Cloud Credentials**.
1. Select **AWS** as the cloud type.
1. Select **+Add Cloud Credentials**.
1. Input the following information:
    - Cloud Settings:
        - **Cloud name**: {your-user}-awc-aws-cred.
        - **Organization**: `sales-se-cloud`.
    - Cloud Credentials:
        - **Credential Type**: Access keys.
        - **Access Key ID**: (this was previously configured)
        - **Secret Access Key**: (this was previously configured)
        - **Region**: _us-west-2_
    - Networking
        - **AWS Zone Count**: do not modify this.
        - **IP Mode**: IPv4.
    - Import VPC (toggle ON)
        - **Import VPC**: `usw2-vpc-sandbox-goes-csa` (don't select a different VPC)
        - **Public Subnets**: toggle OFF.
1. Save the credential. This authorizes the platform to execute a VPC Import and provision resources autonomously within your AWS environment.
