# Project ID for the GCP deployment
variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "your-project-id" # Insert your project ID here
}

# Region in which to deploy all resources (e.g., São Paulo)
variable "region" {
  description = "GCP region"
  type        = string
  default     = "southamerica-east1" # Insert your region here
}

# Name of the Virtual Private Cloud (VPC) used by all resources
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "brazil-vpc" # Insert your VPC name here
}

# CIDR block for the primary web subnet (used by VM instances)
variable "web_subnet_cidr" {
  description = "CIDR block for Brazil subnet"
  type        = string
  default     = "10.233.40.0/24" # Insert your CIDR block here
}

# CIDR block for the proxy-only subnet (used by HTTP(S) Load Balancer)
variable "proxy_subnet_cidr" {
  description = "CIDR block for proxy-only subnet"
  type        = string
  default     = "10.233.90.0/24" # Insert your proxy-only CIDR block here
}
