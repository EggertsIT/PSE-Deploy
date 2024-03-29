#!/bin/bash
# Script to install ZPA Private Service Edge

source /etc/os-release
OS_MAJOR_VERSION=$(echo $VERSION_ID | cut -d. -f1)
if [[ "$OS_MAJOR_VERSION" == "7" ]]; then
    echo -e "[zscaler]\nname=Zscaler Private Access Repository\nbaseurl=https://yum.private.zscaler.com/yum/el7\nenabled=1\ngpgcheck=1\ngpgkey=https://yum.private.zscaler.com/gpg" | sudo tee /etc/yum.repos.d/zscaler.repo
elif [[ "$OS_MAJOR_VERSION" == "8" ]]; then
    echo -e "[zscaler]\nname=Zscaler Private Access Repository\nbaseurl=https://yum.private.zscaler.com/yum/el8\nenabled=1\ngpgcheck=1\ngpgkey=https://yum.private.zscaler.com/gpg" | sudo tee /etc/yum.repos.d/zscaler.repo
else
    echo "Unsupported OS version: $VERSION_ID"
    exit 1
fi
sudo yum install -y zpa-service-edge
sudo systemctl stop zpa-service-edge
sudo touch /opt/zscaler/var/service-edge/provision_key
sudo chmod 644 /opt/zscaler/var/service-edge/provision_key
PROVISION_KEY="Your_Provision_Key"
echo $PROVISION_KEY | sudo tee /opt/zscaler/var/service-edge/provision_key
sudo systemctl start zpa-service-edge
sudo systemctl status zpa-service-edge

