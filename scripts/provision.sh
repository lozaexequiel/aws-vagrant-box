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
# add docker privileges to user
usermod -G docker ${USER}
# install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
mkdir -p ${HOME}/.aws
cp -u ${AWS_CONFIG_FILE} ${HOME}/.aws/
cp -u ${AWS_SHARED_CREDENTIALS_FILE} ${HOME}/.aws/
./aws/install
# clean up
systemctl daemon-reload
systemctl restart docker
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