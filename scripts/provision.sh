#!/bin/bash
# remove comment if you want to enable debugging
#set -x
variables ()
{
. /vagrant_data/.env/.env
}
disable_swap () 
{
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
}

create_ssh_key ()
{
[[ ! -f ${HOME}/.ssh/mykey ]]
sudo mkdir -p ${HOME}/.ssh
sudo  ssh-keygen -f ${HOME}/.ssh/mykey -N ''
sudo chown -R ${USER}:${USER} ${HOME}/.ssh
# add ssh key to ssh-agent
sudo ssh-add ${HOME}/.ssh/mykey
eval "$(ssh-agent -s)"
}

install_dependencies ()
{
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
}

install_awscli ()
{
# install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
mkdir -p ${HOME}/.aws
cp -u ${AWS_CONFIG_FILE} ${HOME}/.aws/
cp -u ${AWS_SHARED_CREDENTIALS_FILE} ${HOME}/.aws/
./aws/install
rm -rf awscliv2.zip aws
}

clean_up ()
{
# clean up
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker
suudo apt-get autoremove -y
sudo apt-get clean
}

hashicorp_tools ()
{
#Terraform
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# Packer
wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
rm packer_${PACKER_VERSION}_linux_amd64.zip
# Vault
#wget -q https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
#unzip -o vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/local/bin
#rm vault_${VAULT_VERSION}_linux_amd64.zip
# Consul
#wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
#unzip -o consul_${CONSUL_VERSION}_linux_amd64.zip -d /usr/local/bin
#rm consul_${CONSUL_VERSION}_linux_amd64.zip
# Nomad
#wget -q https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
#unzip -o nomad_${NOMAD_VERSION}_linux_amd64.zip -d /usr/local/bin
#rm nomad_${NOMAD_VERSION}_linux_amd64.zip
}

variables
disable_swap
create_ssh_key
install_dependencies
install_awscli
clean_up
hashicorp_tools