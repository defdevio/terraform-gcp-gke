output "cluster_name" {
  description = "GKE cluster name."
  value       = var.cluster_name
}
output "cluster_endpoint" {
  description = "Cluster endpoint."
  value       = try(google_container_cluster.this[0].endpoint, null)
  sensitive   = true
}
output "cluster_location" {
  description = "Cluster zone."
  value       = var.zone
}
output "node_pool_name" {
  description = "Spot node pool name."
  value       = "${var.cluster_name}-spot"
}

