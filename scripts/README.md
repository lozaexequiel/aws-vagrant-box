# Provision.sh

Variable imports from .env file

. /vagrant_data/.env/.env

Create new ssh key

[[ ! -f ${HOME}/.ssh/mykey ]]
mkdir -p ${HOME}/.ssh
ssh-keygen -f ${HOME}/.ssh/mykey -N ''
chown -R ${USER}:${USER} ${HOME}/.ssh
eval "$(ssh-agent -s)"

Add the following lines if you need to setup proxy settings for docker

~~~
mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://proxy:8080/"
Environment="HTTPS_PROXY=http://proxy:8080/"
Environment="NO_PROXY=localhost,
systemctl daemon-reload
systemctl restart docker
~~~

Install packages and upgrade system packages to latest version (optional)

~~~
apt-get update
apt-get install -y ${PACKAGES}
apt-get upgrade -y
~~~

Add docker privileges to user

```usermod -G docker ${USER}```

The following commands installs the awscli. To use awscli, you need to have a valid aws account and have the credentials file in the .env/.aws folder. For more information, see the README.md file in root directory.

~~~
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
mkdir -p ${HOME}/.aws
cp -u ${AWS_CONFIG_FILE} ${HOME}/.aws/
cp -u ${AWS_SHARED_CREDENTIALS_FILE} ${HOME}/.aws/
./aws/install
~~~

Clean up

~~~
systemctl daemon-reload
systemctl restart docker
apt-get autoremove -y
~~~

Terraform

~~~
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
~~~

Packer

~~~
wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
rm packer_${PACKER_VERSION}_linux_amd64.zip
~~~
