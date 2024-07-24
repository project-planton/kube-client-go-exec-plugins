package main

import (
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sts"
)

// execCredentialResponseFormatString defines the output format for Kubernetes exec credential plugin
const execCredentialResponseFormatString = `{
  "apiVersion": "client.authentication.k8s.io/v1",
  "kind": "ExecCredential",
  "status": {
    "token": "%s"
  }
}
`

func main() {
	if len(os.Args) != 3 {
		log.Fatalf("AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are required as arguments")
	}
	accessKeyID := os.Args[1]
	secretAccessKey := os.Args[2]

	// Create a new AWS session with the provided credentials
	sess, err := session.NewSession(&aws.Config{
		Credentials: credentials.NewStaticCredentials(accessKeyID, secretAccessKey, ""),
		Region:      aws.String("us-west-2"), // Specify your region
	})
	if err != nil {
		log.Fatalf("failed to create AWS session: %v", err)
	}

	// Create a new STS client
	stsClient := sts.New(sess)

	// Get session token
	tokenOutput, err := stsClient.GetSessionToken(&sts.GetSessionTokenInput{})
	if err != nil {
		log.Fatalf("failed to get session token: %v", err)
	}

	// Extract the session token
	token := tokenOutput.Credentials.SessionToken

	// Print the token in the required format
	fmt.Println(fmt.Sprintf(execCredentialResponseFormatString, *token))
}
