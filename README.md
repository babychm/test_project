# Simple CI/CD built by Terraform for two environments using AWS VPC, Codebuild, ECR, and ECS  

### each project environment contains:

- 2 public subnets
- 2 private subnets
- Internet getaway
- 2 NAT
- Application load balancer
- Autoscaling group
- EC2 instance for init build
- Codebuild
- ECR and ECS

![](img/1.png)

### CI/CD

![](img/2.png)

### for run you need:

1. Install terraform, git, docker and docker-compose

2. Clone this repository
```
git clone <https://github.com/fckurethn/test_project>
```
3. Enter your variables into terraform/dev/terraform.rfvars and terraform/prod/terraform.rfvars
```
env               = "prod"
account_id        = "859431955366"
region            = "eu-central-1"
github_repo       = "https://github.com/fckurethn/test_project/"
github_branch     = "main"
git_trigger_event = "PUSH"
buildspec         = "./terraform/modules/codebuild/buildspec.yml"
app_name          = "test-demo"
app_image_1       = "server"
app_image_2       = "client"
app_tag           = "v1"
instance_type     = "t2.micro"
cidr              = "10.0.0.0/16"
private_subnets = {
  subnet_1 = {
    az   = "eu-central-1a"
    cidr = "10.0.11.0/24"
  }
  subnet_2 = {
    az   = "eu-central-1b"
    cidr = "10.0.22.0/24"
  }
}

public_subnets = {
  subnet_1 = {
    az   = "eu-central-1a"
    cidr = "10.0.1.0/24"
  }
  subnet_2 = {
    az   = "eu-central-1b"
    cidr = "10.0.2.0/24"
  }
}

```
4. To add AWS credentials for example create 2 files
~/.aws/credentials
```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```
~/.aws/config
```
[default]
region = your_aws_region # must be the same as a region in  terragrunt.hcl file
```
or run in terminal
```
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_REGION=your_aws_region # must be the same as a region in  terragrunt.hcl file
```
5. Create two files terraform/dev/secret.rfvars and terraform/prod/secret.tfvars
```
github_token = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # your github token
```

6. Create S3-bucket and DynamoDB table in AWS for remote state and put its names into terraform/dev/terraform.rf and terraform/prod/terraform.rf
```
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "your-s3-bucket-name"
    region         = "eu-central-1"
    key            = "terraform.tfstate"
    dynamodb_table = "your-dynamodb-table-name"
  }
}
```
7. Run Terraform in directory named environment that you want to deploy
```
terraform apply -var-file="secret.tfvars"
```
