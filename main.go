package main

import (
	"context"
	"encoding/base64"
	"fmt"
	"golang.org/x/oauth2"
	auth "golang.org/x/oauth2/google"
	"log"
	"os"
)

//execCredentialResponseFormatString https://kubernetes.io/docs/reference/access-authn-authz/authentication/#input-and-output-formats
const execCredentialResponseFormatString = `{
  "apiVersion": "client.authentication.k8s.io/v1",
  "kind": "ExecCredential",
  "status": {
    "token": "%s"
  }
}
`

func main() {
	if len(os.Args) == 1 {
		log.Fatalf("base64 encoded service account json key is required as argument")
	}
	serviceAccountKeyBase64Encoded := os.Args[1]
	serviceAccountKeyBytes, err := base64.StdEncoding.DecodeString(serviceAccountKeyBase64Encoded)
	if err != nil {
		log.Fatalf("failed to decode base64 encoded kubeconfig. err: %v", err)
	}
	var token *oauth2.Token
	scopes := []string{"https://www.googleapis.com/auth/cloud-platform"}
	credentials, err := auth.CredentialsFromJSON(context.Background(), serviceAccountKeyBytes, scopes...)
	if err != nil {
		log.Fatalf("failed to get credential from json. err: %v", err)
	}
	token, err = credentials.TokenSource.Token()
	if err != nil {
		log.Fatalf("failed to get token from token source. err: %v", err)
	}
	fmt.Println(fmt.Sprintf(execCredentialResponseFormatString, token.AccessToken))
}
