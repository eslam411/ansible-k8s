#!/bin/bash

# Function to uninstall Kubernetes packages
uninstall_kubernetes() {
    echo "Uninstalling Kubernetes packages..."
    sudo apt-get purge kubeadm kubelet kubectl kubernetes-cni
    sudo apt-get autoremove
}

# Function to clean up Docker
clean_docker() {
    echo "Cleaning Docker..."
    sudo apt-get purge docker-ce docker-ce-cli containerd.io
    sudo rm -rf /var/lib/docker
}

# Function to reset iptables rules
reset_iptables() {
    echo "Resetting iptables rules..."
    sudo iptables -F
    sudo iptables -t nat -F
    sudo iptables -t mangle -F
    sudo iptables -X
}

# Function to remove Kubernetes configuration
remove_kube_config() {
    echo "Removing Kubernetes configuration..."
    rm -rf $HOME/.kube/config
}

# Main script

# Get the node name from the user
read -p "Enter the node name to unlink and remove Kubernetes from: " NODE_NAME

echo "Draining the node..."
kubectl drain $NODE_NAME --delete-local-data --force --ignore-daemonsets

echo "Resetting Kubeadm..."
sudo kubeadm reset

uninstall_kubernetes

# Ask if Docker cleanup is required
read -p "Do you want to clean Docker as well? (y/n): " CLEAN_DOCKER
if [ "$CLEAN_DOCKER" == "y" ]; then
    clean_docker
fi

reset_iptables

remove_kube_config

echo "Node '$NODE_NAME' unlinked and Kubernetes components removed."
