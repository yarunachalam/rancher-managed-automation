variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}
variable "rancher_url" { }

variable "rancher_token" { }

# Hack: Time to wait for Kubernetes to deploy
variable "delaysec" {
        default = 120
}
variable "client_id" { }
variable "client_secret" { }
variable "subscription_id" { }
variable "tenant_id" { }
