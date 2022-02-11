resource "aws_apigatewayv2_api" "websocket-api" {
  name              = var.api-name
  protocol_type = var.method
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_deployment" "deploy" {
  api_id      = aws_apigatewayv2_api.websocket-api.id
  description = "websocket-api-deployment"
  triggers = {
    redeployment = sha1(join(",", [
      jsonencode(aws_apigatewayv2_integration.connect),
      jsonencode(aws_apigatewayv2_route.connect),
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "websocket-api-stage" {
  api_id = aws_apigatewayv2_api.websocket-api.id
  name          = var.stage-name
  auto_deploy = true
  route_settings {
    route_key                        = aws_apigatewayv2_route.connect.route_key
    detailed_metrics_enabled = true
  }
  default_route_settings {
    throttling_rate_limit = 100
    throttling_burst_limit = 50
  }
}
