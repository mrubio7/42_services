#_____COLORS_____
END=$'\e[0m'
G=$'\e[32m'
R=$'\e[31m'
B=$'\e[34m'

clear

echo "${G}Deleting old MINIKUBE${END}"
minikube stop
minikube delete

echo "${G}Starting MINIKUBE on VirtualBox${END}"
minikube start localhost:5000 driver=virtualbox

#Load Balancer
minikube addons enable metallb
kubectl apply -f ./srcs/metallb/metallb.yaml

#Building images
echo "${G}Creating docker images${END}"
docker build --quiet ./srcs/nginx -t nginx #-----------NGINX

#Deploying images
echo "${G}Deploying images into pods${END}"
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl expose deployment nginx --name=nginx --type=LoadBalancer


minikube dashboard
