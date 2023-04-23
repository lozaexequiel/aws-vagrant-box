#!/bin/bash
# remove comment if you want to enable debugging
#set -x
# Variable imports
. /vagrant_data/.env/.env
# create new ssh key
[[ ! -f ${HOME}/.ssh/mykey ]]
mkdir -p ${HOME}/.ssh
ssh-keygen -f ${HOME}/.ssh/mykey -N ''
chown -R ${USER}:${USER} ${HOME}/.ssh
eval "$(ssh-agent -s)"
# install packages
apt-get update
apt-get install -y ${PACKAGES}
apt-get upgrade -y
# add docker privileges to user and configure docker
sudo usermod -G docker ${USER}
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
# install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
mkdir -p ${HOME}/.aws
cp -u ${AWS_CONFIG_FILE} ${HOME}/.aws/
cp -u ${AWS_SHARED_CREDENTIALS_FILE} ${HOME}/.aws/
./aws/install
# clean up
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker
apt-get autoremove -y
#Terraform
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# Packer
wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
rm packer_${PACKER_VERSION}_linux_amd64.zip
echo "Done!"