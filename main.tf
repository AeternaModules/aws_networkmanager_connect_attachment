resource "aws_networkmanager_connect_attachment" "networkmanager_connect_attachments" {
  for_each = var.networkmanager_connect_attachments

  core_network_id         = each.value.core_network_id
  edge_location           = each.value.edge_location
  transport_attachment_id = each.value.transport_attachment_id
  routing_policy_label    = each.value.routing_policy_label
  tags                    = each.value.tags
  tags_all                = each.value.tags_all

  options {
    protocol = each.value.options.protocol
  }
}

