#!/bin/bash
set -e
PATH=$PATH:/usr/local/bin

#Deploy cluster
cluster_deploy()
{
  echo "Current dir $PWD"
  echo "Deploying Cluster..."
  terraform init
  terraform plan -input=false
  terraform apply -input=false -auto-approve
}

#######################################################
# Main Program
# Usage: deploy-csp-nv.sh <cloud provider name>
# Example: deploy-csp-nv.sh gke 
########################################################
if (( $# < 1 )); then 
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Usage: deploy-csp-nv.sh <cloud provider name>"
    echo "Example: deploy-csp-nv.sh gke" 
    echo "Possible values for cloud provider eks aks gke" 
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

cloud_provider=${1}
case "$cloud_provider" in
       (aks)
          cd aks-terraform
          cluster_deploy
	  state_file="$PWD"/terraform.tfstate
	  var_file="$PWD"/terraform.tfvars
	  sub_id=$(grep -m1 'subscriptions' $state_file | awk -F/ '{ print $3 }')
          resource_group_name=$(grep 'resource_group_name' ${var_file} |awk '{ print $3 }'|tr -d '"')
          cluster_name=$(grep 'cluster_name' ${var_file} |awk '{ print $3 }'|tr -d '"')
	  az account set --subscription ${sub_id}
          az aks get-credentials --resource-group ${resource_group_name} --name ${cluster_name}
          ;;
       (gke)
          cd gke-terraform
          cluster_deploy
          #Get all the required parameters to add config in kube config
	  var_file="$PWD"/terraform.tfvars
          project_id=$(grep 'project_id' ${var_file} |awk '{ print $3 }'|tr -d '"')
          region=$(grep 'region' ${var_file} |awk '{ print $3 }'|tr -d '"')
          cluster_name="${project_id}-gke"
          echo "get credentials .."
          gcloud container clusters get-credentials ${cluster_name} --zone ${region} --project ${project_id}
          ;;
       (eks)
          cd eks-terraform
          cluster_deploy
          ;;
       (*)
       echo "Invalid cloud provider $cloud_provider "
       ;;
esac


#Install Neuvector
echo "Add neuvector repo and Install Neuvector.."
helm repo add neuvector https://neuvector.github.io/neuvector-helm/
helm install neuvector neuvector/core -n neuvector --create-namespace -f "$PWD"/nv-values.yaml


#Wait till all pods are ready 
kubectl wait pod --all --for=condition=Ready --namespace=neuvector --timeout=120s

#List all the pods and service 
kubectl get pods -n neuvector
kubectl get svc -n neuvector
service_ip=$(kubectl get svc --namespace neuvector neuvector-service-webui -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

#print NV dashboard access details
echo "service_ip and port for neuvector webui access ${service_ip}"
echo "https://${service_ip}:8443"
echo "default login admin/admin"
