#!/bin/bash

Red='\033[0;31m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Green='\033[0;32m'
Yellow='\033[1;33m'
NC='\033[0m' # No Color
CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"

# Creating a cluster
echo -e "${Green}**************************${NC}"
echo -e "${Green}*** Creating a cluster ***${NC}"
echo -e "${Green}**************************${NC}"
minikube start
echo -e "${CHECK_MARK} ${Green}The cluster has been createed successfully${NC}"

# Pointing local shell to minikube's docker-daemon
eval $(minikube docker-env)
echo -e "${CHECK_MARK} ${Green}Pointing local shell to minikube's docker-daemon${NC}"

echo -e "${Green}**************************${NC}"
echo -e "${Green}**** Creating images *****${NC}"
echo -e "${Green}**************************${NC}"

docker build -t nginximage ./srcs/nginx >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating nginx image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating nginx image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating nginx image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Nginx image was created successfully"

docker build -t phpmyadminimage ./srcs/phpmyadmin >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating phpmyadmin image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating phpmyadmin image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating phpmyadmin image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Phpmyadmin image was created successfully"

docker build -t wordpressimage ./srcs/wordpress >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating wordpress image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating wordpress image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating wordpress image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Wordpress image was created successfully"

docker build -t influxdbimage ./srcs/influxdb >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating influxdb image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating influxdb image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating influxdb image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Influxdb image was created successfully"

docker build -t grafanaimage ./srcs/grafana >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating grafana image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating grafana image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating grafana image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Grafana image was created successfully"

docker build -t mysqlimage ./srcs/MySQL >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating MySQL image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MySQL image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MySQL image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} MySQL image was created successfully"

docker build -t ftpsimage ./srcs/FTPS >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating FTPS image .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating FTPS image ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating FTPS image ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} FTPS image was created successfully"

# Creating MetalLB
echo -e "${Green}Installing MetalLB${NC}"

echo -ne "\r\033[0K⏱ Installing MetalLB ..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml >/dev/null
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml >/dev/null
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Installing MetalLB .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Installing MetalLB ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Installing MetalLB ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} MetalLB was installed successfully"


# Creating deployments
echo -e "${Green}**************************${NC}"
echo -e "${Green}*  Creating deployments  *${NC}"
echo -e "${Green}**************************${NC}"

kubectl apply -f ./srcs/metallb.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating MetalLB deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MetalLB deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MetalLB deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} MetalLB deployment was created successfully"

kubectl apply -f ./srcs/nginx.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating Nginx deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Nginx deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Nginx deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Nginx deployment was created successfully"

kubectl apply -f ./srcs/phpmyadmin.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating Phpmyadmin deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Phpmyadmin deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Phpmyadmin deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Phpmyadmin deployment was created successfully"

kubectl apply -f ./srcs/wordpress.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating Wordpress deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Wordpress deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Wordpress deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Wordpress deployment was created successfully"

kubectl apply -f ./srcs/influxdb.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating Influxdb deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Influxdb deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Influxdb deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Influxdb deployment was created successfully"

kubectl apply -f ./srcs/grafana.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating Grafana deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Grafana deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating Grafana deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} Grafana deployment was created successfully"

kubectl apply -f ./srcs/mysql.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating MySQL deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MySQL deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating MySQL deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} MySQL deployment was created successfully"

kubectl apply -f ./srcs/ftps.yaml >/dev/null &
PROC_ID=$!
while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    echo -ne "\r\033[0K⏱ Creating FTPS deployment .   \\"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating FTPS deployment ..  -"
    sleep 0.2
    echo -ne "\r\033[0K⏱ Creating FTPS deployment ... /"
    sleep 0.2
done
echo -e "\r\033[0K${CHECK_MARK} FTPS deployment was created successfully"


echo -e "${Green}**************************${NC}"
echo -e "${Green}**** Kubectl commands ****${NC}"
echo -e "${Green}**************************${NC}"
echo -e "${Blue}   ➡️ Kubectl get all${NC} ${Green}// show all cluster components${NC}"
echo -e "${Blue}   ➡️ Kubectl get pods${NC} ${Green}// show all pods${NC}"
echo -e "${Blue}   ➡️ Kubectl get services${NC} ${Green}// show all services${NC}"
echo -e "${Blue}   ➡️ Kubectl get deployments${NC} ${Green}// show all deployments${NC}"