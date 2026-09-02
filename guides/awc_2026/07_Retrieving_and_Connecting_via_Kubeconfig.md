## 07_Retrieving_and_Connecting_via_Kubeconfig.md

### Getting your kubeconfig

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

### Checking AWC install progress

To validate that your AWC console is progressing, you will need to gain access to the Kubernetes cluster.

1. Run the following command to validate that you see jobs and pods being created in the `awc-core` namespace.

    ```bash
    kubectl get pods -n awc-core
    ```

1. Verify that there are no pods in `CrashLoopBackOff` state or in `Error` state. If you see pods with these states, reach out to your instructor for further guidance.
