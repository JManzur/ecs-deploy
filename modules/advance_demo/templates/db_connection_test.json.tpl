[
  {
    "name": "${app_name}",
    "image": "${app_image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "memoryReservation": ${memory},
    "resourceRequirements": null,
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${app_port},
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
         "name": "AWS_DEFAULT_REGION",
          "value": "${aws_region}"
      }
    ],
    "environmentFiles": [],
    "secrets": [
       {
          "name": "MYSQL_HOST",
          "valueFrom": "${MYSQL_HOST}"
       },
       {
          "name": "MYSQL_PORT",
          "valueFrom": "${MYSQL_PORT}"
       },
       {
          "name": "MYSQL_DB",
          "valueFrom": "${MYSQL_DB}"
       },
       {
          "name": "MYSQL_USER",
          "valueFrom": "${MYSQL_USER}"
       },
       {
          "name": "MYSQL_PASSWD",
          "valueFrom": "${MYSQL_PASSWD}"
       }
    ],
    "mountPoints": null,
    "volumesFrom": null,
    "hostname": null,
    "user": null,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${app_cw_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${app_cw_stream}"
      }
    },
    "extraHosts": null,
    "ulimits": null,
    "dockerLabels": null,
    "dependsOn": null,
    "healthCheck": null,
    "interval": 60,
    "timeout": 10,
    "startPeriod": 30,
    "retries": 1
  }
]