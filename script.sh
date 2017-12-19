#!/bin/bash

# Clean up old versions of Docker
sudo apt-get remove docker docker-engine docker.io

sudo apt-get update

# Install some prerequisites
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add the Docker public GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update apt to get the latest packages, including Docker
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce

# Be sure to replace your-user with your Azure VM username
sudo usermod -aG docker your-user

# Log out and back in here

# Install OpenFaaS
mkdir dev
cd dev
git clone https://github.com/openfaas/faas
cd faas/
sudo ./deploy_stack.sh

# Test a default OpenFaaS function
curl localhost:8080/function/func_nodeinfo -d ''

# Install the OpenFaaS CLI
curl -sSL https://cli.openfaas.com | sudo sh
