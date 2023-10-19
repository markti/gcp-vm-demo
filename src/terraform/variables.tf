variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "gcp_project" {
  type = string
}
variable "primary_region" {
  type = string
}
variable "frontend_image_name" {
  type = string
}
variable "frontend_machine_type" {
  type = string
}
variable "backend_image_name" {
  type = string
}
variable "backend_instance_type" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "network_cidr_block" {
  type = string
}
variable "az_count" {
  type = number
}