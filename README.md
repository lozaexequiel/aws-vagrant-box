# Pre-requisites

- Vagrant
- Virtualbox
- Valid AWS credentials

Create a folder named ".env/.aws" in your project directory

Create a file named "credentials" in the ".env/.aws" folder

Add the following lines to the credentials file:

~~~
[default]
aws_access_key_id = <ACCESS_KEY>
aws_secret_access_key = <SECRET_KEY>
~~~

Create a file named "config" in the ".env/.aws" folder

Add the following lines to the config file:

~~~
[default]
region = <REGION>
output = json
~~~

Create a file name ".env" in your .env/ directory

Add the folowing lines to the .env file:

~~~
AWS_CONFIG_FILE=/vagrant_data/.env/.aws/config
AWS_SHARED_CREDENTIALS_FILE=/vagrant_data/.env/.aws/credentials
TERRAFORM_VERSION="1.2.8"
PACKER_VERSION="1.8.3"
USER=vagrant
HOME=/home/vagrant
PACKAGES="docker.io ansible unzip python3-pip docker-compose git"
~~~

The following is the folder structure of the configuration directories:

~~~
./
├── .env
│   ├── .aws
│   │   ├── config
│   │   └── credentials
│   └── .env
~~~

You can use an examples of the .env directory in the path:

```/examples/```


To initialize the project, run the following commands:

```vagrant up```

To enter the VM, run the following command:

```vagrant ssh```

To stop the VM (shutdown) run the following command:

```vagrant halt```

To reload the configuration of the VM, run the following command:

```vagrant reload```

To destroy the VM, run the following command:

```vagrant destroy```

To run the provision script, run the following command:

```vagrant provision```

To run the provision script without reloading the VM, run the following command:

```vagrant provision --provision-with shell```


# Vagrantfile explained

Configure a shared directory between the host machine and the VM

```config.vm.synced_folder ".", "/PATH/TO/SHARE""```

Defines the vm configurations

```config.vm.define "NAME" do |devVM|```

Setup the VM's OS image

```devVM.vm.box = "IMAGE_NAME"```

Configure the network, "public network" is similar to the "bridge" option, and "private network" is similar to the "host-only" option in Virtualbox

```devVM.vm.network "private_network", ip: "IP_ADDRESS"```

Setup the VM hostname

```devVM.vm.hostname = "HOSTNAME"```

Defines the provision script to run

```devVM.vm.provision "shell", path: "PATH/TO/SCRIPT"```

Defines the virtualization provider

```devVM.vm.provider "PROVIDER_NAME" do |v|```

Setup the VM memory

```v.memory = XXXX```

Setup the VM CPU

```v.cpus = X```

Script documentation in path:

```/scripts/README.md```

Vagrant full documentation can be found [here][vagrant].

[vagrant]: https://developer.hashicorp.com/vagrant/docs/
