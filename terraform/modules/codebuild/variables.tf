variable "account_id" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_image_1" {
  type = string
}

variable "app_image_2" {
  type = string
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "vpc_id" {}

/*variable "private_subnets_ids" {
  type = list(any)
}
*/
variable "public_subnets_ids" {}

variable "github_repo" {
  type = string
}

variable "github_oauth_token" {
  type = string
}

variable "git_trigger_event" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "buildspec" {
  default = "buildspec.yml"
}

variable "task_definition_family" {
  type = string
}

variable "task_definition_cluster" {
  type = string
}

variable "task_definition_service" {
  type = string
}
