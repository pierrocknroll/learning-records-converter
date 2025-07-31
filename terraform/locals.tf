locals {
  service_name = "${var.app_name}-${var.environment}"

  base_env_vars = merge(
    {
      ENVIRONMENT       = var.environment
      APP_INTERNAL_HOST = "0.0.0.0"
      APP_INTERNAL_PORT = tostring(var.port)
    },
    var.log_level != null ? { LOG_LEVEL = var.log_level } : {}
  )
}
