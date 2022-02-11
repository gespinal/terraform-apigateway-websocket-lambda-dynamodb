resource "aws_lambda_function" "connect" {
  function_name   = var.lambda-connect
  description        = var.lambda-connect
  handler             = "lambda.lambda_handler"
  runtime             = "python3.8"
  filename            = "./functions/connect.py.zip"
  role                   = aws_iam_role.lambda_exec.arn
  environment {
    variables = {
      stage_uri = ""
    }
  }
}

resource "aws_apigatewayv2_integration" "connect" {
  api_id = aws_apigatewayv2_api.websocket-api.id
  integration_uri    = aws_lambda_function.connect.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "connect" {
  api_id    = aws_apigatewayv2_api.websocket-api.id
  route_key = "$connect"
  target = "integrations/${aws_apigatewayv2_integration.connect.id}"
}

resource "aws_lambda_permission" "connect" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.connect.function_name
  statement_id = "AllowExecutionFromApiGateway"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.websocket-api.execution_arn}/*/$connect"
}

resource "aws_lambda_function" "disconect" {
  function_name   = var.lambda-disconnect
  description        = var.lambda-disconnect
  handler             = "lambda.lambda_handler"
  runtime             = "python3.8"
  filename            = "./functions/disconnect.py.zip"
  role                   = aws_iam_role.lambda_exec.arn
  environment {
    variables = {
      stage_uri = ""
    }
  }
}
