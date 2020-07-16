BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
SET='\033[0m'

if [ "$1" = 'delete' ]
then
	echo "${BLUE}${BOLD}Deleting services...${SET}"
	kubectl delete -k srcs
	echo "${RED}${BOLD}🗑️  All services deleted${SET}"
	exit
fi

# If minikube is not running, start it
if [ $(minikube status | grep -c "Running") == 0 ]
then
	minikube start --vm-driver=virtualbox
	minikube addons enable dashboard
fi

LIST_SERVICES='wordpress mysql'

# Point to Minikube's docker-daemon
eval $(minikube -p minikube docker-env)

# echo "${BLUE}${BOLD}Building Docker images...${SET}"
# for SERVICE in $LIST_SERVICES
# do
# 	echo "Building $SERVICE..."
# 	docker build -t $SERVICE srcs/$SERVICE
# 	echo "${GREEN}✅ $SERVICE built${SET}"
# done
# echo

echo "${BLUE}${BOLD}Deploying services...${SET}"
kubectl apply -k srcs
echo "${GREEN}${BOLD}✅ All services deployed${SET}"
echo



minikube ip
