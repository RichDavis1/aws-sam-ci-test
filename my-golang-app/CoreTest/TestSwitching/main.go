package main

import (
	"errors"
	"fmt"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var (
	// DefaultHTTPGetAddress Default Address
	DefaultHTTPGetAddress = "https://checkip.amazonaws.com"

	// ErrNoIP No IP found in response
	ErrNoIP = errors.New("No IP in HTTP response")

	// ErrNon200Response non 200 status code in response
	ErrNon200Response = errors.New("Non 200 Response found")
)

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {

	_, err := http.Get(DefaultHTTPGetAddress)
	if err != nil {

		return events.APIGatewayProxyResponse{
			Body:       fmt.Sprintf("you suck"),
			StatusCode: 403,
		}, nil
	}
	/*
		if resp.StatusCode != 200 {
			return events.APIGatewayProxyResponse{}, ErrNon200Response
		}
		/*


			ip, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				return events.APIGatewayProxyResponse{}, err
			}

			if len(ip) == 0 {
				return events.APIGatewayProxyResponse{}, ErrNoIP
			}
	*/
	fmt.Println("test")

	return events.APIGatewayProxyResponse{
		Body:       fmt.Sprintf("Hello World Full process for real, here we go"),
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(handler)
}
