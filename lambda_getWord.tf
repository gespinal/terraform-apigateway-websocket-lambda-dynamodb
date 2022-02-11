
resource "aws_lambda_function"  "getWord" {
  function_name   = var.lambda-getWord
  description        = var.lambda-getWord
  handler             = "lambda.lambda_handler"
  runtime             = "python3.8"
  filename            = "./functions/getWord.py.zip"
  role                   = aws_iam_role.lambda_exec.arn
  environment {
    variables = {
        stage_uri = replace(aws_apigatewayv2_stage.websocket-api-stage.invoke_url, "wss://", "https://")
    }
  }
   depends_on = [aws_apigatewayv2_stage.websocket-api-stage]
} 

resource "aws_apigatewayv2_integration" "getWord" {
  api_id = aws_apigatewayv2_api.websocket-api.id
  integration_uri    = aws_lambda_function.getWord.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "getWord" {
  api_id    = aws_apigatewayv2_api.websocket-api.id
  route_key = "getWord"
  target = "integrations/${aws_apigatewayv2_integration.getWord.id}"
}

resource "aws_lambda_permission" "getWord" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getWord.function_name
  statement_id = "AllowExecutionFromApiGateway"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket-api.execution_arn}/*/getWord"  
}
