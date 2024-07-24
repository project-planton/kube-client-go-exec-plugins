package main

import (
	"context"
	"fmt"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/policy"
	"log"
	"os"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

const execCredentialResponseFormatString = `{
  "apiVersion": "client.authentication.k8s.io/v1",
  "kind": "ExecCredential",
  "status": {
    "token": "%s"
  }
}
`

func main() {
	if len(os.Args) < 3 {
		log.Fatalf("Usage: %s <azure-client-id> <azure-client-secret> [tenant-id]", os.Args[0])
	}

	clientId := os.Args[1]
	clientSecret := os.Args[2]
	tenantId := ""
	if len(os.Args) == 4 {
		tenantId = os.Args[3]
	}

	if clientId == "" || clientSecret == "" || tenantId == "" {
		fmt.Println("Usage: go run main.go --client-id <client-id> --client-secret <client-secret> --tenant-id <tenant-id>")
		os.Exit(1)
	}

	// Create a new client secret credential
	cred, err := azidentity.NewClientSecretCredential(tenantId, clientId, clientSecret, nil)
	if err != nil {
		log.Fatalf("Failed to create credential: %v", err)
	}

	// Get an access token
	token, err := cred.GetToken(context.TODO(), policy.TokenRequestOptions{
		Scopes: []string{"https://management.azure.com/.default"},
	})
	if err != nil {
		log.Fatalf("Failed to get token: %v", err)
	}

	fmt.Printf(execCredentialResponseFormatString, token.Token)
}
