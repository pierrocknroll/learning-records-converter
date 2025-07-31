resource "aws_apprunner_service" "lrc" {
  count = var.deploy_to_aws ? 1 : 0

  service_name = local.service_name

  source_configuration {
    image_repository {
      image_configuration {
        port = tostring(var.port)

        runtime_environment_variables = local.base_env_vars

        start_command = "gunicorn --config gunicorn.conf.py app.main:app"
      }

      image_identifier      = var.docker_image
      image_repository_type = "ECR_PUBLIC"
    }

    auto_deployments_enabled = false
  }

  instance_configuration {
    cpu    = "0.5 vCPU"
    memory = "1 GB"
  }

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 10
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name        = local.service_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
