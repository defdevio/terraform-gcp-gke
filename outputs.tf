output "cluster_name" {
  description = "GKE cluster name."
  value       = try(google_container_cluster.this[0].name, null)
}
output "cluster_endpoint" {
  description = "Cluster endpoint."
  value       = try(google_container_cluster.this[0].endpoint, null)
  sensitive   = true
}
output "cluster_location" {
  description = "Cluster zone."
  value       = try(google_container_cluster.this[0].location, null)
}
output "node_pool_name" {
  description = "Spot node pool name."
  value       = "${var.cluster_name}-spot"
}
output "node_service_account_email" {
  description = "Dedicated Google service account used by GKE nodes."
  value       = try(google_service_account.node[0].email, null)
}
output "node_service_account_id" {
  description = "Account ID for the dedicated Google service account used by GKE nodes."
  value       = var.node_service_account_id
}

