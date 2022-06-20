[
  {
    "essential": true,
    "memory": 256,
    "name": "${app_name}-${app_image_1}-${env}-td",
    "cpu": 2,
    "image": "${ecr_url}:${app_image_1}-${app_tag}",
    "portMappings": [
      {
        "hostPort": 4000,
        "protocol": "tcp",
        "containerPort": 4000
      }
    ],
    "environment": []
  },
  {
    "essential": true,
    "memory": 256,
    "name": "${app_name}-${app_image_2}-${env}-td",
    "cpu": 2,
    "image": "${ecr_url}:${app_image_2}-${app_tag}",
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "environment": []
  }
]
