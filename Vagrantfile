Vagrant.configure(2) do |config|
	config.vm.synced_folder ".", "/vagrant_data"
	config.vm.define "Dev" do |devVM|
		devVM.vm.box = "ubuntu/focal64"
    		devVM.vm.network "private_network", ip: "172.0.0.44"
    		devVM.vm.hostname = "Dev"
		devVM.vm.provision "shell", path: "scripts/provision.sh"
    		devVM.vm.provider "virtualbox" do |v|
    		  v.memory = 4096
    		  v.cpus = 2
    		end	
	end
end