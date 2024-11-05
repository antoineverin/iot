#!/bin/bash

MASTER_IP=$1
TOKEN=$(cat /vagrant/token)

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$TOKEN sh -
