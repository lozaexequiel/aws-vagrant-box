
# Provision.sh

# Set the REDHAT_BASED variable to use the yum commands

if [ -e /etc/redhat-release ] ; then
  REDHAT_BASED=true
fi

# Define the version of the software to install

TERRAFORM_VERSION="1.2.8"
PACKER_VERSION="1.8.3"
SPLIGHT_VERSION="0.1.0

# create new ssh key

[[ ! -f /home/ubuntu/.ssh/mykey ]] \

# Creates directory in home directory

 $ mkdir /home/ubuntu/.ssh 

# Generate the new key 

$ ssh-keygen -f /home/ubuntu/.ssh/mykey -N '' \

# Add the key to the ssh-agent

$ eval "$(ssh-agent -s)" 

# Give permissions to the key file to the ubuntu user
$chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# Scripts

Provissioning scripts for the VM.
~~~
Add the following lines if you need to setup proxy settings for docker
mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://proxy:8080/"
Environment="HTTPS_PROXY=http://proxy:8080/"
Environment="NO_PROXY=localhost,
systemctl daemon-reload
systemctl restart docker
~~~
