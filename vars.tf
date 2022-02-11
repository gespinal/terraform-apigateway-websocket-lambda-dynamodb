variable "region" {
  default = "us-east-1"
}

variable "stage" {
  default = "my-stage"
}

variable "lambda-connect" {
  default = "my-connect"
}

variable "lambda-disconnect" {
  default = "my-disconnect"
}

variable "lambda-getWord" {
  default = "my-getWord"
}

variable "api-name" {
  default = "api-gwy"
}

variable "stage-name" {
  default = "stage"
}

variable "method" {
  default     = "WEBSOCKET"
}

variable "role-name" {
  default     = "my-role-lambda-api-socket"
}
