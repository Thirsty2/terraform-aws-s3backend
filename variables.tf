variable "region" {
  description = "AWS region"
  default = "us-west-2"
  type = string
}

variable "account_id" {
    description = "id of account to assume role"
    default = "215974853022"
    type = string
}