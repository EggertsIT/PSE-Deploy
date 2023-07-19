#!/bin/bash
# Script to install ZPA Private Service Edge

# Create and configure the yum repository
echo -e "[zscaler]\nname=Zscaler Private Access Repository\nbaseurl=https://yum.private.zscaler.com/yum/el7\nenabled=1\ngpgcheck=1\ngpgkey=https://yum.private.zscaler.com/gpg" | sudo tee /etc/yum.repos.d/zscaler.repo

# Install the ZPA service edge package
sudo yum install -y zpa-service-edge

# Stop the running ZPA Private Service Edge service
sudo systemctl stop zpa-service-edge

# Create a provisioning key file with 644 permissions
sudo touch /opt/zscaler/var/service-edge/provision_key
sudo chmod 644 /opt/zscaler/var/service-edge/provision_key

# Add your provisioning key here. It should be obtained from the ZPA Admin Portal
PROVISION_KEY="Your_Provision_Key"

# Write the provisioning key to the file
echo $PROVISION_KEY | sudo tee /opt/zscaler/var/service-edge/provision_key

# Start the zpa-service-edge service
sudo systemctl start zpa-service-edge

# check the zpa-service-edge service
sudo systemctl status zpa-service-edge
