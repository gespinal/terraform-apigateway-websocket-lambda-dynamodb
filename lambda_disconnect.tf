resource "aws_apigatewayv2_integration" "disconnect" {
  api_id = aws_apigatewayv2_api.websocket-api.id
  integration_uri    = aws_lambda_function.disconect.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "disconnect" {
  api_id    = aws_apigatewayv2_api.websocket-api.id
  route_key = "$disconnect"
  target = "integrations/${aws_apigatewayv2_integration.disconnect.id}"
}

resource "aws_lambda_permission" "disconnect" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.disconect.function_name
  statement_id = "AllowExecutionFromApiGateway"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket-api.execution_arn}/*/$disconnect"
}
