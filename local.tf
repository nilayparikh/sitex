locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".json" = "application/json"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".xml"  = "application/xml"
    ".pdf"  = "application/pdf"
    ".txt"  = "text/plain"
  }

  auto_tags = {
    "region_short_name"     = var.region.short_name
    "region_qualified_name" = var.region.qualified_name
    "project"               = var.project
    "environment"           = var.env
  }

  exclude_patterns = [
    "**/*.scss"
  ]

  # cloudflare_domain_recrods = { for site in var.static_site_config : site.domain != null && site.domain.cloudflare != null ? site.domain.name : null => site != null && site.domain.cloudflare != null ? site : null }

  # cloudflare_asverify_domain_records = { for site in var.static_site_config : site.domain != null && site.domain.cloudflare != null && site.domain.asverify_enabled == true ? site.domain.name : null => site != null && site.domain.cloudflare != null && site.domain.asverify_enabled == true ? site : null }

  # html_files = merge([
  #   for config in var.static_site_config : {
  #     for file in fileset(format("%s/%s", path.root, config.src), "**") : format("%s/%s/%s", path.root, config.src, file) => { "config" : config, "file" : file } if !anytrue([for pattern in local.exclude_patterns : can(regex(pattern, file))])
  #   }
  # ]...)

  html_files = {
    for file in fileset(format("%s/%s", path.root, var.static_site_config.src), "**") : format("%s/%s/%s", path.root, var.static_site_config.src, file) => { "config" : var.static_site_config, "file" : file } if !anytrue([for pattern in local.exclude_patterns : can(regex(pattern, file))])
  }
}
