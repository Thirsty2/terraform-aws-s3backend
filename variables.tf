variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "s3backend"
  type        = string
}

variable "assume_role_account_id" {
  description = "id of AWS account that can assume role"
  type        = string
}

variable "force_destroy_s3" {
  description = "force destroy s3 bucket?"
  default     = true
  type        = bool
}
