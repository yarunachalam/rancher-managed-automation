#!/bin/bash
set -e
PATH=$PATH:/usr/local/bin

#Destroy aks-cluster
destroy_cluster()
{
    terraform destroy -auto-approve
}

#######################################################
# Main Program
# Usage: destroy-csp-nv.sh <cloud provider name>
# Example: destroy-csp-nv.sh gke
########################################################
if (( $# < 1 )); then
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Usage: destroy-csp-nv.sh <cloud provider name>"
    echo "Example: destroy-csp-nv.sh gke
    echo "Possible values for cloud provider eks aks gke
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    exit 0
fi

cloud_provider=${1}
case "$cloud_provider" in
       (aks)
          cd aks-terraform
	  var_file="$PWD"/terraform.tfvars
	  cluster_name=$(grep 'cluster_name' ${var_file} |awk '{ print $3 }'|tr -d '"')
	  resource_group_name=$(grep 'resource_group_name' ${var_file} |awk '{ print $3 }'|tr -d '"')
          echo "Destroying Cluster"
          destroy_cluster
          echo "Destroying Cluster from kubeconfig"
	  kubectl config delete-cluster ${cluster_name}
          echo "Destroying user from kubeconfig"
	  kubectl config delete-user clusterUser_${resource_group_name}_${cluster_name}
          ;;
       (gke)
          cd gke-terraform
	  var_file="$PWD"/terraform.tfvars
	  cluster_name=$(grep 'project_id' ${var_file} |awk '{ print $3 }'|tr -d '"')
	  region=$(grep 'region' ${var_file} |awk '{ print $3 }'|tr -d '"')
          echo "Destroying Cluster"
          destroy_cluster
          echo "Destroying Cluster from kubeconfig"
	  kubectl config delete-context gke_${cluster_name}_${region}_${cluster_name}-gke
	  kubectl config delete-user gke_${cluster_name}_${region}_${cluster_name}-gke
	  kubectl config delete-cluster gke_${cluster_name}_${region}_${cluster_name}-gke
          ;;
       (eks)
          cd eks-terraform
          destroy_cluster
          ;;
       (*)
	  echo "Invalid cloud provider $cloud_provider "
          ;;
esac


#Uninstall Neuvector helm
echo "Uninstalling Neuvector"
helm uninstall neuvector --namespace neuvector

echo "remove neuvector repository "
helm repo remove neuvector
