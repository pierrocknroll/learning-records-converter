resource "aws_apprunner_service" "lrc" {
  count = var.deploy_to_aws ? 1 : 0

  service_name = "${var.app_name}-${var.environment}"

  source_configuration {
    image_repository {
      image_configuration {
        port = tostring(var.port)

        runtime_environment_variables = {
          ENVIRONMENT                = var.environment
          LOG_LEVEL                 = var.log_level
          APP_INTERNAL_HOST         = "0.0.0.0"
          APP_INTERNAL_PORT         = tostring(var.port)
#           DOWNLOAD_TIMEOUT          = var.download_timeout
#           CORS_ALLOWED_ORIGINS      = var.cors_allowed_origins
#           PROFILES_NAMES            = var.profiles_names
#           PROFILE_LMS_URL           = "https://raw.githubusercontent.com/gaia-x-dases/xapi-lms/master/profile/profile.jsonld"
#           PROFILE_FORUM_URL         = "https://raw.githubusercontent.com/gaia-x-dases/xapi-forum/master/profile/base.jsonld"
#           PROFILE_ASSESSMENT_URL    = "https://raw.githubusercontent.com/gaia-x-dases/xapi-assessment/add-mandatory-statements/profile/profile.jsonld"
        }

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
    Name        = "${var.app_name}-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
