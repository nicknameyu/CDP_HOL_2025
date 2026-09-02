## 06_Deploying_Anywhere_Cloud_App.md

1. From your project in CCF, locate the **Application** button on the top side.
1. You will find the **+Install** button on the right top corner.
1. Select `anywhere-cloud` and hit the white `+` button.
1. Give the application the following configuration:
    - **Application Instance Name**: {your-user}-awc.
    - **Namespace**: `awc-core`.
    - **Extra Values**: toggle ON.
    - **Pull Secret**: toggle ON and type `awc-console-registry-creds`.
1. From the **Installation Params** section, change the following value:
    - dns.clusterDomain to `{your-user}.a97996.test.cldr.work`
1. Make sure that `preInstallCheckSingleConsole.enabled` is toggled OFF and `externalDns.enabled` is toggled ON.
1. Click **Continue**.
1. Enter the following YAML configuration in the Extra Values screen:

    ```yaml
    dns:
      baseDomain: "a97996.test.cldr.work"
      clusterDomain: "{your-user}.a97996.test.cldr.work"
    externalDns:
      enabled: true
      chartValues:
        provider:
          name: aws
        env:
          - name: AWS_ACCESS_KEY_ID
            valueFrom:
              secretKeyRef:
                name: route53-creds
                key: aws-access-key-id
          - name: AWS_SECRET_ACCESS_KEY
            valueFrom:
              secretKeyRef:
                name: route53-creds
                key: aws-secret-access-key
          - name: AWS_DEFAULT_REGION
            value: "us-west-2"
        policy: sync
        interval: "30s"
    ```
1. Click on the **Check extra values** and ensure you get a pass and click **Continue** below.
1. Installation timeout should be 30 minutes.
1. Click on **Run Installation**.