## 06_Deploying_Anywhere_Cloud_Chart.md

* From the **Explore Applications** menu, select the **`anywhere-cloud`** top-level Helm chart (version 1.0.0-b24).
* Ensure your target namespace is set to `awc-core`.
* In the **Extra Values** configuration block, inject the following parameters:

```yaml
dns:
  baseDomain: "a97996.test.cldr.work"
  clusterDomain: "awcf.a97996.test.cldr.work"
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
