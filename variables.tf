variable "account_id" {
    description = "id of account to assume role"
    type = string
}

variable "force_destroy" {
  description = "force destroy s3 bucket?"
  default = false
  type = bool
}