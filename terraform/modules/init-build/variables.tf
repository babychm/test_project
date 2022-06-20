variable "region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "app_tag" {
  type    = string
  default = "v1"
}

variable "app_image_1" {
  type = string
}

variable "app_image_2" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "env" {
  type = string
}

variable "registry_id" {
  type = string
}

variable "repository_url" {
  type = string
}
