
# Overview

This repository contains exec plugins for AWS, Google Cloud, and Azure. These plugins provide an easy way to generate a kubeconfig that uses exec plugins for authentication, eliminating the need for installing the respective CLI tools (AWS CLI, Google Cloud SDK, or Azure CLI) on every system where you need to use the kubeconfig.

## Purpose

The goal of these exec plugins is to simplify Kubernetes authentication by providing lightweight, standalone binaries that can be used in kubeconfigs. This approach ensures that users do not need to install and configure heavy CLI tools on their machines, thereby reducing setup complexity and improving security by minimizing dependencies.

## Plugins

### kube-client-go-gcp-exec-plugin

This is a client-go plugin to provide an easy way to have a kube-config that uses a Google service account.

#### Example Kubeconfig

```yaml
apiVersion: v1
kind: Config
current-context: kube-context
contexts:
  - name: kube-context
    context:
      cluster: kube-cluster
      user: kube-user
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
        command: kube-client-go-gcp-exec-plugin
        args:
          - <base64-encoded-service-account-key>
```

#### Building the Binary

To build the binary for the Google Cloud exec plugin, navigate to the `gcp` directory and run the following command:

```sh
make build
```

### kube-client-go-azure-exec-plugin

This is a client-go plugin to provide an easy way to have a kube-config that uses Azure credentials.

#### Example Kubeconfig

```yaml
apiVersion: v1
kind: Config
current-context: kube-context
contexts:
  - name: kube-context
    context:
      cluster: kube-cluster
      user: kube-user
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
        command: kube-client-go-azure-exec-plugin
        args:
          - <azure-client-id>
          - <azure-client-secret>
          - <azure-tenant-id>
```

#### Building the Binary

To build the binary for the Azure exec plugin, navigate to the `azure` directory and run the following command:

```sh
make build
```

### kube-client-go-aws-exec-plugin

This is a client-go plugin to provide an easy way to have a kube-config that uses AWS credentials.

#### Example Kubeconfig

```yaml
apiVersion: v1
kind: Config
current-context: kube-context
contexts:
  - name: kube-context
    context:
      cluster: kube-cluster
      user: kube-user
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
        command: kube-client-go-aws-exec-plugin
        args:
          - <aws-access-key-id>
          - <aws-secret-access-key>
```

#### Building the Binary

To build the binary for the AWS exec plugin, navigate to the `aws` directory and run the following command:

```sh
make build
```

## Build Process

Each plugin directory contains a `Makefile` with a `make build` command that compiles the respective exec plugin binary. The binaries can be uploaded to GitHub Releases for distribution.

To build all plugins, you can navigate to each directory (`gcp`, `azure`, `aws`) and run the `make build` command. The generated binaries will be platform-specific and should be uploaded to the respective GitHub Releases for easy access and use.

```sh
cd gcp
make build

cd ../azure
make build

cd ../aws
make build
```

## Contributions

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
