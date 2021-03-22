#_____COLORS_____
END=$'\e[0m'
G=$'\e[32m'
R=$'\e[31m'
B=$'\e[34m'
#________________

clear

echo "${B}Deleting old MINIKUBE${END}"
minikube stop
minikube delete

echo "${B}Starting MINIKUBE${END}"
minikube start --vm-driver=virtualbox

eval $(minikube docker-env)

#Load Balancer
minikube addons enable metallb
kubectl apply -f ./srcs/metallb/metallb.yaml

#Building images
echo "${B}Creating docker images${END}"
docker build --quiet ./srcs/nginx -t my-nginx #-----------NGINX
docker build --quiet ./srcs/mysql -t my-mysql #-----------MYSQL

#Deploying images
echo "${B}Deploying images${END}"
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl expose deployment nginx --name=nginx --type=LoadBalancer

kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl expose deployment mysql --name=mysql --type=ClusterIP

echo "${B}NGINX IP:${END} ${G}192.168.99.100:80${END}"
echo "${B}MYSQL IP:${END} ${G}0.0.0.0:${END}"
echo "${B}PHPMYADMIN IP:${END} ${G}0.0.0.0:${END}"
echo "${B}WORDPRESS IP:${END} ${G}0.0.0.0:${END}"
echo "${B}GRAFANA IP:${END} ${G}0.0.0.0:${END}"
echo " "
echo "·------------------------------------------·"
echo "| MySQL | PhpMyAdmin | Wordpress | Grafana |"
echo "|------------------------------------------|"
echo "| mysql | phpmyadmin | wordpress | grafana |"
echo "| pw123 |   pw123    |   pw123   |  pw123  |"
echo "·------------------------------------------·"

minikube dashboard