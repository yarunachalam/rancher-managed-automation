### csp-adapter-neuvector-automation 
CSP Billing Adapter Neuvector Automation

This repo contains deployment of AKS and GKE Cluster and CSP Biilling Adapter Neuvector Helm installation(CSP billing adapter NV - helm char in progress).

### Cluster Deployment using Terraform script
-Provision Azure Kubernetes Service - AKS cluster 

-Provision Google Kubernetes Engine - GKE cluser

Configure kubectl

### Install CSP Billing Adapter Neuvector helm chart

After cloning this repo
```
$ cd aks-terraform 
$ cp terrafrom.template.tfvars terrafrom.tfvars
Update terraform.tfvars values 

$ cd gke-terraform 
$ cp terrafrom.template.tfvars terrafrom.tfvars
Update terraform.tfvars values 

Run deploy-csp-nv.sh <cloud provider value>
$ cd ..
$ ./deploy-csp-nv.sh <eks/aks/gke>

To destroy cluster ,uninstall Neuvector and remove cluster from kube config
Run destroy-csp-nv.sh <cloud provider value>
$ cd ..
$ ./destro-csp-nv.sh <eks/aks/gke>
