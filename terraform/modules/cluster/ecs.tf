resource "aws_ecr_repository" "demo" {
  name                 = "${var.env}-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-${var.env}-cluster"
}

resource "aws_ecs_task_definition" "demo" {
  family = "${var.app_name}-${var.env}-td"

  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  container_definitions    = data.template_file.task_definition_template.rendered
}

data "template_file" "task_definition_template" {
  template = templatefile("../modules/cluster/task_definition.json.tpl", {
    ecr_url     = aws_ecr_repository.demo.repository_url,
    app_tag     = var.app_tag,
    app_image_1 = var.app_image_1
    app_image_2 = var.app_image_2
    env         = var.env
  })
}

resource "aws_ecs_service" "demo" {
  name                 = "${var.app_name}-${var.env}-ecs-service"
  cluster              = aws_ecs_cluster.ecs_cluster.id
  task_definition      = aws_ecs_task_definition.demo.arn
  desired_count        = 2
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_alb_target_group.tf_tg.arn
    container_name   = aws_ecs_task_definition.demo.family
    container_port   = 80
  }
}
