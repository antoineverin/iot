#!/bin/sh

echo " * Creating k3d cluster"
k3d cluster create default -p 443:443 -p 8888:30010

echo " * Setuping argocd"
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -k patchs
kubectl apply -n argocd -f confs
kubectl config set-context --current --namespace=argocd

echo " * Waiting for argocd to come online"
sleep 160

echo " * Login in argocd"
argocd login --core

echo " * Creating app will-playground"
kubectl create ns dev
argocd app create will-playground --repo https://github.com/antoineverin/iot-app-acroue --path . --dest-server https://kubernetes.default.svc --sync-policy automated --dest-namespace dev

kubectl config set-context --current --namespace=default

echo " ! argocd password:"
argocd admin initial-password -n argocd
echo " * k3d setuped!"
