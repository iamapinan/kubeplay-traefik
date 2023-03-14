#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m' # No Color
LB='\033[1;34m'
YELLOW='\033[1;33m'
CLEAR='\033[2J\033[u'

printf "${YELLOW}Script created by iamapinan.\nFollow me on YouTube channel https://www.youtube.com/@IamApinan${NC}\n"
printf "${YELLOW}Required:\n - helm 3.9 or higher\n - kubectl 1.25 or higher\n - A K8s cluster you have connected\n\n${NC}"
printf "${GREEN}Please enter you namespace:${NC} "
read KUBE_NAMESPACE
printf ${CLEAR}
printf "${LB}Traefik will install to ${GREEN}$KUBE_NAMESPACE ${LB}namespace.${NC}\n"

kubectl create namespace $KUBE_NAMESPACE
# kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
# kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

if ! command -v helm &> /dev/null
then
    printf "${LB}Installing helm3 command.${NC}\n"
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    exit
fi

# # Install helm
# helm repo add traefik https://traefik.github.io/charts
# helm repo update
# helm install traefik traefik/traefik

# # Verify service is running
# kubectl get svc -l app.kubernetes.io/name=traefik
# kubectl get po -l app.kubernetes.io/name=traefik
