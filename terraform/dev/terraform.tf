terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "mbabych-testdemo-dev-eu-central-1"
    region         = "eu-central-1"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_state_eu_central_1"
  }

}
