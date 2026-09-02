## 04_DNS_and_Route53_Configuration.md

1. Create IAM Policy for Route53 Hosted Zones.
1. If this is already created, reuse the existing policy.
1. Ensure your AWS IAM user has this policy attached:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:GetHostedZone",
        "route53:ListResourceRecordSets",
        "route53:ChangeResourceRecordSets",
        "route53:GetChange"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/xxxx",
        "arn:aws:route53:::change/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListHostedZonesByName"
      ],
      "Resource": "*"
    }
  ]
}
```

# Create the external-dns namespace

```bash
kubectl create namespace external-dns
```

# Create Route53 credentials secret

```bash
kubectl create secret generic route53-creds \
-n external-dns \
--from-literal=aws-access-key-id="xxxxx" \
--from-literal=aws-secret-access-key="xxxx/xxxx+xxxx"
```
