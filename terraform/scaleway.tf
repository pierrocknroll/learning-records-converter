resource "scaleway_container_namespace" "lrc" {
  count = var.deploy_to_scaleway ? 1 : 0

  name   = "${var.app_name}-${var.environment}"
  region = var.scaleway_region

  environment_variables = {
    ENVIRONMENT               = var.environment
    LOG_LEVEL                 = var.log_level
    APP_INTERNAL_HOST         = "0.0.0.0"
    APP_INTERNAL_PORT         = tostring(var.port)
#     DOWNLOAD_TIMEOUT          = var.download_timeout
#     CORS_ALLOWED_ORIGINS      = var.cors_allowed_origins
#     PROFILES_NAMES            = var.profiles_names
#     PROFILE_LMS_URL           = "https://raw.githubusercontent.com/gaia-x-dases/xapi-lms/master/profile/profile.jsonld"
#     PROFILE_FORUM_URL         = "https://raw.githubusercontent.com/gaia-x-dases/xapi-forum/master/profile/base.jsonld"
#     PROFILE_ASSESSMENT_URL    = "https://raw.githubusercontent.com/gaia-x-dases/xapi-assessment/add-mandatory-statements/profile/profile.jsonld"
  }
}

resource "scaleway_container" "lrc" {
  count = var.deploy_to_scaleway ? 1 : 0

  namespace_id   = scaleway_container_namespace.lrc[0].id
  name           = "${var.app_name}-${var.environment}"
  registry_image = var.docker_image

  port         = var.port
  memory_limit = var.memory_limit
  cpu_limit    = var.cpu_limit
  timeout      = var.timeout

  min_scale = 0
  max_scale = 10

  privacy = "public"
  deploy  = true
}
