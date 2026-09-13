variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "zone" {
  type    = string
  default = "us-central1-a"
}
variable "access_token" {
  type      = string
  default   = null
  sensitive = true
}
variable "create_resources" {
  type    = bool
  default = true
}
variable "cluster_name" {
  type    = string
  default = "opendepot-demo"
}
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "pods_range_name" {
  type    = string
  default = "gke-pods"
}
variable "services_range_name" {
  type    = string
  default = "gke-services"
}
variable "node_machine_type" {
  type    = string
  default = "e2-standard-2"
}
variable "node_service_account" {
  type    = string
  default = null
}

