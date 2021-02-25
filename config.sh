echo "Installing microk8s... "
sudo snap install microk8s --classic --channel=1.19
echo "Enabling required addons..."
microk8s enable  dns registry helm3
echo "Installing nginx-ingress controller..."
microk8s kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml
echo "Creating nginx website along with flinks namespace..."
microk8s kubectl create -f https://raw.githubusercontent.com/lenkasuresh/k8s/main/nginx.yaml
echo "Creating golang REST API app.."
microk8s kubectl create -f https://raw.githubusercontent.com/lenkasuresh/k8s/main/goapi.yaml
echo "Creating host based ingress objects..."
microk8s kubectl create -f https://raw.githubusercontent.com/lenkasuresh/k8s/main/ingress.yaml

echo "Resloving dns.. multiple approaches.. "
echo "$(microk8s.kubectl get svc nginx-service -n flinks --no-headers | cut -d ' ' -f7)  challenge.domain.local" >> /etc/hosts
echo "$(microk8s.kubectl get svc goapi-service -n flinks --no-headers | cut -d ' ' -f7)  challenge-api.domain.local" >> /etc/hosts

echo "Or we can edit nginx-ingress-controller service to loadbalancer IP & create DNS"
echo "Or we can edit configmap of coredns using 'microk8s kubectl -n kube-system edit configmap/coredns' & update domain.local as default searchserver"
