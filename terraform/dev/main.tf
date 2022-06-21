module "vpc" {
  source = "../modules/vpc"

  app_name       = var.app_name
  region         = var.region
  env            = var.env
  cidr           = var.cidr
  public_subnets = var.public_subnets
  #  private_subnets = var.private_subnets
}

module "cluster" {
  source      = "../modules/cluster"
  app_name    = var.app_name
  app_tag     = var.app_tag
  app_image_1 = var.app_image_1
  app_image_2 = var.app_image_2
  env         = var.env
  region      = var.region
  vpc_id      = module.vpc.vpc_id
  #private_subnets_ids = module.vpc.private_subnets_ids
  public_subnets_ids = module.vpc.public_subnets_ids
  instance_type      = var.instance_type
  github_repo        = var.github_repo

  depends_on = [module.vpc]
}

module "init-build" {
  source         = "../modules/init-build"
  account_id     = var.account_id
  region         = var.region
  github_repo    = var.github_repo
  app_tag        = var.app_tag
  app_image_1    = var.app_image_1
  app_image_2    = var.app_image_2
  env            = var.env
  registry_id    = module.cluster.registry_id
  repository_url = module.cluster.repository_url

  depends_on = [module.cluster]
}

module "codebuild" {
  source = "../modules/codebuild"

  account_id  = var.account_id
  app_name    = var.app_name
  app_image_1 = var.app_image_1
  app_image_2 = var.app_image_2
  region      = var.region
  env         = var.env
  vpc_id      = module.vpc.vpc_id
  #private_subnets_ids     = module.vpc.private_subnets_ids
  public_subnets_ids      = module.vpc.public_subnets_ids
  repository_url          = module.cluster.repository_url
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  git_trigger_event       = var.git_trigger_event
  github_oauth_token      = var.github_oauth_token
  buildspec               = var.buildspec
  task_definition_family  = module.cluster.task_definition_family
  task_definition_cluster = module.cluster.task_definition_cluster
  task_definition_service = module.cluster.task_definition_service

  depends_on = [module.cluster, module.init-build]
}
