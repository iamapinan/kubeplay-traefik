# Easy way Kubernetes and Traefik implement.  
This repository is a tutorial and tools to implement Traefik proxy on Kubernetes cluster.  
More information about Traefik Proxy you can read from [here](https://doc.traefik.io/traefik/)  
![](https://doc.traefik.io/traefik/assets/img/traefik-architecture.png)  

## Easy way to install traefik to you Kubernetes cluster.
`Support only MacOS, Linux  `
```
$ curl -O https://raw.githubusercontent.com/iamapinan/kubeplay-nginx-wordpress/main/traefik-setup.sh
$ chmod +x traefik-setup.sh
$ ./traefik-setup.sh
```

## Step by step to install Traefik proxy on Kubernetes
1. Install Traefik Resource Definitions  
```
$ kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
```

2. Install RBAC for Traefik  
```
$ kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
```

3. Install Traefik Helmchart  
```
$ helm repo add traefik https://traefik.github.io/charts
$ helm repo update
$ helm install traefik traefik/traefik
```
4. Verify service is running
```
$ kubectl get svc -l app.kubernetes.io/name=traefik
$ kubectl get po -l app.kubernetes.io/name=traefik
```
> `**After this step you need to edit namespace and detail in all files. If you implement by shell script the next step is here.**`  

### How to create secrete
```
$ htpasswd -nB user | tee auth-secret
# New password:
# Re-type new password:
# Example output user:$2y$05$W4zCVrqGg8wKtIjOAU.gGu8MQC9k7sH4Wd1v238UfiVuGkf0xfDUu

# Dry run to create a secret deployment.
$ kubectl create secret generic -n traefik dashboard-auth-secret \
--from-file=users=auth-secret -o yaml --dry-run=client | tee dashboard-secret.yaml

```
This will automatic create a deployment file `dashboard-secret.yaml`  
Copy users secret from `dashboard-secret.yaml` and replace in `traefik-dashboard.yaml`  

5. Enable traefik dashbaord  
 `kubectl apply -f traefik-dashboard.yaml`

6. Deploy your nginx  
 `kubectl apply -f nginx-deployment.yaml`

7. Deploy traefik ingress routes  
`kubectl apply -f ingress-deployment.yaml`

### To install helm command line.
``` 
$ curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```


LICENSE MIT

### Contact
- Apinan Woratrakun (iamapinan)
- Email: iamapinan(at)gmail(dot)com
- YouTube: https://www.youtube.com/@IamApinan
- Facebook: https://facebook.com/9apinan 
  
🙏  Please support me by subscribe on my [YouTube Channel](https://www.youtube.com/@IamApinan)