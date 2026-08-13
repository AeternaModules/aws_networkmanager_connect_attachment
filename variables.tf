variable "networkmanager_connect_attachments" {
  description = <<EOT
Map of networkmanager_connect_attachments, attributes below
Required:
    - core_network_id
    - edge_location
    - transport_attachment_id
    - options (block):
        - protocol (optional)
Optional:
    - routing_policy_label
    - tags
    - tags_all
EOT

  type = map(object({
    core_network_id         = string
    edge_location           = string
    transport_attachment_id = string
    routing_policy_label    = optional(string)
    tags                    = optional(map(string))
    tags_all                = optional(map(string))
    options = object({
      protocol = optional(string)
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_connect_attachments : (
        (length(v.core_network_id) >= 0 && length(v.core_network_id) <= 50) && (can(regex("^core-network-([0-9a-f]{8,17})$", v.core_network_id)))
      )
    ])
    error_message = "all of: must be between 0 and 50 characters; Must start with core-network and then have 8 to 17 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_connect_attachments : (
        (length(v.edge_location) >= 1 && length(v.edge_location) <= 63) && (can(regex("[\\s\\S]*", v.edge_location)))
      )
    ])
    error_message = "all of: must be between 1 and 63 characters; Anything but whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_connect_attachments : (
        v.routing_policy_label == null || (length(v.routing_policy_label) >= 0 && length(v.routing_policy_label) <= 256)
      )
    ])
    error_message = "must be between 0 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkmanager_connect_attachments : (
        (length(v.transport_attachment_id) >= 0 && length(v.transport_attachment_id) <= 50) && (can(regex("^attachment-([0-9a-f]{8,17})$", v.transport_attachment_id)))
      )
    ])
    error_message = "all of: must be between 0 and 50 characters; Must start with attachment- and then have 8 to 17 characters"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

