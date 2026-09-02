## 07_Retrieving_and_Connecting_via_Kubeconfig.md

* Retrieve your per-user `kubeconfig` from the CCF UI (under the project's **Kubeconfigs** tab).
* Transfer the configuration file and your private key to the Bastion host, then to the Control Plane nodes:

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
