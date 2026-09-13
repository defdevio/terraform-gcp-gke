resource "google_service_account" "node" {
  count        = var.create_resources ? 1 : 0
  project      = var.project_id
  account_id   = var.node_service_account_id
  display_name = "OpenDepot GKE node service account"
}

resource "google_container_cluster" "this" {
  count                    = var.create_resources ? 1 : 0
  name                     = var.cluster_name
  project                  = var.project_id
  location                 = var.zone
  network                  = var.network
  subnetwork               = var.subnetwork
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  enable_shielded_nodes    = true

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "spot" {
  count      = var.create_resources ? 1 : 0
  name       = "${var.cluster_name}-spot"
  project    = var.project_id
  location   = var.zone
  cluster    = google_container_cluster.this[0].name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    machine_type    = var.node_machine_type
    spot            = true
    service_account = google_service_account.node[0].email
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}

