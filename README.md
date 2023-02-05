# rjar-denodo-express

Repository to test the Denodo Express 8 in a local environment using Docker for Windows.

## Requirements

Docker and Docker compose need to be installed in the system.
Minikube need to be installed to use the kubernetes.

## Denodo Documentation

[Official Denodo Express Site](https://www.denodo.com/es/plataforma-denodo/denodo-express#).

[Denodo Platform Container 8.0 QuickStart Guide](https://community.denodo.com/docs/html/document/8.0/en/Denodo%20Platform%20Container%208.0%20QuickStart%20Guide).

[Unattended Installation of the Denodo Platform](https://community.denodo.com/docs/html/browse/8.0/en/platform/installation/unattended_installation_of_the_denodo_platform/unattended_installation_of_the_denodo_platform).

[Denodo Download page](https://community.denodo.com/express/download/). (A Denodo account is required)

## Docker

[Official Docker Site](https://docs.docker.com/engine/installation/).

## Minikube

Use this [link](https://minikube.sigs.k8s.io/docs/start/) to install minikube in your system.

### Enable Ingress Controller

run below command to enable Nginx Ingress controller in Minikube

```pwsh
minikube addons enable ingress
```

## Private Docker Registry

To configure a private docker repository in Minikube run below commands:

### Generate Docker registry certificates

```pwsh
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout ./certs/docker-registry.key -out ./certs/docker-registry.crt  -config ./certs/san.cnf
```

### Generate the authentication user

```pwsh
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn <USERNAME> <PASSWORD> > auth/htpasswd
```

### Create the Docker registry namespace

```pwsh
kubectl create namespace docker-registry
```

### Create the docker registry secrets

```pwsh
kubectl -n docker-registry create secret tls docker-registry-certs-secret --cert=certs/docker-registry.crt --key=certs/docker-registry.key
```

```pwsh
kubectl -n docker-registry create secret generic docker-registry-auth-secret --from-file=auth/htpasswd
```

### Create Access Registry Secret

To be able to use the internal docker registry in the deployments run below command to generate the secret with required credentials.

```pwsh
kubectl create secret docker-registry regcred --docker-server=docker-registry.internal:5000 --docker-username=<USERNAME> --docker-password=<PASSWORD> --docker-email=<USER_EMAIL>
```

### Docker registry cluster access

To grant internal cluster access to the Docker registry run below command.

```pwsh
minikube ssh "echo \"127.0.0.1 docker-registry.internal\" | sudo tee -a  /etc/hosts"
```

### Deploy the private Docker registry.

```pwsh
kubectl apply -f ./kubernetes/docker-registry-deployment.yaml
```

## Denodo

Before build the image get a Denodo express licence.

### Build Denodo Image

```pwsh
docker build -t denodo-express:8.0 -f docker/denodo-express/Dockerfile ./docker/denodo-express
```

### Push Denodo image to Container Registry

```pwsh
docker login docker-registry.internal -u <USERNAME> -p <PASSWORD>
docker tag denodo-express:8.0 docker-registry.internal:5000/denodo-express:8.0
docker push docker-registry.internal:5000/denodo-express:8.0
docker logout
```

### Create Denodo express Namespace

```pwsh
kubectl create namespace denodo-express
```

### Add Denodo Express licence to cluster

```pwsh
kubectl -n denodo create configmap denodo-license --from-file=denodo.lic=./docker/denodo-express/denodo-express.lic
```

### Deploy Denodo in Minikube Cluster

kubectl apply -f ./kubernetes/denodo-express-deployment.yaml
