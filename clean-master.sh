#!/bin/bash

# Replace these variables with actual values
KUBEADM_RESET_CMD="sudo kubeadm reset"
UNINSTALL_CMD=""
CLEAN_DOCKER=false

# Function to uninstall Kubernetes packages
uninstall_kubernetes() {
    echo "Uninstalling Kubernetes packages..."
    $UNINSTALL_CMD
}

# Function to clean up Docker (if needed)
clean_docker() {
    if [ "$CLEAN_DOCKER" = true ]; then
        echo "Cleaning Docker..."
        sudo apt-get purge docker-ce docker-ce-cli containerd.io
        sudo rm -rf /var/lib/docker
    fi
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

# Drain master components if needed
if [ "$1" = "drain" ]; then
    echo "Draining the master node..."
    kubectl drain $(hostname) --delete-local-data --force --ignore-daemonsets
fi

echo "Resetting Kubeadm..."
$KUBEADM_RESET_CMD

uninstall_kubernetes

clean_docker

reset_iptables

remove_kube_config

echo "Master node unlinked and Kubernetes components removed."
