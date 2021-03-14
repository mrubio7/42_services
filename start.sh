#_____COLORS_____
END=$'\e[0m'
G=$'\e[32m'
R=$'\e[31m'
B=$'\e[34m'


echo "${G}Deleting old MINIKUBE${END}"
minikube stop
minikube delete

echo "${G}Starting MINIKUBE on VirtualBox${END}"
minikube start localhost:5000 driver=virtualbox

#Docker images
echo "${G}Creating docker images${END}"
docker build ./srcs/nginx -t nginx

#Deploy images
echo "${G}Deploying images into pods${END}"
kubectl apply -f ./srcs/nginx/nginx.yaml

minikube dashboard