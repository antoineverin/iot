#!/bin/bash

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -s -

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/token
