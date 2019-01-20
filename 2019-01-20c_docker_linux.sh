# Enter the following commands as a regular user

# Add current user to docker group
sudo usermod --groups=docker --append chris

# LOG OUT AND LOG IN

# Test
docker run hello-world