#!/bin/bash

# Caddy Installation Script for Ubuntu
# This script installs Caddy web server using the official repository

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root. Please run as a regular user with sudo privileges."
        exit 1
    fi
}

# Function to check if sudo is available
check_sudo() {
    if ! command -v sudo &> /dev/null; then
        print_error "sudo is required but not installed. Please install sudo first."
        exit 1
    fi
}

# Function to check Ubuntu version
check_ubuntu() {
    if [[ ! -f /etc/os-release ]]; then
        print_error "Cannot determine OS version. This script is designed for Ubuntu."
        exit 1
    fi
    
    . /etc/os-release
    if [[ "$ID" != "ubuntu" ]]; then
        print_warning "This script is designed for Ubuntu. Current OS: $ID"
        read -p "Do you want to continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Main installation function
install_caddy() {
    print_status "Starting Caddy installation..."
    
    # Update package list
    print_status "Updating package list..."
    sudo apt update
    
    # Install required packages
    print_status "Installing required packages..."
    sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
    
    # Add Caddy's GPG key
    print_status "Adding Caddy's GPG key..."
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    
    # Add Caddy repository
    print_status "Adding Caddy repository..."
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list > /dev/null
    
    # Update package list again
    print_status "Updating package list with new repository..."
    sudo apt update
    
    # Install Caddy
    print_status "Installing Caddy..."
    sudo apt install -y caddy
    
    # Start and enable Caddy service
    print_status "Starting and enabling Caddy service..."
    sudo systemctl start caddy
    sudo systemctl enable caddy
    
    print_success "Caddy installation completed!"
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    # Check if Caddy is installed
    if command -v caddy &> /dev/null; then
        CADDY_VERSION=$(caddy version)
        print_success "Caddy is installed: $CADDY_VERSION"
    else
        print_error "Caddy installation failed - command not found"
        return 1
    fi
    
    # Check service status
    if systemctl is-active --quiet caddy; then
        print_success "Caddy service is running"
    else
        print_warning "Caddy service is not running"
        print_status "Service status:"
        sudo systemctl status caddy --no-pager
    fi
    
    # Check if service is enabled
    if systemctl is-enabled --quiet caddy; then
        print_success "Caddy service is enabled (will start on boot)"
    else
        print_warning "Caddy service is not enabled"
    fi
}

# Function to show next steps
show_next_steps() {
    print_status "Installation complete! Here are your next steps:"
    echo
    echo "1. Configure Caddy by editing the Caddyfile:"
    echo "   sudo nano /etc/caddy/Caddyfile"
    echo
    echo "2. Reload Caddy after making changes:"
    echo "   sudo systemctl reload caddy"
    echo
    echo "3. Check Caddy logs:"
    echo "   sudo journalctl -u caddy -f"
    echo
    echo "4. Test Caddy configuration:"
    echo "   caddy validate --config /etc/caddy/Caddyfile"
    echo
    echo "5. Caddy documentation: https://caddyserver.com/docs/"
    echo
}

# Main execution
main() {
    echo "========================================"
    echo "       Caddy Installation Script        "
    echo "========================================"
    echo
    
    # Perform checks
    check_root
    check_sudo
    check_ubuntu
    
    # Ask for confirmation
    print_status "This script will install Caddy web server on your Ubuntu system."
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled."
        exit 0
    fi
    
    # Install Caddy
    install_caddy
    
    # Verify installation
    verify_installation
    
    # Show next steps
    show_next_steps
    
    print_success "All done! Caddy is now installed and running."
}

# Run main function
main "$@"