# Provision.sh

Define the version of the software to install

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
