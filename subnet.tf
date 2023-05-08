resource "google_compute_subnetwork" "subnet"{
  for_each = local.subnets
  project = var.project_id
  name = each.key
  description = format(
    "Subnet %s in network %s managed by terraform",
    each.key,
    var.network_name
  )

  region = each.value.region
  network = var.network_name
  ip_cidr_range = each.value.ip_cidr_range
  private_ip_google_access = each.value.enable_private_google_access
  secondary_ip_range = each.value.purpose == "INTERNAL_HTTPS_LOAD_BALANCER" ? [] : each.value.purpose == "PRIVATE_SERVICE_CONNECT" ? [] : each.value.secondary_ip_ranges == null ? [] : [
    for name, range in each.value.secondary_ip_ranges :
    {range_name = name, ip_cidr_range = range}
  ]
  
  dynamic "log_config" {
    for_each = each.value.flow_logs_config != null ? [""] : []
    content {
      aggregation_interval = each.value.flow_logs_config.aggregation_interval
      filter_expr          = try(each.value.flow_logs_config.filter_expression,null)
      flow_sampling        = each.value.flow_logs_config.flow_sampling
      metadata             = each.value.flow_logs_config.metadata
      metadata_fields = (
        each.value.flow_logs_config.metadata == "CUSTOM_METADATA"
        ? each.value.flow_logs_config.metadata_fields
        : null
      )
    }
  }

  purpose = each.value.purpose
  role = each.value.role

  stack_type = each.value.stack_type
  ipv6_access_type = each.value.ipv6_access_type
  private_ipv6_google_access = each.value.enable_private_google_access_ipv6
  
}