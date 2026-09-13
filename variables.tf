variable "project_id" {
  description = "Google Cloud project for the GKE cluster."
  type        = string
}

variable "region" {
  description = "Google Cloud region used by the provider."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zonal location for the GKE cluster and node pool."
  type        = string
  default     = "us-central1-a"
}

variable "access_token" {
  description = "Optional Google access token for authenticated operations."
  type        = string
  default     = null
  sensitive   = true
}

variable "create_resources" {
  description = "Whether to create the GKE cluster and node resources. Set false for credential-free validation."
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Name of the GKE cluster."
  type        = string
  default     = "opendepot-demo"
}

variable "network" {
  description = "VPC network name or self-link for the cluster."
  type        = string
}

variable "subnetwork" {
  description = "Subnet name or self-link for the cluster."
  type        = string
}

variable "pods_range_name" {
  description = "Name of the existing secondary range used for GKE pods."
  type        = string
  default     = "gke-pods"
}

variable "services_range_name" {
  description = "Name of the existing secondary range used for GKE services."
  type        = string
  default     = "gke-services"
}

variable "node_machine_type" {
  description = "Compute Engine machine type for GKE nodes."
  type        = string
  default     = "e2-standard-2"
}

variable "node_service_account_id" {
  description = "Account ID for the dedicated Google service account used by GKE nodes."
  type        = string
  default     = "opendepot-gke-nodes"
}

