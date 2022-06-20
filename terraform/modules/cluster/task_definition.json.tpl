[
  {
    "essential": true,
    "memory": 128,
    "name": "${env}-td",
    "cpu": 2,
    "image": "${ecr_url}:${app_tag}",
    "portMappings": [
      {
        "hostPort": 0,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "environment": []
  }
]
