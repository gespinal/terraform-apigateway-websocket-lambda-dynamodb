output "endpoint" {
  value = aws_apigatewayv2_stage.websocket-api-stage.invoke_url
}

output "endpointHTTP" {
  value = replace(aws_apigatewayv2_stage.websocket-api-stage.invoke_url, "wss://", "https://")
}
