#!/bin/bash

# Redirect stdout and stderr to a log file
#exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update yum package lists
sudo yum update -y
echo "Yum packages updated successfully."

# Install Git
sudo yum install git -y

# Install Docker 
sudo yum install docker -y
if [ $? -eq 0 ]; then
  echo "Docker installed successfully."
else
  echo "Error installing Docker. Please check logs for details."
  exit 1
fi

# Start the Docker service
sudo systemctl start docker
echo "Docker service started successfully."

# Enable Docker to start automatically on boot
sudo systemctl enable docker
echo "Docker service enabled to start automatically on boot."

# Modify Docker socket permissions to grant access to the current user
sudo chmod 666 /var/run/docker.sock
if [ $? -eq 0 ]; then
  echo "Modified Docker socket permissions to grant access to the current user."
else
  echo "Error modifying Docker socket permissions."
fi

# Install Docker Compose (latest version)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo "Downloaded Docker Compose successfully."

# Make docker-compose executable
sudo chmod +x /usr/local/bin/docker-compose
echo "Docker Compose made executable."

# Verify Docker version
docker --version
echo "Docker version information displayed above."

# Verify Docker Compose version
docker-compose --version
echo "Docker Compose version information displayed above."
