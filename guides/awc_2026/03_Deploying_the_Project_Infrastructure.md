## 03_Deploying_the_Project_Infrastructure.md

### Creating the Project

1. Navigate to **Projects** and create a new Project.
1. Give it the following values:
    - **Name**: {your-user}-awc-hol-proj.
    - **Organization**: `se-sales-cloud`.
    - **Cloud**: Select the Cloud Credential you added previously.
    - Enable Monitoring.
    - Enable Backup Policy and select your backup credential.
    - Enable **Bind Flavor To Project** and choose all the `m6a` instance types.
    - You can leave the rest as default.
1. Attach the Access Profile you created in the previous step or the default one.

### Adding the Cloudera Distribution of Kubernetes (CSK) to your project

1. Deploy your servers by assigning the appropriate roles and AWS Flavors:
    - **Control Planes:** Provision an odd number of servers (min 3 for HA) using the `m6a.xlarge` or `m6a.2xlarge` flavor.
    - **Worker Nodes:** Provision at least one to three nodes using the `m6a.4xlarge` flavor.
    - **Bastion:** Provision a single bastion host using the `m6a.large` or `c5.larg` flavor.
1. Click the **Deploy** button (will be moving) to initiate infrastructure provisioning.

### Preparing the Project (CSK) for Cloudera Anywhere Cloud (AWC)

1. Retrieve your per-user `kubeconfig` from the CCF UI (under the project's **Kubeconfigs** tab).
1. Transfer the configuration file and your private key to the Bastion host, then to the Control Plane nodes:

    ```bash
    # Local Machine -> Bastion Host
    scp -i {private-key} kubeconfig.yaml id_rsa {unix-user}@<bastion-ip-address>:/home/{user}

    # Bastion Host -> Control Plane Nodes
    scp -i {private-key} kubeconfig.yaml id_rsa {unix-user}@<control-plane-ip-address>:/home/{user}
    ```

    ```bash
    chmod 400 id_rsa
    export KUBECONFIG=kubeconfig.yaml
    kubectl get nodes
    ```

1. Alternatively, you can use the built-in console in CCF to access the Kubernetes cluster via the kubeconfig file.

### Namespace & Secret Creation

Run these commands on your management cluster to bootstrap the environment:

```bash
# 1. Create Core Namespace
kubectl create namespace awc-core

# 2. Create Taikun Secrets
kubectl create secret -n awc-core generic awc-taikun-secrets \
--from-literal=MARKETPLACE_REGISTRIES="container.repository.cloudera.com/cloudera/awc/marketplace" \
--from-literal=MARKETPLACE_SYNC_INTERVAL="60" \
--from-literal=TAIKUN_API_HOST="api.ccf-preprod.internal.cloudera.com" \
--from-literal=TAIKUN_PROJECT_ID="xxxx" \
--from-literal=TAIKUN_ACCESS_KEY="xxxxxxx" \
--from-literal=TAIKUN_SECRET_KEY="xxxxx+xxxxx/xxxxxxx=" \
--from-literal=TAIKUN_ACCOUNT_NAME="cloudera"

# 3. Create LDAP Bootstrap Config
kubectl create secret -n awc-core generic ldap-bootstrap-credentials \
--from-literal=username=admin \
--from-literal=password=xxxxx
```
