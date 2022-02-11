
## Simple terraform deployment for creating a websocket-based API in AWS API Gateway using lambda and DynamoDB. 

### This API queries a simple dynamodb table and shows the response on the client screen.

#### Localhost requirements

- AWS cli and profile
- Terraform
- NodeJS
- wscat

#### AWS requirements

- DynamoDB database name: vocabulary
- Collection: [{ “word”: “car“}, {“word“: “truck“}, {“word“:“banana“}]


### Terraform deploy

```
  terraform init
  terraform plan
  terraform apply
```

#### Connect using wscat:
```
  wscat -c wss://1cvlnb80ck.execute-api.us-east-1.amazonaws.com/apistage
```

#### Call API:
```
  {"action": "getWord"}
```
