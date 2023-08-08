### rancher-managed-automation
Rancher downstream cluster aoutomation for EKS,AKS,GKE

This repo contains deployment of EKS, AKS and GKE Cluster in Rancher as a downstream cluster

### Cluster Deployment using Terraform script


-Provision Azure Kubernetes Service - AKS cluster 

-Provision Google Kubernetes Engine - GKE cluser

-Configure kubectl

-Imports created cluster in Rancher

-Prints rancher usage record account after importing the cluster

### Install CSP Billing Adapter Neuvector helm chart

After cloning this repo
```
$ cd rancher-managed-automation/setups
$ cp terrafrom.template.example terrafrom.tfvars
Update terraform.tfvars values required for rancher, eks, aks and gke 

$terraform init
$terraform plan

Possible module values for terraform apply
module.provision_eks_cluster
module.provision_aks_cluster
module.provision_gke_cluster
if module is not provided, by default it create all 3 cluster

$terraform apply terraform apply -target=<module name>


To destroy cluster
$ cd rancher-managed-automation/setups
$ terraform destroy
