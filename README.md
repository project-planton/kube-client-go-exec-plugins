# kube-client-go-google-credential-plugin

This is a client-go plugin to provide an easy way to have a kubeconfig that uses google service account.

```yaml
apiVersion: v1
kind: Config
current-context: kube-context
contexts: [{name: kube-context, context: {cluster: kube-cluster, user: kube-user}}]
clusters:
  - name: kube-cluster
    cluster:
      server: <cluster-endpoint>
      certificate-authority-data: <cert-auth-data>
users:
  - name: kube-user
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1
        interactiveMode: Never
        command: kube-google-credential-plugin
        args:
          - <base64-encoded-service-account-key>
```
