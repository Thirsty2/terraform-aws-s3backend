provider "aws" {
  region = "eu-west-1"
}

module "s3backend" {
  source    = "../../"
  namespace = "default"
}
